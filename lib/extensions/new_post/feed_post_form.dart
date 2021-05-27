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
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/post_media_helper.dart';
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
          create: (context) =>
          FeedPostFormBloc(
            app.documentID!,
            BlocProvider.of<PostListPagedBloc>(context),
            memberPublicInfoModel,
            feedId,
            theState
          )
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

  Widget _radioPrivilegeTile(String text, int value) {
    return Flexible(
      fit: FlexFit.loose,
      child: RadioListTile(
        value: value,
        groupValue: _postPrivilegeSelectedRadioTile,
        title: Text(text),
        onChanged: (dynamic value) {
          _setPostSelectedRadioTile(value);
        },
      ),
    );
  }

  Widget _rowAudience() {
    List<Widget> children = [];
    children.add(_radioPrivilegeTile('Public', 0));
    children.add(_radioPrivilegeTile('Followers', 1));
    children.add(_radioPrivilegeTile('Just Me', 2));
    return Row(children: children);
  }

  Future<void> _addPost(
      BuildContext context,
      FeedPostModelDetails feedPostModelDetails,
      MemberPublicInfoModel member,
      AppModel app,
      LoggedIn accessState) async {

    _myFormBloc
        .add(SubmitPost());
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
          if (state is UploadingPostForm) {
            rows.add(Text("Uploading: " + state.percentageFinished.toString() + " %"));
          } else {
            rows.add(_row1(app, pubMember, state, theState));
          }
          if ((state.postModelDetails.photoWithThumbnails != null) &&
              (state.postModelDetails.photoWithThumbnails.isNotEmpty)) {
            rows.add(_row2(state));
            rows.add(PostMediaHelper.videoAndPhotoDivider(context));
          }
          if ((state.postModelDetails.videoWithThumbnails != null) &&
              (state.postModelDetails.videoWithThumbnails.isNotEmpty)) {
            rows.add(_row3(state));
            rows.add(PostMediaHelper.videoAndPhotoDivider(context));
          }
          rows.add(_rowAudience());
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
              onPressed: () => _addPost(
                  context, state.postModelDetails, member, app, accessState))),
    ]);
  }

  PopupMenuButton _mediaButtons(BuildContext context, AppModel app,
      FeedPostFormInitialized state, String memberId) {
    return PostHelper.mediaButtons(context, (photoWithThumbnail) {
      var photoWithDetails = state.postModelDetails.photoWithThumbnails;
      photoWithDetails.add(photoWithThumbnail);
      _myFormBloc.add(ChangedFeedPhotos(photoWithThumbnails: photoWithDetails));
    }, (videoWithThumbnail) {
      var videoWithThumbnails = state.postModelDetails.videoWithThumbnails;
      videoWithThumbnails.add(videoWithThumbnail);
      _myFormBloc
          .add(ChangedFeedVideos(videoWithThumbnails: videoWithThumbnails));
    });
  }

  Widget _row2(FeedPostFormInitialized state) {
    return PostMediaHelper.staggeredPhotosWithThumbnail(
        state.postModelDetails.photoWithThumbnails, deleteAction: (index) {
      var photos = state.postModelDetails.photoWithThumbnails;
      photos.removeAt(index);
      _myFormBloc.add(ChangedFeedPhotos(photoWithThumbnails: photos));
    }, viewAction: (index) {
      var photos = state.postModelDetails.photoWithThumbnails;
      AbstractMediumPlatform.platform!.showPhotos(context, photos, index);
    });
  }

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
