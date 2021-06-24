import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_pkg_feed/extensions/util/post_contents_widget.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostWidget extends StatefulWidget {
  //final MemberModel? member;
  //final String parentPageId;
  final String appId;
  final String pageId;
  final String? memberId;
  final String? photoURL;
  final String feedId;
  final ThumbStyle? thumbStyle;
  final PostDetails details;
  final bool isEditable;

  const PostWidget(
      {Key? key,
      required this.appId,
      required this.pageId,
      required this.memberId,
      required this.photoURL,
      required this.feedId,
      required this.thumbStyle,
      required this.details,
      required this.isEditable})
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
    if (size == null) size = MediaQuery.of(context).size;
    var originalAccessBloc = BlocProvider.of<AccessBloc>(context);

    List<Widget> widgets = [];

    widgets.add(_heading(context, postModel));

    widgets.add(_aBitSpace());
    if ((postModel.description != null) &&
        (postModel.description!.length > 0)) {
      widgets.add(_description(postModel));
      widgets.add(_aBitSpace());
    }
    widgets.add(PostContentsWidget(
      memberID: widget.memberId,
      postModel: postModel,
      accessBloc: originalAccessBloc,
      parentPageId: widget.pageId,
    ));
    widgets.add(_aBitSpace());

    widgets.add(_postActionBtns(context, widget.details, widget.memberId));
    widgets.add(_aBitSpace());
    widgets.add(_enterComment(context, widget.details));
    widgets.add(_aBitSpace());
    widgets.add(_postComments(context, widget.details, widget.memberId));

    return StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .containerStyle()
        .topicContainer(context, children: widgets);
  }

  static double _width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  Widget _description(PostModel? postModel) {
    if ((postModel != null) && (postModel.description != null)) {
      return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, postModel.description!);
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget _enterComment(BuildContext context, PostDetails postDetail) {
    if (widget.isEditable) {
      return Container();
    } else {
      return Row(children: [
        Container(
            height: 40,
            width: 40,
            child: AvatarHelper.avatar(
                    context,
                    20,
                    widget.pageId,
                    widget.memberId!,
                    widget.photoURL!,
                    widget.appId,
                    widget.feedId)),
        Container(width: 8),
        Flexible(
          child: Container(
              alignment: Alignment.center, height: 30, child: _textField()),
        ),
        Container(width: 8),
        //PostHelper.mediaButtons(context, _photoAvailable, _videoAvailable),
        StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .buttonStyle()
            .button(context,
                label: 'Ok', onPressed: () => _addComment(context, postDetail)),
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
      BuildContext context, PostModel? postModel) {
    if (postModel == null) return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'No post');
    if (postModel.author == null) return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'No author');

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
          child: AvatarHelper.avatar(context, 25, widget.pageId,
                  postModel.author!.documentID!, postModel.author!.photoURL!, widget.appId, widget.feedId)),
      Container(
        width: 8,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 4,
        ),
        StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().h5(context, name,
            textAlign: TextAlign.left),
        StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().h5(context, timeStamp,
            textAlign: TextAlign.left),
      ])
    ];
