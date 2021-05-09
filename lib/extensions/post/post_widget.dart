import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_core/tools/widgets/request_value_dialog.dart';
import 'package:eliud_core/tools/widgets/yes_no_dialog.dart';
import 'package:eliud_pkg_feed/extensions/post/post_contents_widget.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/tools/storage/firestore_helper.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'bloc/post_bloc.dart';
import 'bloc/post_event.dart';
import 'bloc/post_state.dart';

class PostWidget extends StatefulWidget {
  final MemberModel? member;
  final PostModel postModel;
  final String parentPageId;

  const PostWidget({Key? key, required this.postModel, this.member, required this.parentPageId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostWidgetState();
  }
}

class _PostWidgetState extends State<PostWidget> {
  static TextStyle textStyleSmall =
      TextStyle(fontSize: 8, fontWeight: FontWeight.bold);
  static TextStyle textStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final TextEditingController _commentController = TextEditingController();

  Size? size;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  bool? isPortrait;

  @override
  Widget build(BuildContext context) {
    bool isCurrentPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    if ((isPortrait != null) && (isPortrait != isCurrentPortrait)) {
      // If we're rebuilding as a result of a change of orientation, then we need to refresh the page.
      // The reason for this is because it seems that the StaggeredGridView doesn't behave correct when changing orientation.
      // This seems to happen because the StaggeredGridView sits in a list. These guys had the same problem and the solution does not  work
      // https://github.com/letsar/flutter_staggered_grid_view/issues/79
      // So, as a result, I bruteforce refresh the page
      // This is not ideal, but it's the best we can do for now
      eliudrouter.Router.bruteRefreshPage(context);
    }
    isPortrait = isCurrentPortrait;
    return buildIt(context);
  }

  Widget buildIt(BuildContext context) {
    var postModel = widget.postModel;
    var memberId = widget.member!.documentID;
    if (size == null) size = MediaQuery.of(context).size;
    var originalAccessBloc = BlocProvider.of<AccessBloc>(context);

    return PostHelper.getFormattedPost( [
                        _heading(context, widget.postModel, memberId),
                        _aBitSpace(),
                        _description(postModel),
                        _aBitSpace(),
                        PostContentsWidget(
                          member: widget.member,
                          postModel: postModel,
                          accessBloc: originalAccessBloc,
                          parentPageId: widget.parentPageId,
                        ),
                        _dividerLight(),
                        _aBitSpace(),
                        _postLikes(postModel.likes,
                            postModel.dislikes),
                        _aBitSpace(),
                        _dividerLight(),
                        _postActionBtns(
                            context,
                            postModel,
                            memberId),
                        _aBitSpace(),
                        _dividerLight(),
                        _aBitSpace(),
                        _enterComment(context, postModel),
                        _aBitSpace(),
                        _postComments(
                            context,
                            postModel,
                            memberId),
                      ],
                    );
  }

  Widget _description(PostModel? postModel) {
    if ((postModel != null) && (postModel.description != null)) {
      return Text(postModel.description!);
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget _enterComment(BuildContext context, PostModel? postModel) {
    if (widget.member == null) {
      return Container();
    } else {
      var avatar;
      if (widget.member!.photoURL == null) {
        avatar = Text("No avatar");
      } else {
        avatar = FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: widget.member!.photoURL!,
        );
      }
      return Row(children: [
        Container(
            height: 40,
            width: 40,
            child: avatar == null ? Container() : avatar),
        Container(width: 8),
        Flexible(
          child: Container(
              alignment: Alignment.center, height: 30, child: _textField()),
        ),
        Container(width: 8),
        PostHelper.mediaButtons(context, postModel, widget.member!.documentID!, _photoAvailable),
        Container(
            height: 30,
            child: RaisedButton(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text('Ok'),
                onPressed: () => _addComment(context, postModel))),
      ]);
    }
  }

  void _addComment(BuildContext context, PostModel? postModel) {
    if ((_commentController.text != null) &&
        (_commentController.text.length > 0)) {
      BlocProvider.of<PostBloc>(context)
          .add(AddCommentEvent(postModel!, _commentController.text));
      _commentController.clear();
    }
  }

  Widget _textField() {
    return TextField(
      textAlign: TextAlign.left,
      controller: _commentController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Add your comment here and press ok...',
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

  Widget _aBitSpace() {
    return Container(
      height: 10,
    );
  }

  Widget _dividerLight() {
    return Divider(height: 1, thickness: 1, color: Colors.black);
  }

  Widget _heading(BuildContext context, PostModel? postModel, String? memberId) {
    if (postModel == null) return Text("No post");
    if (postModel.author == null) return Text("No author");
    var avatar;
    if (postModel.author!.photoURL == null) {
      avatar = Text("No avatar for this author");
    } else {
      avatar = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: postModel.author!.photoURL!,
      );
    }
    var name;
    if (postModel.author!.name != null) {
      name = postModel.author!.name!;
    } else {
      name = "";
    }
    var timeStamp;
    if (postModel.timestamp == null) {
      timeStamp = "?";
    } else {
      timeStamp = postModel.timestamp!;
    }
    var children = [
      Container(
          height: 50, width: 50, child: avatar == null ? Container() : avatar),
      Container(
        width: 8,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 4,
        ),
        Text(name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left),
        Text(timeStamp,
            style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
      ])
    ];
    if (memberId == postModel.author!.documentID) {
//      children.add(Spacer());
//      currently no options, delete not implemented
//      children.add(_optionsPost(context, postModel, memberId));
    }

    var row =
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: children);

    return row;
  }

