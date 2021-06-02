import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/post_media_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_feed/platform/medium_platform.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'bloc/feed_post_form_bloc.dart';
import 'bloc/feed_post_form_event.dart';
import 'bloc/feed_post_form_state.dart';
import 'bloc/feed_post_model_details.dart';

class FeedPostDialog extends StatefulWidget {
  final String feedId;
  final SwitchFeedHelper switchFeedHelper;
  final PostListPagedBloc postListPagedBloc;

  FeedPostDialog(
      {Key? key, required this.switchFeedHelper, required this.feedId, required this.postListPagedBloc})
      : super(key: key);

  static void open(
      BuildContext context, String feedId, SwitchFeedHelper switchFeedHelper) {
    var postListPagedBloc = BlocProvider.of<PostListPagedBloc>(context);
    DialogStatefulWidgetHelper.openIt(context,
        FeedPostDialog(feedId: feedId, switchFeedHelper: switchFeedHelper, postListPagedBloc: postListPagedBloc,));
  }

  @override
  _FeedPostDialogState createState() => _FeedPostDialogState(postListPagedBloc);
}

class _FeedPostDialogState extends State<FeedPostDialog> {
  final DialogStateHelper dialogHelper = DialogStateHelper();
  final TextEditingController _descriptionController = TextEditingController();
  int? _postPrivilegeSelectedRadioTile;
  final PostListPagedBloc postListPagedBloc;

  _FeedPostDialogState(this.postListPagedBloc);

