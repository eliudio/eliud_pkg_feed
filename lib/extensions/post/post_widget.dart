import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_core/tools/widgets/request_value_dialog.dart';
import 'package:eliud_core/tools/widgets/yes_no_dialog.dart';
import 'package:eliud_pkg_feed/extensions/post/post_contents_widget.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostWidget extends StatefulWidget {
  //final MemberModel? member;
  //final String parentPageId;
  final PostDetails details;
  final SwitchFeedHelper switchFeedHelper;

  const PostWidget(
      {Key? key, required this.switchFeedHelper, required this.details})
      : super(key: key);

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
    var postModel = widget.details.postModel;
    var memberId = widget.switchFeedHelper.memberCurrent!.documentID!;
    if (size == null) size = MediaQuery.of(context).size;
    var originalAccessBloc = BlocProvider.of<AccessBloc>(context);

    List<Widget> widgets = [];

    widgets.add(_heading(context, postModel, memberId));
    widgets.add(_aBitSpace());
    if ((postModel.description != null) &&
        (postModel.description!.length > 0)) {
      widgets.add(_description(postModel));
      widgets.add(_aBitSpace());
    }
    widgets.add(PostContentsWidget(
      memberID: widget.switchFeedHelper.memberCurrent!.documentID!,
      postModel: postModel,
      accessBloc: originalAccessBloc,
      parentPageId: widget.switchFeedHelper.pageId,
    ));
    widgets.add(_aBitSpace());

    widgets.add(_postActionBtns(
        context, widget.details, memberId));
    widgets.add(_aBitSpace());
    widgets.add(_enterComment(context, widget.details));
    widgets.add(_aBitSpace());
    widgets.add(_postComments(context, widget.details, memberId));

    return PostHelper.getFormattedPost(widgets);
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

  Widget _enterComment(BuildContext context, PostDetails postDetail) {
    if (widget.switchFeedHelper.memberCurrent == null) {
      return Container();
    } else {
      return Row(children: [
        Container(
            height: 40,
            width: 40,
            child: widget.switchFeedHelper.gestured(
                context,
                widget.switchFeedHelper.memberCurrent!.documentID!,
                AvatarHelper.avatar(widget.switchFeedHelper.memberCurrent!))),
        Container(width: 8),
        Flexible(
          child: Container(
              alignment: Alignment.center, height: 30, child: _textField()),
        ),
        Container(width: 8),
        //PostHelper.mediaButtons(context, _photoAvailable, _videoAvailable),
        Container(
            height: 30,
            child: RaisedButton(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text('Ok'),
                onPressed: () => _addComment(context, postDetail))),
      ]);
    }
  }

  void _addComment(BuildContext context, PostDetails detail) {
    if ((_commentController.text != null) &&
        (_commentController.text.length > 0)) {
      BlocProvider.of<PostListPagedBloc>(context)
          .add(AddCommentEvent(detail, _commentController.text));
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

  Widget _heading(
      BuildContext context, PostModel? postModel, String? memberId) {
    if (postModel == null) return Text("No post");
    if (postModel.author == null) return Text("No author");

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
          height: 50,
          width: 50,
          child: widget.switchFeedHelper.gestured(
              context,
              postModel.author!.documentID!,
              AvatarHelper.avatar(postModel.author))),
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
      BuildContext context, PostDetails postDetail, String memberId) {
    DialogStatefulWidgetHelper.openIt(
      context,
      RequestValueDialog(
          title: 'Reply to comment',
          yesButtonText: 'Reply',
          noButtonText: 'Discard',
          hintText: 'Comment',
          yesFunction: (comment) {
            if (comment != null) {
              BlocProvider.of<PostListPagedBloc>(context)
                  .add(AddCommentEvent(postDetail, comment));
            }
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  void allowToAddCommentComment(BuildContext context, PostDetails postDetail,
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
              BlocProvider.of<PostListPagedBloc>(context).add(AddCommentCommentEvent(
                  postDetail, postCommentContainer, comment));
            }
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  void allowToUpdateComment(BuildContext context, PostDetails postDetail,
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
            BlocProvider.of<PostListPagedBloc>(context).add(UpdateCommentEvent(
                postDetail, postCommentContainer.postComment!, comment!));
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  void allowToDeleteComment(BuildContext context, PostDetails postDetail,
      String? memberId, PostCommentContainer? postCommentContainer) {
    DialogStatefulWidgetHelper.openIt(
        context,
        YesNoDialog.confirmDialog(
          message: "Do you want to delete this comment",
          yesFunction: () async {
            Navigator.pop(context);
            BlocProvider.of<PostListPagedBloc>(context).add(DeleteCommentEvent(
                postDetail, postCommentContainer!.postComment!));
          },
          noFunction: () => Navigator.pop(context),
        ));
  }

  Widget _postComments(
      BuildContext context, PostDetails postDetail, String? memberId) {
    List<PostCommentContainer?>? comments = postDetail.comments;
    if (comments == null) return Container();
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: comments.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) return _dividerLight();
          var postComment = comments[i - 1];
          return getCommentTreeWidget(
              context, postDetail, postComment);
        });
  }

  Widget getCommentTreeWidget(
      BuildContext context, PostDetails postDetail, PostCommentContainer? data) {
    if (data == null) return Text("No Comments");

    var name;
    if (data.member == null) {
      name = "No name";
    } else {
      if (data.member!.name == null) {
        name = "No name";
      } else {
        name = data.member!.name;
      }
    }

    var rowChildren = [
      widget.switchFeedHelper.gestured(context, data.member!.documentID!,
          AvatarHelper.avatar2(data.member, 8)),
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
    if (widget.switchFeedHelper.memberCurrent!.documentID! == data.member!.documentID) {
      rowChildren.add(_optionsPostComments(
          context, postDetail, data.member!.documentID, data));
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
                        context, postDetail, data)), //your original button
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
                          context, postDetail, data, data.member!.documentID!))),
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
            context, postDetail, data.postCommentContainer![i]));
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

  PopupMenuButton _optionsPostComments(
      BuildContext context,
      PostDetails postDetail,
      String? memberId,
      PostCommentContainer? postComment) {
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
            allowToUpdateComment(context, postDetail, memberId, postComment);
          if (choice == 1)
            allowToDeleteComment(context, postDetail, memberId, postComment);
        });
  }

  Widget _postActionBtns(
    BuildContext context,
    PostDetails postDetails,
    String? memberId,
  ) {
    var likes = postDetails.postModel.likes;
    var dislikes = postDetails.postModel.dislikes;
    if (likes == null) likes = 0;
    if (dislikes == null) dislikes = 0;
    LikeType? thisMemberLikeType;
    thisMemberLikeType = postDetails.thisMembersLikeType;
    return Row(
      children: <Widget>[
        Spacer(),
        PostHelper.getFormattedRoundedShape(IconButton(
          icon: ImageIcon(
            AssetImage(
                (thisMemberLikeType == null) ||
                        (thisMemberLikeType != LikeType.Like)
                    ? "assets/images/segoshvishna.fiverr.com/thumbs-up.png"
                    : "assets/images/segoshvishna.fiverr.com/thumbs-up-selected.png",
                package: "eliud_pkg_feed"),
          ),
          onPressed: () => _like(context, postDetails),
        )),
        Text(
          "$likes",
        ),
        Spacer(flex: 3),
        PostHelper.getFormattedRoundedShape(IconButton(
          icon: ImageIcon(
            AssetImage(
                (thisMemberLikeType == null) ||
                        (thisMemberLikeType != LikeType.Dislike)
                    ? "assets/images/segoshvishna.fiverr.com/thumbs-down.png"
                    : "assets/images/segoshvishna.fiverr.com/thumbs-down-selected.png",
                package: "eliud_pkg_feed"),
          ),
          onPressed: () => _dislike(context, postDetails),
        )),
        Text(
          "$dislikes",
        ),
        Spacer(),
      ],
    );
  }

  Future<void> _like(BuildContext context, PostDetails postDetail) async {
      BlocProvider.of<PostListPagedBloc>(context)
          .add(LikePostEvent(postDetail, LikeType.Like));
  }

  Future<void> _likeComment(BuildContext context, PostDetails postDetail,
      PostCommentContainer postCommentContainer) async {
      BlocProvider.of<PostListPagedBloc>(context).add(
          LikeCommentPostEvent(postDetail, postCommentContainer, LikeType.Like));
  }

  void _dislike(BuildContext context, PostDetails postDetail,) async {
      BlocProvider.of<PostListPagedBloc>(context)
          .add(LikePostEvent(postDetail, LikeType.Dislike));
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

  Future<void> _photoAvailable(PhotoWithThumbnail photoWithThumbnail) async {
    throw Exception("Needs proper implementation.");
/*
    var memberImageModel = await UploadFile.uploadMediumAndItsThumbnailData(widget.postModel.appId!, mediumAndItsThumbnailData, widget.member!.documentID!, widget.postModel.readAccess!);
    postModel.memberMedia!.add(
        PostMediumModel(documentID: newRandomKey(), memberMedium: memberImageModel)
    );
*/
  }

  Future<void> _videoAvailable(VideoWithThumbnail videoWithThumbnail) async {
    throw Exception("Needs proper implementation.");
  }
}
