import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/media_buttons.dart';
import 'package:eliud_pkg_feed/extensions/util/post_media_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_member.dart';
import 'package:eliud_pkg_feed/platform/medium_platform.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'bloc/feed_post_form_bloc.dart';
import 'bloc/feed_post_form_event.dart';
import 'bloc/feed_post_form_state.dart';
import 'bloc/feed_post_model_details.dart';

class FeedPostForm extends StatelessWidget {
  final String feedId;
  //final String parentPageId;
  final SwitchFeedHelper switchFeedHelper;
  final PostListPagedBloc postListPagedBloc;
  FeedPostForm({Key? key, required this.feedId, required this.switchFeedHelper, required this.postListPagedBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFeedPostForm(feedId, switchFeedHelper);
  }
}

class MyFeedPostForm extends StatefulWidget {
  final String feedId;
  //final String parentPageId;
  final SwitchFeedHelper switchFeedHelper;
  MyFeedPostForm(this.feedId, this.switchFeedHelper);

  _MyFeedPostFormState createState() => _MyFeedPostFormState();
}

class _MyFeedPostFormState extends State<MyFeedPostForm> {
  final DialogStateHelper dialogHelper = DialogStateHelper();
  final TextEditingController _descriptionController = TextEditingController();
  int? _postPrivilegeSelectedRadioTile;

  _MyFeedPostFormState();

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(_onDescriptionChanged);
    _postPrivilegeSelectedRadioTile = 0;
  }

  Widget _radioPrivilegeTile(
      String text, int value, FeedPostModelDetails feedPostModelDetails) {
    return Flexible(
      fit: FlexFit.loose,
      child: RadioListTile(
          value: value,
          groupValue: _postPrivilegeSelectedRadioTile,
          title: Text(text),
          onChanged: feedPostModelDetails.memberMedia.length == 0
              ? (dynamic value) {
                  _setPostSelectedRadioTile(value);
                }
              : null),
    );
  }

  Widget _rowAudience(FeedPostModelDetails feedPostModelDetails) {
    List<Widget> children = [];
    children.add(_radioPrivilegeTile('Public', 0, feedPostModelDetails));
    children.add(_radioPrivilegeTile('Followers', 1, feedPostModelDetails));
    children.add(_radioPrivilegeTile('Just Me', 2, feedPostModelDetails));
    return Row(children: children);
  }

  @override
  Widget build(BuildContext context) {
    var theState = AccessBloc.getState(context);
    if (theState is LoggedIn) {
      var pubMember = theState.memberPublicInfoModel;
      var app = AccessBloc.app(context);
      if (app == null) return Text('No app available');
      return BlocBuilder<FeedPostFormBloc, FeedPostFormState>(
          builder: (context, state) {
            return dialogHelper.build(
                dialogButtonPosition: DialogButtonPosition.TopRight,
                title: 'New Album',
                contents: _contents(context, state, app, pubMember, theState),
                buttons: dialogHelper.getYesNoButtons(context, () {
                  BlocProvider.of<FeedPostFormBloc>(context).add(SubmitPost());
                  Navigator.pop(context);
                }, () {
                  Navigator.pop(context);
                }, yesButtonLabel: "Ok", noButtonLabel: "Cancel"));
      });
    } else {
      return Text("Not logged in");
    }
  }

  Widget _contents(context, state, app, pubMember, theState) {
    if (state is FeedPostFormLoaded) {
      if (state.postModelDetails.description != null) {
        _descriptionController.text =
            state.postModelDetails.description.toString();
      } else {
        _descriptionController.text = "";
      }

      if (state.postModelDetails.postPrivilege != null)
        _postPrivilegeSelectedRadioTile =
            state.postModelDetails.postPrivilege.index;
      else
        _postPrivilegeSelectedRadioTile = 0;
    }
    if (state is FeedPostFormInitialized) {
      List<Widget> rows = [];
      rows.add(_row1(app, pubMember, state, theState));
      if ((state is SubmittableFeedPostFormWithMediumUploading) ||
          ((state.postModelDetails.memberMedia != null) &&
              (state.postModelDetails.memberMedia.isNotEmpty))) {
        rows.add(_row2(state));
        rows.add(PostMediaHelper.videoAndPhotoDivider(context));
      }
      rows.add(_rowAudience(state.postModelDetails));
//          return PostHelper.getFormattedPost(rows);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      );

    } else {
      return Center(child: DelayedCircularProgressIndicator());
    }
  }

  Widget _row1(AppModel app, MemberPublicInfoModel member,
      FeedPostFormInitialized state, LoggedIn accessState) {
    var avatar = widget.switchFeedHelper.gestured(context, member.documentID!, AvatarHelper.avatar(context, 60, widget.switchFeedHelper.pageId, member, app.documentID!, widget.feedId, ));
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
      _mediaButtons(context, app, state, member.documentID!),
    ]);

  }

  void _photoUploading(double progress) {
    BlocProvider.of<FeedPostFormBloc>(context).add(UploadingMedium(progress: progress));
    setState(() {});
  }

  void _videoUploading(double progress) {
    BlocProvider.of<FeedPostFormBloc>(context).add(UploadingMedium(progress: progress));
    setState(() {});
  }

  PopupMenuButton _mediaButtons(BuildContext context, AppModel app,
      FeedPostFormInitialized state, String memberId) {
    List<String> readAccess = state.postModelDetails.readAccess;

    return MediaButtons.mediaButtons(
        context,
        app.documentID!,
        memberId,
        readAccess,
        tooltip: 'Add video or photo',
        photoFeedbackFunction: (photo) {
          var memberMedia = state.postModelDetails.memberMedia;
          memberMedia.add(photo);
          BlocProvider.of<FeedPostFormBloc>(context).add(ChangedMedia(memberMedia: memberMedia));
        },
        photoFeedbackProgress: _photoUploading,
        videoFeedbackFunction: (video) {
          var memberMedia = state.postModelDetails.memberMedia;
          memberMedia.add(video);
          BlocProvider.of<FeedPostFormBloc>(context).add(ChangedMedia(memberMedia: memberMedia));
        },
        videoFeedbackProgress: _videoUploading);
  }

  Widget _row2(FeedPostFormInitialized state) {
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
      BlocProvider.of<FeedPostFormBloc>(context).add(ChangedMedia(memberMedia: memberMedia));
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
/*

  Widget _row3(FeedPostFormInitialized state) {
    return PostMediaHelper.staggeredVideosWithThumbnail(
        state.postModelDetails.videoWithThumbnails, deleteAction: (index) {
      var videos = state.postModelDetails.videoWithThumbnails;
      videos.removeAt(index);
      _myFormBloc.add(ChangedFeedVideos(videoWithThumbnails: videos));
    }, viewAction: (index) {
      var videos = state.postModelDetails.videoWithThumbnails;
      var medium = videos[index];
      AbstractMediumPlatform.platform!.showVideo(context, medium);
    });
  }
*/

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
//        contentPadding: EdgeInsets.all(8),
      ),
      validator: (_) {
        return state is DescriptionFeedPostFormError ? state.message : null;
      },
    );
  }

  void _onDescriptionChanged() {
    BlocProvider.of<FeedPostFormBloc>(context)
        .add(ChangedFeedPostDescription(value: _descriptionController.text));
  }

  void _setPostSelectedRadioTile(int? val) {
    if (val != null) {
      setState(() {
        _postPrivilegeSelectedRadioTile = val;
      });
      BlocProvider.of<FeedPostFormBloc>(context).add(ChangedFeedPostPrivilege(value: toPostPrivilege(val)));
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
