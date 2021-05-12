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

import 'dart:io';

import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/platform/storage_platform.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_core/tools/storage/firestore_helper.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/tools/grid/photos_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:eliud_pkg_feed/model/embedded_component.dart';
import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/model/post_form_bloc.dart';
import 'package:eliud_pkg_feed/model/post_form_state.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

  _MyFeedPostFormState();

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<FeedPostFormBloc>(context);
    _descriptionController.addListener(_onDescriptionChanged);
  }

  void _addPost(
      BuildContext context, FeedPostModelDetails feedPostModelDetails) {
    // Here we need to tell the form block OR the list bloc to upload the PostModelDetail
    // then We need to use something like this to upload the media...
    /*var memberImageModel = await UploadFile.createThumbnailUploadVideoFile(widget.appId!, path, widget.memberId!, widget.readAccess!);
    media.add(
        PostMediumModel(documentID: newRandomKey(), memberMedium: memberImageModel)
    );
    _myFormBloc.add(ChangedFeedPostMemberMedia(value: media));

    then we need to create the post itself, perhaps something like this
    if ((_descriptionController.text != null) &&
        (_descriptionController.text.length > 0)) {
      postModel = postModel!.copyWith(description: _descriptionController.text);

      BlocProvider.of<PostListPagedBloc>(context)
          .add(AddPostPaged(value: postModel));
      _descriptionController.clear();
    }
    */
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
        }
        if (state is FeedPostFormInitialized) {
          List<Widget> rows = [];
          rows.add(_row1(app, pubMember, state));
          if ((state.postModelDetails.mediumAndItsThumbnailDatas != null) &&
              (state.postModelDetails.mediumAndItsThumbnailDatas.isNotEmpty))
            rows.add(_row2(state));
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
      FeedPostFormInitialized state) {
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
              onPressed: () => _addPost(context, state.postModelDetails))),
    ]);
  }

  PopupMenuButton _mediaButtons(BuildContext context, AppModel app,
      FeedPostFormInitialized state, String memberId) {
    return PopupMenuButton(
        color: Colors.red,
        icon: Icon(
          Icons.add,
        ),
        itemBuilder: (_) => <PopupMenuItem<int>>[
          new PopupMenuItem<int>(
              child: const Text('Take photo'), value: 0),
          new PopupMenuItem<int>(
              child: const Text('Upload photo'), value: 1),
            ],
        onSelected: (choice) {
          if (choice == 0) {
            AbstractStoragePlatform.platform!
                .takePhoto(context, app.documentID, (mediumAndItsThumbnailData) {
              var mediumAndItsThumbnailDatas = state.postModelDetails.mediumAndItsThumbnailDatas;
              mediumAndItsThumbnailDatas.add(mediumAndItsThumbnailData);
              _myFormBloc.add(ChangedFeedPostMemberMedia(mediumAndItsThumbnailDatas: mediumAndItsThumbnailDatas));
            }, memberId);
          }
          if (choice == 1) {
            AbstractStoragePlatform.platform!
                .uploadPhoto(context, app.documentID, (mediumAndItsThumbnailData) {
              var mediumAndItsThumbnailDatas = state.postModelDetails.mediumAndItsThumbnailDatas;
              mediumAndItsThumbnailDatas.add(mediumAndItsThumbnailData);
              _myFormBloc.add(ChangedFeedPostMemberMedia(mediumAndItsThumbnailDatas: mediumAndItsThumbnailDatas));
            }, memberId);
          }
        });
  }

  @override
  Widget staggered(List<MediumAndItsThumbnailData> mediumAndItsThumbnailDatas) {
    List<Widget> widgets = [];
    for (int i = 0; i < mediumAndItsThumbnailDatas!.length; i++) {
      var image = Image.file(File(mediumAndItsThumbnailDatas![i].thumbNailData!.filePath!));

      widgets.add(PopupMenuButton(
          color: Colors.red,
          child: image,
          itemBuilder: (_) => [
                new PopupMenuItem<int>(child: const Text('Delete'), value: 0),
              ],
          onSelected: (choice) {
            if (choice == 0) {
              mediumAndItsThumbnailDatas.removeAt(i);
              _myFormBloc.add(ChangedFeedPostMemberMedia(mediumAndItsThumbnailDatas: mediumAndItsThumbnailDatas));
            }
          }));
    }
    return Container(
        height: 300,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver:
                  SliverGrid.extent(maxCrossAxisExtent: 300, children: widgets, mainAxisSpacing: 5),
            ),
          ],
        ));
  }

  Widget _row2(FeedPostFormInitialized state) {
    return staggered(state.postModelDetails.mediumAndItsThumbnailDatas);
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

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
