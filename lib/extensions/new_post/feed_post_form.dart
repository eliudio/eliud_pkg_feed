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
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
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
    var app = AccessBloc.app(context);
    if (app == null) return Text("No app available");
    return BlocProvider<FeedPostFormBloc>(
        create: (context) => FeedPostFormBloc(
              app.documentID,
              formAction: FormAction.AddAction,
            )..add(InitialiseNewFeedPostFormEvent()),
        child: MyFeedPostForm(feedId));
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
      child:
      RadioListTile(
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

  Future<void> _addPost(BuildContext context, FeedPostModelDetails feedPostModelDetails,
      MemberPublicInfoModel member, AppModel app, LoggedIn accessState) async {
    // The uploading of the data is to be done in a bloc and we need to feedback updates to the gui on several intervals
    // We need to be able to cancel the upload as well
    List<String> readAccess = await PostFollowersHelper.as(feedPostModelDetails.postPrivilege, app.documentID!, accessState);
    List<PostMediumModel> memberMedia = [];

    for (PhotoWithThumbnail photoWithThumbnail in feedPostModelDetails.photoWithThumbnails) {
      var memberMediumModel = await MemberMediumHelper.uploadPhotoWithThumbnail(
        app.documentID!,
        photoWithThumbnail,
        member.documentID!,
        readAccess,
      );
      memberMedia.add(PostMediumModel(
          documentID: newRandomKey(),
          memberMedium: memberMediumModel
      ));
    }

    for (VideoWithThumbnail videoWithThumbnail in feedPostModelDetails.videoWithThumbnails) {
      var memberMediumModel = await MemberMediumHelper.uploadVideoWithThumbnail(
        app.documentID!,
        videoWithThumbnail,
        member.documentID!,
        readAccess,
      );
      memberMedia.add(PostMediumModel(
          documentID: newRandomKey(),
          memberMedium: memberMediumModel
      ));
    }

    PostModel postModel = PostModel(
        documentID: newRandomKey(),
        author: member,
        appId: app.documentID,
        feedId: widget.feedId,
        description: feedPostModelDetails.description,
        likes: 0,
        dislikes: 0,
        readAccess: ['PUBLIC'], // todo!
        archived: PostArchiveStatus.Active,
        memberMedia: memberMedia);

    BlocProvider.of<PostListPagedBloc>(context)
        .add(AddPostPaged(value: postModel));
    _descriptionController.clear();
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.black,
      indent: MediaQuery.of(context).size.width * 0.1,
      endIndent: MediaQuery.of(context).size.width * 0.1,
    );
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
            _postPrivilegeSelectedRadioTile = state.postModelDetails!.postPrivilege!.index;
          else
            _postPrivilegeSelectedRadioTile = 0;

        }
        if (state is FeedPostFormInitialized) {
          List<Widget> rows = [];
          rows.add(_row1(app, pubMember, state, theState));
          if ((state.postModelDetails.photoWithThumbnails != null) &&
              (state.postModelDetails.photoWithThumbnails.isNotEmpty)) {
            rows.add(_row2(state));
            rows.add(_divider());
          }
          if ((state.postModelDetails.videoWithThumbnails != null) &&
              (state.postModelDetails.videoWithThumbnails.isNotEmpty)) {
            rows.add(_row3(state));
            rows.add(_divider());
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
              onPressed: () =>
                  _addPost(context, state.postModelDetails, member, app, accessState))),
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

  static int POPUP_MENU_DELETE_VALUE = 0;
  static int POPUP_MENU_VIEW = 1;

  @override
  Widget _staggered(List<MediumBase> media) {
    List<Widget> widgets = [];
    for (int i = 0; i < media.length; i++) {
      var medium = media[i];
      var image, name;
      if (medium is PhotoWithThumbnail) {
        image = Image.memory(medium.thumbNailData.data);
        name = medium.photoData.baseName;
      } else if (medium is VideoWithThumbnail) {
        image = Image.memory(medium.thumbNailData.data);
        name = medium.videoData.baseName;
      } else {
        image = Icons.error;
        name = '?';
      }

      widgets.add(PopupMenuButton(
          color: Colors.red,
          tooltip: name,
          child: image,
          itemBuilder: (_) => [
                new PopupMenuItem<int>(
                    child: const Text('View'), value: POPUP_MENU_VIEW),
                new PopupMenuItem<int>(
                    child: const Text('Delete'),
                    value: POPUP_MENU_DELETE_VALUE),
              ],
          onSelected: (choice) {
            if (choice == POPUP_MENU_DELETE_VALUE) {
              media.removeAt(i);
              if (medium is PhotoWithThumbnail) {
                _myFormBloc.add(ChangedFeedPhotos(
                    photoWithThumbnails: media as List<PhotoWithThumbnail>));
              } else if (medium is VideoWithThumbnail) {
                _myFormBloc.add(ChangedFeedVideos(
                    videoWithThumbnails: media as List<VideoWithThumbnail>));
              }
            }
            if (choice == POPUP_MENU_VIEW) {
              if (medium is PhotoWithThumbnail) {
                AbstractMediumPlatform.platform!
                    .showPhotos(context, media as List<PhotoWithThumbnail>, i);
              } else if (medium is VideoWithThumbnail) {
                AbstractMediumPlatform.platform!.showVideo(context, medium);
              }
            }
          }));
    }
    return Container(
        height: 200,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: SliverGrid.extent(
                  maxCrossAxisExtent: 200,
                  children: widgets,
                  mainAxisSpacing: 10),
            ),
          ],
        ));
  }

  Widget _row2(FeedPostFormInitialized state) {
    return _staggered(state.postModelDetails.photoWithThumbnails);
  }

  Widget _row3(FeedPostFormInitialized state) {
    return _staggered(state.postModelDetails.videoWithThumbnails);
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
