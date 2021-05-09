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
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:eliud_pkg_feed/model/embedded_component.dart';
import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/model/post_form_bloc.dart';
import 'package:eliud_pkg_feed/model/post_form_state.dart';
import 'package:transparent_image/transparent_image.dart';

import 'bloc/feed_post_form_bloc.dart';
import 'bloc/feed_post_form_event.dart';

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

  void _addPost(BuildContext context, PostModel? postModel) {
    if ((_descriptionController.text != null) &&
        (_descriptionController.text.length > 0)) {
      postModel = postModel!.copyWith(description: _descriptionController.text);

      BlocProvider.of<PostListPagedBloc>(context)
          .add(AddPostPaged(value: postModel));
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theState = AccessBloc.getState(context);
    if (theState is LoggedIn) {
      var pubMember = theState.memberPublicInfoModel;
      var app = AccessBloc.app(context);
      if (app == null) return Text('No app available');
      return BlocBuilder<PostFormBloc, PostFormState>(
          builder: (context, state) {
        if (state is PostFormLoaded) {
          if (state.value!.description != null) {
            _descriptionController.text = state.value!.description.toString();
          } else {
            _descriptionController.text = "";
          }
        }
        if (state is PostFormInitialized) {
          List<Widget> rows = [];
          rows.add(_row1(app, pubMember, state));
          if ((state.value!.memberMedia != null) && (state.value!.memberMedia!.isNotEmpty))
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

  Widget _row1(
      AppModel app, MemberPublicInfoModel member, PostFormInitialized state) {
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
            alignment: Alignment.center, height: 30, child: _textField(app, state)),
      ),
      Container(width: 8),
      PostHelper.mediaButtons(context, state.value, member.documentID!, _photoAvailable),
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
                  context,
                  PostModel(
                    documentID: newRandomKey(),
                    author: member,
                    timestamp: "Just now",
                    appId: app.documentID,
                    feedId: widget.feedId,
                    postAppId: null,
                    postPageId: null,
                    pageParameters: null,
                    description: state.value!.description,
                    likes: 0,
                    dislikes: 0,
                    readAccess: [ 'PUBLIC', member.documentID! ],
                    archived: state.value!.archived,
                    externalLink: state.value!.externalLink,
                    memberMedia: state.value!.memberMedia,
                  )))),
    ]);
  }

  Widget _row2(PostFormInitialized state) {
    return Row(children: [
      Container(
          height: (fullScreenHeight(context) / 2.5),
          child: postMediumsList(
              context, state.value!.memberMedia, _onMemberMediaChanged))
    ]);
  }

  Widget _textField(AppModel app, PostFormInitialized state,) {
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
        return state is DescriptionPostFormError ? state.message : null;
      },
    );
  }

  void _onDescriptionChanged() {
    _myFormBloc.add(ChangedFeedPostDescription(value: _descriptionController.text));
  }

  void _onMemberMediaChanged(value) {
    _myFormBloc.add(ChangedFeedPostMemberMedia(value: value));
    setState(() {});
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _photoAvailable(
      PostModel postModel,
      String path,
      ) {
    var media = postModel.memberMedia;
    if (media == null) media = [];
    /*var memberImageModel = await UploadFile.createThumbnailUploadVideoFile(widget.appId!, path, widget.memberId!, widget.readAccess!);
    media.add(
        PostMediumModel(documentID: newRandomKey(), memberMedium: memberImageModel)
    );
    _myFormBloc.add(ChangedFeedPostMemberMedia(value: media));
    */
  }
}
