import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_container_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/frontend/has_text_form_field.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliud_router;
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/paged_posts_list.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_privilege/bloc/member_service.dart';
import 'package:eliud_pkg_feed/extensions/util/access_group_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/post_contents_widget.dart';
import 'package:eliud_pkg_feed/extensions/util/post_type_helper.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_text/platform/text_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'new_post/bloc/feed_post_form_event.dart';
import 'new_post/feed_post_dialog.dart';

class PostWidget extends StatefulWidget {
  //final MemberModel? member;
  //final String parentPageId;
  final AppModel app;
  final String pageId;
  final String memberId; // of the post
  final String? currentMemberId;
  final String? photoURL;
  final String feedId;
  final ThumbStyle? thumbStyle;
  final PostDetails details;
  final bool isEditable;

  const PostWidget(
      {Key? key,
      required this.app,
      required this.pageId,
      required this.memberId,
      required this.currentMemberId,
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
      app: widget.app,
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

    return topicContainer(widget.app, context, children: widgets);
  }

  static double _width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  Widget _description(PostModel? postModel) {
    if ((postModel != null) && (postModel.description != null)) {
      return text(widget.app, context, postModel.description!);
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget _enterComment(BuildContext context, PostDetails postDetail) {
    if (!widget.isEditable) {
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
                widget.currentMemberId!,
                widget.currentMemberId,
                widget.app,
                widget.feedId)),
        Container(width: 8),
        Flexible(
          child: Container(
              alignment: Alignment.center, height: 30, child: _textField()),
        ),
        Container(width: 8),
        //PostHelper.mediaButtons(context, _photoAvailable, _videoAvailable),
        button(widget.app, context,
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
    return textField(
      widget.app,
      context,
      readOnly: false,
      textAlign: TextAlign.left,
      textInputAction: TextInputAction.send,
//      onSubmitted: (value) => _submit(value),
      controller: _commentController,
      keyboardType: TextInputType.text,
      hintText: 'Comment here...',
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

  Widget _heading(BuildContext context, PostModel? postModel) {
    if (postModel == null) return text(widget.app, context, 'No post');
    if (postModel.authorId == null)
      return text(widget.app, context, 'No author');

    var timeStamp;
    if (postModel.timestamp == null) {
      timeStamp = DateTime.now();
    } else {
      timeStamp = postModel.timestamp!;
    }

    var children = [
      Container(
          height: 50,
          width: 50,
          child: AvatarHelper.avatar(
              context,
              25,
              widget.pageId,
              postModel.authorId!,
              widget.currentMemberId,
              widget.app,
              widget.feedId)),
      Container(
        width: 8,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 4,
        ),
        AvatarHelper.nameH5(
            context, postModel.authorId!, widget.app, widget.feedId),
        h5(widget.app, context, verboseDateTimeRepresentation(timeStamp),
            textAlign: TextAlign.left),
      ]),
      Spacer(),
    ];

    // allow to update / delete
    if ((widget.currentMemberId != null) &&
        (widget.currentMemberId == postModel.authorId)) {
      children
          .add(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 4,
        ),
        Center(child: Icon(Icons.visibility)),
        h5(
            widget.app,
            context,
            AccessGroupHelper.nameForPostAccessibleByGroup(
                postModel.accessibleByGroup)),
      ]));
      children.add(Spacer());
      children.add(Spacer());
      children.add(_optionsPost(context, postModel, widget.currentMemberId!));
    }

    var row =
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: children);

