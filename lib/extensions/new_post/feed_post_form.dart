/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/post_media_helper.dart';
import 'package:eliud_pkg_feed/model/post_form_event.dart';
import 'package:eliud_pkg_feed/platform/medium_platform.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:eliud_core/tools/enums.dart';
import 'package:transparent_image/transparent_image.dart';

import 'bloc/feed_post_form_bloc.dart';
import 'bloc/feed_post_form_event.dart';
import 'bloc/feed_post_form_state.dart';
import 'bloc/feed_post_model_details.dart';

class FeedPostForm extends StatelessWidget {
  final String feedId;
  FeedPostForm({Key? key, required this.feedId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theState = AccessBloc.getState(context);
    if (theState is LoggedIn) {
      var memberPublicInfoModel = theState.memberPublicInfoModel;
      var app = AccessBloc.app(context);
      if (app == null) return Text("No app available");
      return BlocProvider<FeedPostFormBloc>(
          create: (context) => FeedPostFormBloc(
              app.documentID!,
              BlocProvider.of<PostListPagedBloc>(context),
              memberPublicInfoModel,
              feedId,
              theState)
            ..add(InitialiseNewFeedPostFormEvent()),
          child: MyFeedPostForm(feedId));
    } else {
      return Text("Not logged in");
    }
  }
}

class MyFeedPostForm extends StatefulWidget {
  final String feedId;
  MyFeedPostForm(this.feedId);

  _MyFeedPostFormState createState() => _MyFeedPostFormState();
}

class _MyFeedPostFormState extends State<MyFeedPostForm> {
  late FeedPostFormBloc _myFormBloc;

  final TextEditingController _descriptionController = TextEditingController();
  int? _postPrivilegeSelectedRadioTile;

  _MyFeedPostFormState();

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<FeedPostFormBloc>(context);
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
          rows.add(_row1(app, pubMember, state, theState));
          if ((state is SubmittableFeedPostFormWithMediumUploading) ||
              ((state.postModelDetails.memberMedia != null) &&
                  (state.postModelDetails.memberMedia!.isNotEmpty))) {
            rows.add(_row2(state));
            rows.add(PostMediaHelper.videoAndPhotoDivider(context));
          }
          rows.add(_rowAudience(state.postModelDetails));
          return PostHelper.getFormattedPost(rows);
        } else {
          return Center(child: DelayedCircularProgressIndicator());
        }
      });
    } else {
      return Text("Not logged in");
    }
  }

  Widget _row1(AppModel app, MemberPublicInfoModel member,
      FeedPostFormInitialized state, LoggedIn accessState) {
    var avatar;
    if (member.photoURL == null) {
      avatar = Text("No avatar for this author");
    } else {
      avatar = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: member.photoURL!,
      );
    }
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
      Container(width: 8),
      Container(
          height: 30,
          child: RaisedButton(
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text('Ok'),
              onPressed: () => _myFormBloc.add(SubmitPost()))),
    ]);
  }

  void _photoUploading(double progress) {
    _myFormBloc.add(UploadingMedium(progress: progress));
    setState(() {});
  }

  void _videoUploading(double progress) {
    _myFormBloc.add(UploadingMedium(progress: progress));
    setState(() {});
  }

  PopupMenuButton _mediaButtons(BuildContext context, AppModel app,
      FeedPostFormInitialized state, String memberId) {
    // todo
    List<String> readAccess = [memberId];

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
        _photoUploading,
        (video) {
          var memberMedia = state.postModelDetails.memberMedia;
          memberMedia.add(video);
          _myFormBloc.add(ChangedMedia(memberMedia: memberMedia));
        },
        _videoUploading);
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
    _myFormBloc
        .add(ChangedFeedPostDescription(value: _descriptionController.text));
  }

  void _setPostSelectedRadioTile(int? val) {
    if (val != null) {
      setState(() {
        _postPrivilegeSelectedRadioTile = val;
      });
      _myFormBloc.add(ChangedFeedPostPrivilege(value: toPostPrivilege(val!)));
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