/*
    if (memberId == postModel.author!.documentID) {
//      children.add(Spacer());
//      currently no options, delete not implemented
//      children.add(_optionsPost(context, postModel, memberId));
    }
*/

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
                  child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'Delete post'), value: 0),
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
    StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .dialogStyle()
        .openEntryDialog(
      context,
      title: 'Reply to comment',
      ackButtonLabel: 'Reply',
      nackButtonLabel: 'Discard',
      onPressed: (comment) {
        if (comment != null) {
          BlocProvider.of<PostListPagedBloc>(context)
              .add(AddCommentEvent(postDetail, comment));
        }
      },
    );
  }

  void allowToAddCommentComment(BuildContext context, PostDetails postDetail,
      PostCommentContainer postCommentContainer, String memberId) {
    StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .dialogStyle()
        .openEntryDialog(context,
            title: 'Reply to comment',
            hintText: 'Reply',
            ackButtonLabel: 'Reply',
            nackButtonLabel: 'Discard', onPressed: (comment) {
      if (comment != null) {
        BlocProvider.of<PostListPagedBloc>(context).add(
            AddCommentCommentEvent(postDetail, postCommentContainer, comment));
      }
    });
  }

  void allowToUpdateComment(BuildContext context, PostDetails postDetail,
      String? memberId, PostCommentContainer? postCommentContainer) {
    StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .dialogStyle()
        .openEntryDialog(context,
            title: 'Update comment',
            hintText: 'Comment',
            ackButtonLabel: 'Reply',
            nackButtonLabel: 'Discard', onPressed: (comment) {
      if (comment != null) {
        BlocProvider.of<PostListPagedBloc>(context).add(UpdateCommentEvent(
            postDetail, postCommentContainer!.postComment!, comment));
      }
    });
  }

  void allowToDeleteComment(BuildContext context, PostDetails postDetail,
      String? memberId, PostCommentContainer? postCommentContainer) {
    StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .dialogStyle()
        .openAckNackDialog(context,
            message: "Do you want to delete this comment",
            onSelection: (value) async {
      if (value == 0) {
        BlocProvider.of<PostListPagedBloc>(context).add(
            DeleteCommentEvent(postDetail, postCommentContainer!.postComment!));
      }
    }, title: 'Confirm');
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
          return getCommentTreeWidget(context, postDetail, postComment);
        });
  }

  Widget getCommentTreeWidget(BuildContext context, PostDetails postDetail,
      PostCommentContainer? data) {
    if (data == null) return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'No Comments');

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

    List<Widget> rowChildren = [
      AvatarHelper.avatar(context, 20, widget.pageId,
              data.member!.documentID!, data.member!.photoURL!, widget.appId, widget.feedId),
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
            StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().h5(context,
              '${name}',
            ),
            SizedBox(
              height: 4,
            ),
            StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().h5(context,
              '${data.comment}',
            ),
            SizedBox(
              height: 4,
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().h5(context,
                  data.postComment == null || data.postComment!.likes == null
                      ? 'no likes'
                      : '${data.postComment!.likes} likes',
                )),
          ],
        ),
      )),
    ];
    if (widget.memberId ==
        data.member!.documentID) {
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
                child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().buttonStyle().dialogButton(context, label: 'Like',
                    selected: data.thisMemberLikesThisComment!,
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
                  child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().buttonStyle().dialogButton(context, label: 'Reply',
                      onPressed: () => allowToAddCommentComment(context,
                          postDetail, data, data.member!.documentID!))),
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
                  child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'Update comment'), value: 0),
              new PopupMenuItem<int>(
                  child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'Delete comment'), value: 1),
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
        StyleRegistry.registry()
                    .styleWithContext(context)
                    .frontEndStyle()
                    .buttonStyle()
                    .iconButton(
                      context,
                      icon: ImageIcon(_assetThumbUp(thisMemberLikeType)),
                      onPressed: () => _like(context, postDetails),
                    ),
    StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context,
          "$likes",
        ),
        Spacer(flex: 3),
        StyleRegistry.registry()
                    .styleWithContext(context)
                    .frontEndStyle()
                    .buttonStyle()
                    .iconButton(
                      context,
                      icon: ImageIcon(_assetThumbDown(thisMemberLikeType)),
                      onPressed: () => _dislike(context, postDetails),
                    ),
        StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context,
          "$dislikes",
        ),
        Spacer(),
      ],
    );
  }

  AssetImage _assetThumbUp(LikeType? thisMemberLikeType) {
    if (widget.thumbStyle == ThumbStyle.Thumbs) {
      if ((thisMemberLikeType == null) ||
          (thisMemberLikeType != LikeType.Like)) {
        return AssetImage("assets/images/segoshvishna.fiverr.com/thumbs-up.png",
            package: "eliud_pkg_feed");
      } else {
        return AssetImage(
            "assets/images/segoshvishna.fiverr.com/thumbs-up-selected.png",
            package: "eliud_pkg_feed");
      }
    } else {
      if ((thisMemberLikeType == null) ||
          (thisMemberLikeType != LikeType.Like)) {
        return AssetImage("assets/images/segoshvishna.fiverr.com/banana.png",
            package: "eliud_pkg_feed");
      } else {
        return AssetImage(
            "assets/images/segoshvishna.fiverr.com/banana-selected.png",
            package: "eliud_pkg_feed");
      }
    }
  }

  AssetImage _assetThumbDown(LikeType? thisMemberLikeType) {
    if (widget.thumbStyle == ThumbStyle.Thumbs) {
      if ((thisMemberLikeType == null) ||
          (thisMemberLikeType != LikeType.Dislike)) {
        return AssetImage(
            "assets/images/segoshvishna.fiverr.com/thumbs-down.png",
            package: "eliud_pkg_feed");
      } else {
        return AssetImage(
            "assets/images/segoshvishna.fiverr.com/thumbs-down-selected.png",
            package: "eliud_pkg_feed");
      }
    } else {
      if ((thisMemberLikeType == null) ||
          (thisMemberLikeType != LikeType.Dislike)) {
        return AssetImage(
            "assets/images/segoshvishna.fiverr.com/bananapeel.png",
            package: "eliud_pkg_feed");
      } else {
        return AssetImage(
            "assets/images/segoshvishna.fiverr.com/bananapeel-selected.png",
            package: "eliud_pkg_feed");
      }
    }
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

  void _dislike(
    BuildContext context,
    PostDetails postDetail,
  ) async {
    BlocProvider.of<PostListPagedBloc>(context)
        .add(LikePostEvent(postDetail, LikeType.Dislike));
  }

  Widget _postLikes(int? likes, int? dislikes) {
    if (likes == null) likes = 0;
    if (dislikes == null) dislikes = 0;
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context,
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