    return row;
  }

  PopupMenuButton _optionsPost(
      BuildContext context, PostModel postModel, String memberId) {
    var items = <PopupMenuItem<int>>[];
    PostType type = PostTypeHelper.determineType(postModel);
    if (PostTypeHelper.canUpdate(type)) {
      items.add(
        PopupMenuItem<int>(
            child: text(widget.app, context, 'Update post'), value: 1),
      );
    }
    items.add(
      PopupMenuItem<int>(
          child: text(widget.app, context, 'Delete post'), value: 0),
    );

    return PopupMenuButton(
        icon: Icon(Icons.more_vert),
        itemBuilder: (_) => items,
        onSelected: (choice) async {
          if (choice == 0) {
            openAckNackDialog(
                widget.app, context, widget.app.documentID! + '/_deletepost',
                title: 'Delete post?',
                message: 'You are sure you want to delete this post?',
                onSelection: (value) async {
              if (value == 0) {
                BlocProvider.of<PostListPagedBloc>(context)
                    .add(DeletePostPaged(value: postModel));
              }
            });
          } else if (choice == 1) {
            switch (type) {
              case PostType.SingleVideo:
              case PostType.SinglePhoto:
              case PostType.Album:
              case PostType.OnlyDescription:
                var pageContextInfo = eliud_router.Router.getPageContextInfo(
                  context,
                );
                FeedPostDialog.open(
                    widget.app,
                    context,
                    widget.feedId,
                    postModel.authorId!,
                    widget.currentMemberId,
                    widget.photoURL!,
                    pageContextInfo,
                    InitialiseUpdateFeedPostFormEvent(
                      postModel,
                        postModel.description == null
                            ? ''
                            : postModel.description!,
                        postModel.memberMedia == null
                            ? <MemberMediumContainerModel>[]
                            : postModel.memberMedia!,
                        postModel.accessibleByGroup ??
                            PostAccessibleByGroup.Public,
                        postAccessibleByMembers:
                            postModel.accessibleByMembers == null
                                ? []
                                : postModel.accessibleByMembers!));
                break;
              case PostType.Html:
                List<MemberMediumContainerModel> postMediumModels =
                    postModel.memberMedia ?? [];
                AbstractTextPlatform.platform!
                    .updateHtmlWithMemberMediumCallback(
                        context,
                        widget.app,
                        postModel.authorId!,
                        (value) {
                          postMediumModels.add(MemberMediumContainerModel(
                              documentID: newRandomKey(), memberMedium: value));
                        },
                        toMemberMediumAccessibleByGroup(
                            postModel.accessibleByGroup!.index),
                        (newArticle) {
                          BlocProvider.of<PostListPagedBloc>(context).add(
                              UpdatePostPaged(
                                  value: postModel.copyWith(
                                      html: newArticle,
                                      memberMedia: postMediumModels)));
                        },
                        "Article",
                        postModel.html == null ? '' : postModel.html!,
                        accessibleByMembers: postModel.accessibleByMembers,
                        extraIcons: PagedPostsListState.getAlbumActionIcons(
                            widget.app,
                            context,
                            AccessGroupHelper.nameForPostAccessibleByGroup(
                                postModel.accessibleByGroup!)));
                break;
            }
          }
        });
  }

  void allowToAddComment(
      BuildContext context, PostDetails postDetail, String memberId) {
    openEntryDialog(
      widget.app,
      context,
      widget.app.documentID! + '/_reply',
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
    openEntryDialog(widget.app, context, widget.app.documentID! + '/_reply',
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
      String? memberId, PostCommentContainer postCommentContainer) {
    openEntryDialog(
        widget.app, context, widget.app.documentID! + '/_updatecomment',
        title: 'Update comment',
        hintText: 'Comment',
        initialValue: postCommentContainer.comment!,
        ackButtonLabel: 'Reply',
        nackButtonLabel: 'Discard', onPressed: (comment) {
      if (comment != null) {
        BlocProvider.of<PostListPagedBloc>(context).add(UpdateCommentEvent(
            postDetail, postCommentContainer.postComment!, comment));
      }
    });
  }

  void allowToDeleteComment(BuildContext context, PostDetails postDetail,
      String? memberId, PostCommentContainer? postCommentContainer) {
    openAckNackDialog(
        widget.app, context, widget.app.documentID! + '/_deletecomment',
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
    if (data == null) return text(widget.app, context, 'No Comments');

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
      AvatarHelper.avatar(context, 20, widget.pageId, data.member!.documentID!,
          widget.currentMemberId, widget.app, widget.feedId),
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
            h5(
              widget.app,
              context,
              '${name}',
            ),
            SizedBox(
              height: 4,
            ),
            h5(
              widget.app,
              context,
              '${data.comment}',
            ),
            SizedBox(
              height: 4,
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: h5(
                  widget.app,
                  context,
                  data.postComment == null || data.postComment!.likes == null
                      ? 'no likes'
                      : '${data.postComment!.likes} likes',
                )),
          ],
        ),
      )),
    ];
    if (widget.memberId == data.member!.documentID) {
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
                child: dialogButton(widget.app, context,
                    label: 'Like',
                    selected: data.thisMemberLikesThisComment!,
                    onPressed: () => widget.isEditable
                        ? _likeComment(context, postDetail, data)
                        : null), //your original button
              ),
              ButtonTheme(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 8.0), //adds padding inside the button
                  materialTapTargetSize: MaterialTapTargetSize
                      .shrinkWrap, //limits the touch area to the button area
                  minWidth: 0, //wraps child's width
                  height: 0, //wraps child's height
                  child: dialogButton(widget.app, context,
                      label: 'Reply',
                      onPressed: () => widget.isEditable
                          ? allowToAddCommentComment(context, postDetail, data,
                              data.member!.documentID!)
                          : null)),
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
      PostCommentContainer postComment) {
    return PopupMenuButton(
        icon: Icon(Icons.more_vert),
        itemBuilder: (_) => <PopupMenuItem<int>>[
              new PopupMenuItem<int>(
                  child: text(widget.app, context, 'Update comment'), value: 0),
              new PopupMenuItem<int>(
                  child: text(widget.app, context, 'Delete comment'), value: 1),
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
        iconButton(
          widget.app,
          context,
          icon: ImageIcon(_assetThumbUp(thisMemberLikeType)),
          onPressed: () =>
              widget.isEditable ? _like(context, postDetails) : null,
        ),
        text(
          widget.app,
          context,
          "$likes",
        ),
        Spacer(flex: 3),
        iconButton(
          widget.app,
          context,
          icon: ImageIcon(_assetThumbDown(thisMemberLikeType)),
          onPressed: () =>
              widget.isEditable ? _dislike(context, postDetails) : null,
        ),
        text(
          widget.app,
          context,
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
      child: text(
        widget.app,
        context,
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