  @override
  Widget build(BuildContext context) {
    var theState = AccessBloc.getState(context);
    if (theState is LoggedIn) {
      var pubMember = theState.memberPublicInfoModel;

      var app = AccessBloc.app(context);
      if (app == null) return Text("No app available");
      var _myFormBloc = FeedPostFormBloc(
          app.documentID!,
          postListPagedBloc,
          pubMember,
          widget.feedId,
          theState)
        ..add(InitialiseNewFeedPostFormEvent());
      return BlocProvider<FeedPostFormBloc>(
          create: (context) => _myFormBloc,
          child: dialogHelper.build(
              dialogButtonPosition: DialogButtonPosition.TopRight,
              title: 'New post',
              contents: BlocBuilder<FeedPostFormBloc, FeedPostFormState>(
                  builder: (context, state) {
                _myFormBloc = BlocProvider.of<FeedPostFormBloc>(context);
                if (state is FeedPostFormLoaded) {
                  if (state.postModelDetails.description != null) {
                    _descriptionController.text =
                        state.postModelDetails.description.toString();
                  } else {
                    _descriptionController.text = "";
                  }

                  if (state.postModelDetails!.postPrivilege != null)
                    _postPrivilegeSelectedRadioTile =
                        state.postModelDetails!.postPrivilege!.index;
                  else
                    _postPrivilegeSelectedRadioTile = 0;
                }
                if (state is FeedPostFormInitialized) {
                  List<Widget> rows = [];
                  rows.add(_row1(app, pubMember, state, theState, _myFormBloc));
                  if ((state is SubmittableFeedPostFormWithMediumUploading) ||
                      ((state.postModelDetails.memberMedia != null) &&
                          (state.postModelDetails.memberMedia!.isNotEmpty))) {
                    rows.add(_row2(state, _myFormBloc));
                    rows.add(PostMediaHelper.videoAndPhotoDivider(context));
                  }
                  rows.add(_rowAudience(state.postModelDetails, _myFormBloc));
//                  return PostHelper.getFormattedPost(rows);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rows,
                  );
                } else {
                  return Center(child: DelayedCircularProgressIndicator());
                }
              }),
              buttons: dialogHelper.getYesNoButtons(context, () {
                _myFormBloc.add(SubmitPost());
                Navigator.pop(context);
              }, () {
                Navigator.pop(context);
              }, yesButtonLabel: "Ok", noButtonLabel: "Cancel")));
    } else {
      return Text("Not logged in");
    }
  }

  Widget _radioPrivilegeTile(
      String text, int value, FeedPostModelDetails feedPostModelDetails, _myFormBloc) {
    return Flexible(
      fit: FlexFit.loose,
      child: RadioListTile(
          value: value,
          groupValue: _postPrivilegeSelectedRadioTile,
          title: Text(text),
          onChanged: feedPostModelDetails.memberMedia.length == 0
              ? (dynamic value) {
                  _setPostSelectedRadioTile(value, _myFormBloc);
                }
              : null),
    );
  }

  Widget _rowAudience(FeedPostModelDetails feedPostModelDetails, _myFormBloc) {
    List<Widget> children = [];
    children.add(_radioPrivilegeTile('Public', 0, feedPostModelDetails, _myFormBloc));
    children.add(_radioPrivilegeTile('Followers', 1, feedPostModelDetails, _myFormBloc));
    children.add(_radioPrivilegeTile('Just Me', 2, feedPostModelDetails, _myFormBloc));
    return Row(children: children);
  }

  Widget _row1(AppModel app, MemberPublicInfoModel member,
      FeedPostFormInitialized state, LoggedIn accessState, _myFormBloc) {
    var avatar = widget.switchFeedHelper
        .gestured(context, member.documentID!, AvatarHelper.avatar(member));
    return Row(children: [
      Container(
          height: 60, width: 60, child: avatar == null ? Container() : avatar),
      Container(width: 8),
      Flexible(
        child: Container(
            alignment: Alignment.center,
            height: 30,
            child: _textField(app, state)),
      ),
      Container(width: 8),
      _mediaButtons(context, app, state, member.documentID!, _myFormBloc),
    ]);
  }

  void _photoUploading(double progress, _myFormBloc) {
    _myFormBloc.add(UploadingMedium(progress: progress));
    setState(() {});
  }

  void _videoUploading(double progress, _myFormBloc) {
    _myFormBloc.add(UploadingMedium(progress: progress));
    setState(() {});
  }

  PopupMenuButton _mediaButtons(BuildContext context, AppModel app,
      FeedPostFormInitialized state, String memberId, _myFormBloc) {
    List<String> readAccess = state.postModelDetails.readAccess;

    return PostHelper.mediaButtons(
        context,
        app.documentID!,
        memberId,
        readAccess,
        (photo) {
          var memberMedia = state.postModelDetails.memberMedia;
          memberMedia.add(photo);
          _myFormBloc.add(ChangedMedia(memberMedia: memberMedia));
        },
        (progress) => _photoUploading(progress, _myFormBloc),
        (video) {
          var memberMedia = state.postModelDetails.memberMedia;
          memberMedia.add(video);
          _myFormBloc.add(ChangedMedia(memberMedia: memberMedia));
        },
        (progress) => _videoUploading(progress, _myFormBloc));
  }

  Widget _row2(FeedPostFormInitialized state, _myFormBloc) {
    double? progressValue;
    if (state is SubmittableFeedPostFormWithMediumUploading) {
      progressValue = state.progress;
    }
    return PostMediaHelper.staggeredMemberMediumModel(
        state.postModelDetails.memberMedia,
        progressLabel: 'Uploading...',
        progressExtra: progressValue, deleteAction: (index) {
      var memberMedia = state.postModelDetails.memberMedia;
      memberMedia.removeAt(index);
      _myFormBloc.add(ChangedMedia(memberMedia: memberMedia));
    }, viewAction: (index) {
      var medium = state.postModelDetails.memberMedia[index];
      if (medium.mediumType == MediumType.Photo) {
        var photos = state.postModelDetails.memberMedia;
        AbstractMediumPlatform.platform!.showPhotos(context, photos, index);
      } else {
        AbstractMediumPlatform.platform!.showVideo(context, medium);
      }
    });
  }

  Widget _textField(
    AppModel app,
    FeedPostFormInitialized state,
  ) {
    return TextFormField(
      readOnly: false,
      controller: _descriptionController,
      keyboardType: TextInputType.text,
      autovalidate: true,
      decoration: InputDecoration(
        hintText: 'Say something...',
        hintStyle: TextStyle(fontSize: 16),
      ),
      validator: (_) {
        return state is DescriptionFeedPostFormError ? state.message : null;
      },
    );
  }

  void _onDescriptionChanged() {
    //_myFormBloc.add(ChangedFeedPostDescription(value: _descriptionController.text));
  }

  void _setPostSelectedRadioTile(int? val, _myFormBloc) {
    if (val != null) {
      setState(() {
        _postPrivilegeSelectedRadioTile = val;
      });
      _myFormBloc.add(ChangedFeedPostPrivilege(value: toPostPrivilege(val!)));
    }
  }

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(_onDescriptionChanged);
    _postPrivilegeSelectedRadioTile = 0;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