  PopupMenuButton _optionsPost(
      BuildContext context, PostModel postModel, String memberId) {
    return PopupMenuButton(
        icon: Icon(Icons.more_horiz),
        itemBuilder: (_) => <PopupMenuItem<int>>[
              new PopupMenuItem<int>(
                  child: const Text('Delete post'), value: 0),
            ],
        onSelected: (choice) {
          if (choice == 0) {
//        TODO: Issue with deleting post:
//        Deleting the posts in a feed is an issue. A block inside a list seems the issue.
//        I assumed this to be an issue because of the listen, but it seems it has to do with the block.
//        I've created another branch paged-feed-alternative which is a feed without the listen.
//        But it's equally a problem. Now what? Let's not support delete.
          }
        });
  }

  void allowToAddComment(
      BuildContext context, PostModel postModel, String memberId) {
    DialogStatefulWidgetHelper.openIt(
      context,
      RequestValueDialog(
          title: 'Reply to comment',
          yesButtonText: 'Reply',
          noButtonText: 'Discard',
          hintText: 'Comment',
          yesFunction: (comment) {
            if (comment != null) {
              BlocProvider.of<PostBloc>(context)
                  .add(AddCommentEvent(postModel, comment));
            }
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  void allowToAddCommentComment(BuildContext context,
      PostCommentContainer postCommentContainer, String memberId) {
    DialogStatefulWidgetHelper.openIt(
      context,
      RequestValueDialog(
          title: 'Reply to comment',
          yesButtonText: 'Reply',
          noButtonText: 'Discard',
          hintText: 'Comment',
          yesFunction: (comment) {
            if (comment != null) {
              BlocProvider.of<PostBloc>(context)
                  .add(AddCommentCommentEvent(widget.postModel, postCommentContainer, comment));
            }
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  void allowToUpdateComment(BuildContext context, PostModel? postModel,
      String? memberId, PostCommentContainer? postCommentContainer) {
    DialogStatefulWidgetHelper.openIt(
      context,
      RequestValueDialog(
          title: 'Update comment',
          yesButtonText: 'Update comment',
          noButtonText: 'Discard',
          hintText: 'Comment',
          initialValue: postCommentContainer!.comment,
          yesFunction: (comment) {
            BlocProvider.of<PostBloc>(context).add(
                UpdateCommentEvent(widget.postModel, postCommentContainer.postComment!, comment!));
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  void allowToDeleteComment(BuildContext context, PostModel? postModel,
      String? memberId, PostCommentContainer? postCommentContainer) {
    DialogStatefulWidgetHelper.openIt(
        context,
        YesNoDialog.confirmDialog(
          message: "Do you want to delete this comment",
          yesFunction: () async {
            Navigator.pop(context);
            BlocProvider.of<PostBloc>(context)
                .add(DeleteCommentEvent(widget.postModel, postCommentContainer!.postComment!));
          },
          noFunction: () => Navigator.pop(context),
        ));
  }

  Widget _postComments(BuildContext context, PostModel? postModel,
      String? memberId) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, postState) {
      if (postState is CommentsLoaded) {
        List<PostCommentContainer?>? comments = postState.comments;
        if (comments == null) return Container();
        return ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: comments.length + 1,
            itemBuilder: (context, i) {
              if (i == 0) return _dividerLight();
              var postComment = comments[i - 1];
              return getCommentTreeWidget(context, postModel, postComment);
            });
      } else {
        return Text("Comments loading...");
      }
    });
  }

  Widget getCommentTreeWidget(
      BuildContext context, PostModel? postModel, PostCommentContainer? data) {

    if (data == null) return Text("No Comments");

    var avatar;
    var name ;
    if (data.member == null) {
      avatar = Text("No avatar");
      name = "No name";
    } else {
      if (data.member!.name == null) {
        name = "No name";
      } else {
        name = data.member!.name;
      }
      if (data.member!.photoURL == null) {
        avatar = Text("No avatar");
      } else {
        avatar = NetworkImage(data.member!.photoURL!);
      }
    }

    var rowChildren = [
      CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        backgroundImage: avatar,
      ),
      Container(width: 8),
      Expanded(
          child: Container(
            constraints: BoxConstraints(minWidth: 150),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${name}',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${data.comment}',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.w300, color: Colors.black),
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      data.postComment == null || data.postComment!.likes == null
                          ? 'no likes'
                          : '${data.postComment!.likes} likes',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w300, color: Colors.black),
                    )),
              ],
            ),
          )),
      ];
      if (widget.member!.documentID == data.member!.documentID) {
        rowChildren.add(_optionsPostComments(
            context, postModel, data.member!.documentID, data));
      }

      var header = Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: IntrinsicHeight(child: Row(children: rowChildren))),
              //Divider(height: 1, thickness: 1),
              Row(children: [
                SizedBox(
                  height: 0,
                  width: 25,
                ),
                ButtonTheme(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 8.0), //adds padding inside the button
                  materialTapTargetSize: MaterialTapTargetSize
                      .shrinkWrap, //limits the touch area to the button area
                  minWidth: 0, //wraps child's width
                  height: 0, //wraps child's height
                  child: TextButton(
                      child: Text('Like',
                          style: data.thisMemberLikesThisComment!
                              ? TextStyle(fontWeight: FontWeight.w900)
                              : null),
                      onPressed: () => _likeComment(
                          context, postModel, data)), //your original button
                ),
                ButtonTheme(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 8.0), //adds padding inside the button
                    materialTapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, //limits the touch area to the button area
                    minWidth: 0, //wraps child's width
                    height: 0, //wraps child's height
                    child: TextButton(
                        child: Text('Reply'),
                        onPressed: () => allowToAddCommentComment(
                            context, data, data.member!.documentID!))),
              ]),
            ],
          ));
      List<Widget> items = [
        Container(
          height: 10,
        ),
        header,
      ];
      List<Widget> children = [];
      if (data.postCommentContainer != null) {
        for (int i = 0; i < data.postCommentContainer!.length; i++) {
          children.add(getCommentTreeWidget(
              context, postModel, data.postCommentContainer![i]));
        }
        if (children.length > 0)
          items.add(Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 40),
              child: ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: children)));
      }
      return ListView(
          physics: ScrollPhysics(), shrinkWrap: true, children: items);
  }

  PopupMenuButton _optionsPostComments(BuildContext context,
      PostModel? postModel, String? memberId, PostCommentContainer? postComment) {
    return PopupMenuButton(
        icon: Icon(Icons.more_horiz),
        itemBuilder: (_) => <PopupMenuItem<int>>[
              new PopupMenuItem<int>(
                  child: const Text('Update comment'), value: 0),
              new PopupMenuItem<int>(
                  child: const Text('Delete comment'), value: 1),
            ],
        onSelected: (choice) {
          if (choice == 0)
            allowToUpdateComment(context, postModel, memberId, postComment);
          if (choice == 1)
            allowToDeleteComment(context, postModel, memberId, postComment);
        });
  }

  Widget _postActionBtns(BuildContext context, PostModel? postModel,
      String? memberId, ) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, postState) {
      LikeType? thisMemberLikeType;
      if (postState is CommentsLoaded) {
        thisMemberLikeType = postState is CommentsLoaded ? postState.thisMembersLikeType : null;
      }
      return Row(
        children: <Widget>[
          Spacer(),
          IconButton(
              icon: ImageIcon(
                AssetImage(
                    (thisMemberLikeType == null) ||
                        (thisMemberLikeType != LikeType.Like)
                        ? "assets/images/basicons.xyz/ThumbsUp.png"
                        : "assets/images/basicons.xyz/ThumbsUpSelected.png",
                    package: "eliud_pkg_feed"),
              ),
              onPressed: () => _like(context, postModel),
              color: Colors.black),
          Spacer(flex: 3),
          IconButton(
              icon: ImageIcon(
                AssetImage(
                    (thisMemberLikeType == null) ||
                        (thisMemberLikeType != LikeType.Dislike)
                        ? "assets/images/basicons.xyz/ThumbsDown.png"
                        : "assets/images/basicons.xyz/ThumbsDownSelected.png",
                    package: "eliud_pkg_feed"),
              ),
              onPressed: () => _dislike(context, postModel),
              color: Colors.black),
          Spacer(),
        ],
      );
    });
  }

  Future<void> _like(BuildContext context, PostModel? postModel) async {
    if (postModel != null)
      BlocProvider.of<PostBloc>(context)
        .add(LikePostEvent(postModel, LikeType.Like));
  }

  Future<void> _likeComment(BuildContext context, PostModel? postModel,
      PostCommentContainer? postCommentContainer) async {
    if ((postModel != null) && (postCommentContainer != null))
    BlocProvider.of<PostBloc>(context).add(
        LikeCommentPostEvent(postModel, postCommentContainer, LikeType.Like));
  }

  void _dislike(BuildContext context, PostModel? postModel) async {
    if (postModel != null)
      BlocProvider.of<PostBloc>(context)
        .add(LikePostEvent(postModel, LikeType.Dislike));
  }

  Widget _postLikes(int? likes, int? dislikes) {
    if (likes == null) likes = 0;
    if (dislikes == null) dislikes = 0;
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Text(
        "$likes likes $dislikes dislikes",
        //style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }


  Future<void> _photoAvailable(
      PostModel postModel,
      String path,
      ) async {
    var memberImageModel = await UploadFile.createThumbnailUploadVideoFile(widget.postModel.appId!, path, widget.member!.documentID!, widget.postModel.readAccess!);
    postModel.memberMedia!.add(
        PostMediumModel(documentID: newRandomKey(), memberMedium: memberImageModel)
    );
  }
}
