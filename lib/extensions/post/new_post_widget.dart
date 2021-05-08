import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../postlist_paged/postlist_paged_event.dart';

class NewPostWidget extends StatefulWidget {
  final String appId;
  final String feedId;
  final MemberModel? member;
  final MemberPublicInfoModel memberPublicInfoModel;
  final PostModel? postModel;
  final AccessBloc? accessBloc;

  const NewPostWidget(this.appId, this.feedId, this.memberPublicInfoModel, {Key? key, this.member, this.postModel, this.accessBloc})
      : super(key: key);

  @override
  _NewPostWidgetWidgetState createState() {
    return _NewPostWidgetWidgetState();
  }
}

class _NewPostWidgetWidgetState extends State<NewPostWidget> {
  final TextEditingController _commentController = TextEditingController();
  PostModel? newPost;

  @override
  void initState() {
    super.initState();
    newPost = PostModel(
        documentID: newRandomKey(),
        author: widget.memberPublicInfoModel,
    appId: widget.appId,
    feedId: widget.feedId,
    archived: PostArchiveStatus.Active,
    pageParameters: null,
    description: "Post added by Add To Post button",
    readAccess: ['PUBLIC', ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addPost(BuildContext context, PostModel? postModel) {
    if ((_commentController.text != null) &&
        (_commentController.text.length > 0)) {
      postModel = postModel!.copyWith(description: _commentController.text);
      BlocProvider.of<PostListPagedBloc>(context)
          .add(AddPostPaged(value: postModel!));
      _commentController.clear();
    }
  }

  Widget _textField() {
    return TextField(
      textAlign: TextAlign.left,
      controller: _commentController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Say something...',
        hintStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        contentPadding: EdgeInsets.only(left: 8),
        fillColor: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = AccessBloc.getState(context);
    if (state is LoggedIn) {
      var member = state.member;
      var avatar;
      if (member.photoURL == null) {
        avatar = Text("No avatar for this author");
      } else {
        avatar = FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: member.photoURL!,
        );
      }
      return PostHelper.getFormattedPost([Row(children: [
        Container(
            height: 60,
            width: 60,
            child: avatar == null ? Container() : avatar),
        Container(width: 8),
        Flexible(
          child: Container(
              alignment: Alignment.center, height: 30, child: _textField()),
        ),
        Container(width: 8),
        PostHelper.mediaButtons(context, newPost, member!.documentID!),
        Container(
            height: 30,
            child: RaisedButton(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text('Ok'),
                onPressed: () => _addPost(context, newPost))),
      ])]);
    } else {
      return Text("Not logged in");
    }
  }


  void photoAvailable(postModel, value) {
    // add the photo to the post
  }
}
