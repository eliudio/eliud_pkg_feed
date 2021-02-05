import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/components/page_body_helper.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/page_component_bloc.dart';
import 'package:eliud_core/model/page_component_event.dart';
import 'package:eliud_core/model/page_component_state.dart';
import 'package:eliud_core/platform/platform.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_core/tools/widgets/request_value_dialog.dart';
import 'package:eliud_core/tools/widgets/yes_no_dialog.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_list_event.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/post_bloc.dart';
import 'bloc/post_event.dart';
import 'bloc/post_state.dart';

class PostWidget extends StatefulWidget {
  final bool isRecursive;
  final MemberModel member;

  const PostWidget({Key key, this.isRecursive, this.member}) : super(key: key);

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

  Size size;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostLoaded) {
        if (size == null) size = MediaQuery.of(context).size;
        var originalAccessBloc = BlocProvider.of<AccessBloc>(context);

        return Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.7),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: new BorderRadius.all(
                      const Radius.circular(10.0),
                    )),
                child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _heading(context, state.postModel, state.memberId),
                        _postDetails(state.memberId, state.postModel,
                            originalAccessBloc, context),
                        _aBitSpace(),
                        _postLikes(
                            state.postModel.likes, state.postModel.dislikes),
                        _aBitSpace(),
                        _dividerLight(),
                        _postActionBtns(
                            context,
                            state.postModel,
                            state.memberId,
                            state is CommentsLoaded
                                ? state.thisMembersLikeType
                                : null),
                        _aBitSpace(),
                        _dividerLight(),
                        _aBitSpace(),
                        _enterComment(state.postModel),
                        _aBitSpace(),
                        _postComments(context, state.postModel, state.memberId,
                            state is CommentsLoaded ? state.comments : null),
                      ],
                    ))));
      } else {
        return DelayedCircularProgressIndicator();
      }
    });
  }

  Widget _enterComment(PostModel postModel) {
    var avatar =
        AbstractPlatform.platform.getImageFromURL(url: widget.member.photoURL);
    return Row(children: [
      Container(
          height: 40, width: 40, child: avatar == null ? Container() : avatar),
      Container(width: 8),
      Flexible(
        child: Container(
            alignment: Alignment.center, height: 30, child: _textField()),
      ),
      Container(width: 8),
      Container(
          height: 30,
          child: RaisedButton(
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text('Ok'),
              onPressed: () => _addComment(postModel))),
    ]);
  }

  void _addComment(PostModel postModel) {
    BlocProvider.of<PostBloc>(context)
        .add(AddCommentEvent(postModel, _commentController.text));
    _commentController.clear();
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

  Widget _heading(BuildContext context, PostModel postModel, String memberId) {
    var avatar = AbstractPlatform.platform
        .getImageFromURL(url: postModel.author.photoURL);
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
        Text(postModel.author.name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left),
        Text(postModel.timestamp,
            style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
      ])
    ];
    if (memberId == postModel.author.documentID) {
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
                  .add(AddCommentCommentEvent(postCommentContainer, comment));
            }
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  void allowToUpdateComment(BuildContext context, PostModel postModel,
      String memberId, PostCommentContainer postCommentContainer) {
    DialogStatefulWidgetHelper.openIt(
      context,
      RequestValueDialog(
          title: 'Update comment',
          yesButtonText: 'Update comment',
          noButtonText: 'Discard',
          hintText: 'Comment',
          initialValue: postCommentContainer.comment,
          yesFunction: (comment) {
            BlocProvider.of<PostBloc>(context).add(
                UpdateCommentEvent(postCommentContainer.postComment, comment));
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  void allowToDeleteComment(BuildContext context, PostModel postModel,
      String memberId, PostCommentContainer postCommentContainer) {
    DialogStatefulWidgetHelper.openIt(
        context,
        YesNoDialog(
          title: "Delete comment",
          message: "Do you want to delete this comment",
          yesFunction: () async {
            Navigator.pop(context);
            BlocProvider.of<PostBloc>(context)
                .add(DeleteCommentEvent(postCommentContainer.postComment));
          },
          noFunction: () => Navigator.pop(context),
          yesButtonLabel: 'Yes',
          noButtonLabel: 'No',
        ));
  }

  Widget _postDetails(String memberId, PostModel postModel,
      AccessBloc originalAccessBloc, BuildContext context) {
    String appId = postModel.postAppId;
    String pageId = postModel.postPageId;
    Map<String, Object> parameters = postModel.pageParameters;
    var asPlaystore = false;
    var blocProviders = <BlocProvider>[];
    blocProviders.add(BlocProvider<AccessBloc>(
        create: (context) =>
            AccessBloc(null)..add(InitApp(appId, asPlaystore))));
    return MultiBlocProvider(
        providers: blocProviders,
        child: Container(
            child: widget.isRecursive
                ? Text(
                    "This link is a reference to this feed. I'm showing recursive pages.")
                : BlocBuilder<AccessBloc, AccessState>(
                    builder: (context, accessState) {
                    if (accessState is AppLoaded) {
                      return Container(
                          height: 300,
                          child: _body(context, originalAccessBloc, accessState,
                              appId, pageId, parameters));
                    } else {
                      return Center(
                        child: DelayedCircularProgressIndicator(),
                      );
                    }
                  })));
  }

  Widget _body(
      BuildContext context,
      AccessBloc originalAccessBloc,
      AccessState accessState,
      String appId,
      String pageId,
      Map<String, Object> parameters) {
    return Stack(
      children: <Widget>[
        MultiBlocProvider(
            providers: [
              BlocProvider<PageComponentBloc>(
                create: (context) => PageComponentBloc(
                    pageRepository: pageRepository(appId: appId))
                  ..add(FetchPageComponent(id: pageId)),
              ),
            ],
            child: BlocBuilder<PageComponentBloc, PageComponentState>(
                builder: (context, state) {
              if (state is PageComponentLoaded) {
                if (state.value == null) {
                  return AlertWidget(
                      title: 'Error', content: 'No page defined');
                } else {
                  var helper = PageBodyHelper();
                  var components = helper.getComponents(
                      state.value.bodyComponents, parameters);
                  return helper.theBody(context, accessState,
                      backgroundDecoration: state.value.background,
                      components: components,
                      layout: fromPageLayout(state.value.layout),
                      gridView: state.value.gridView);
                }
              } else {
                return Center(
                  child: DelayedCircularProgressIndicator(),
                );
              }
            })),
        InkWell(
            onTap: () {
              originalAccessBloc
                  .add(SwitchAppAndPageEvent(appId, pageId, parameters));
            },
            child: new Container(
              width: 1000,
              height: 1000,
//            color: Colors.green,
            ))
      ],
    );
  }

  Widget _postComments(BuildContext context, PostModel postModel,
      String memberId, List<PostCommentContainer> comments) {
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
  }

  Widget getCommentTreeWidget(
      BuildContext context, PostModel postModel, PostCommentContainer data) {
    var rowChildren = [
      CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        backgroundImage: AbstractPlatform.platform
            .getImageProviderFromURL(data.member.photoURL),
      ),
      Container(width: 8),
      Expanded(
          child: Container(
            constraints: BoxConstraints(minWidth: 150),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.member.name}',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${data.comment}',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontWeight: FontWeight.w300, color: Colors.black),
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      data.postComment.likes == null
                          ? 'no likes'
                          : '${data.postComment.likes} likes',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    )),
              ],
            ),
          )),
    ];
    if (widget.member.documentID == data.member.documentID) {
      rowChildren.add(_optionsPostComments(
          context, postModel, data.member.documentID, data));
    }

    var header = Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: IntrinsicHeight(
                    child: Row(children: rowChildren))),
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
                child: FlatButton(
                    child: Text('Like',
                        style: data.thisMemberLikesThisComment
                            ? TextStyle(fontWeight: FontWeight.w900)
                            : null),
                    onPressed: () => _likeComment(context, postModel,
                        data)), //your original button
              ),
              ButtonTheme(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 8.0), //adds padding inside the button
                  materialTapTargetSize: MaterialTapTargetSize
                      .shrinkWrap, //limits the touch area to the button area
                  minWidth: 0, //wraps child's width
                  height: 0, //wraps child's height
                  child: FlatButton(
                      child: Text('Reply'),
                      onPressed: () => allowToAddCommentComment(
                          context, data, data.member.documentID))),
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
      for (int i = 0; i < data.postCommentContainer.length; i++) {
        children.add(getCommentTreeWidget(
            context, postModel, data.postCommentContainer[i]));
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
      PostModel postModel, String memberId, PostCommentContainer postComment) {
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

  Widget _postActionBtns(BuildContext context, PostModel postModel,
      String memberId, LikeType thisMemberLikeType) {
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
  }

  Future<void> _like(BuildContext context, PostModel postModel) async {
    BlocProvider.of<PostBloc>(context)
        .add(LikePostEvent(postModel, LikeType.Like));
  }

  Future<void> _likeComment(BuildContext context, PostModel postModel,
      PostCommentContainer postCommentContainer) async {
    BlocProvider.of<PostBloc>(context)
        .add(LikeCommentPostEvent(postModel, postCommentContainer, LikeType.Like));
  }

  void _dislike(BuildContext context, PostModel postModel) async {
    BlocProvider.of<PostBloc>(context)
        .add(LikePostEvent(postModel, LikeType.Dislike));
  }

  Widget _postLikes(int likes, int dislikes) {
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
}
