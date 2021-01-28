import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/components/page_body_helper.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/page_component_bloc.dart';
import 'package:eliud_core/model/page_component_event.dart';
import 'package:eliud_core/model/page_component_state.dart';
import 'package:eliud_core/platform/platform.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_core/tools/widgets/request_value_dialog.dart';
import 'package:eliud_core/tools/widgets/yes_no_dialog.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_list_event.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/post_bloc.dart';
import 'bloc/post_event.dart';
import 'bloc/post_state.dart';

class PostWidget extends StatelessWidget {
  static TextStyle textStyleSmall =
      TextStyle(fontSize: 8, fontWeight: FontWeight.bold);
  static TextStyle textStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  final bool isRecursive;
  Size size;

  PostWidget({Key key, this.isRecursive, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostLoaded) {
        if (size == null) size = MediaQuery.of(context).size;
        var originalAccessBloc = BlocProvider.of<AccessBloc>(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heading(context, state.postModel, state.memberId),
            _postDetails(
                state.memberId, state.postModel, originalAccessBloc, context),
            _postActionBtns(context, state.postModel, state.memberId,
                state is CommentsLoaded ? state.thisMembersLikeType : null),
            _postLikes(state.postModel.likes, state.postModel.dislikes),
            _postComments(context, state.postModel, state.memberId, state is CommentsLoaded ? state.comments : null),

          ],
        );
      } else {
        return DelayedCircularProgressIndicator();
      }
    });
  }

  Widget _divider() {
    return Divider(height: 10, thickness: 2, color: Colors.black);
  }

  Widget _heading(BuildContext context, PostModel postModel, String memberId) {
    var widgets = <Widget>[
      Text(postModel.author.name, style: textStyle),
      Spacer(),
      Text(postModel.timestamp, style: textStyle),
      Spacer(),
    ];
    if (memberId == postModel.author.documentID) {
      widgets.add(_optionsPost(context, postModel, memberId));
    }
    return Row(children: widgets);
  }

  PopupMenuButton _optionsPost(BuildContext context, PostModel postModel, String memberId) {
    return PopupMenuButton(
      icon: Icon(Icons.more_horiz),
      itemBuilder: (_) => <PopupMenuItem<int>>[
/*
        TODO: Issue with deleting post:
        Deleting the posts in a feed is an issue. A block inside a list seems the issue.
        I assumed this to be an issue because of the listen, but it seems it has to do with the block.
        I've created another branch paged-feed-alternative which is a feed without the listen.
        But it's equally a problem. Now what? Let's not support delete.
        new PopupMenuItem<int>(
            child: const Text('Delete post'), value: 0),
*/
        new PopupMenuItem<int>(
            child: const Text('Add comment'), value: 1),
      ],
      onSelected: (choice) {
/*
        if (choice == 0) {
          BlocProvider.of<PostListBloc>(context)
              .add(DeletePostList(value: postModel));
        } else {
*/
          allowToAddComment(context, postModel, memberId);
/*
        }
*/
      });
  }

  void allowToAddComment(BuildContext context, PostModel postModel, String memberId) {
    DialogStatefulWidgetHelper.openIt(
      context,
      RequestValueDialog(
          title: 'Add comment to post',
          yesButtonText: 'Add comment',
          noButtonText: 'Discard',
          hintText: 'Comment',
          yesFunction: (comment) {
            BlocProvider.of<PostBloc>(context)
                .add(AddCommentEvent(postModel, comment));
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  void allowToUpdateComment(BuildContext context, PostModel postModel, String memberId, PostCommentContainer postCommentContainer) {
    DialogStatefulWidgetHelper.openIt(
      context,
      RequestValueDialog(
          title: 'Update comment',
          yesButtonText: 'Update comment',
          noButtonText: 'Discard',
          hintText: 'Comment',
          initialValue: postCommentContainer.comment,
          yesFunction: (comment) {
            BlocProvider.of<PostBloc>(context)
                .add(UpdateCommentEvent(postCommentContainer.postComment, comment));
            Navigator.pop(context);
          },
          noFunction: () => Navigator.pop(context)),
    );
  }

  void allowToDeleteComment(BuildContext context, PostModel postModel, String memberId, PostCommentContainer postCommentContainer) {
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
    var avatar = AbstractPlatform.platform
        .getImageFromURL(url: postModel.author.photoURL);
    return MultiBlocProvider(
        providers: blocProviders,
        child: ListTile(
            leading: Container(
                height: 100,
                width: 100,
                child: avatar == null ? Container() : avatar),
            title: isRecursive
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

  Widget _postComments(BuildContext context, PostModel postModel, String memberId, List<PostCommentContainer> comments) {
    if (comments == null) {
      return _divider();
    } else {
      return ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: comments.length + 1,
          itemBuilder: (context, i) {
            if (i < comments.length) {
              var postComment = comments[i];
              return ListTile(
                  leading: AbstractPlatform.platform
                      .getImageFromURL(url: postComment.member.photoURL),
                  title:
                      Text(postComment.dateTime + ": " + postComment.comment),
                  trailing: _optionsPostComments(context, postModel,
                      memberId, postComment)
              );
            } else {
              return _divider();
            }
          });
    }
  }

  PopupMenuButton _optionsPostComments(BuildContext context, PostModel postModel,
      String memberId, PostCommentContainer postComment) {
    return PopupMenuButton(
        icon: Icon(Icons.more_horiz),
        itemBuilder: (_) => <PopupMenuItem<int>>[
          new PopupMenuItem<int>(
              child: const Text('Update comment'), value: 0),
          new PopupMenuItem<int>(
              child: const Text('Delete comment'), value: 1),
        ],
        onSelected: (choice) {
          if (choice == 0) {
            allowToUpdateComment(context, postModel, memberId, postComment);
          } else {
            allowToDeleteComment(context, postModel, memberId, postComment);
          }
        }
    );
  }

  Widget _postActionBtns(BuildContext context, PostModel postModel,
      String memberId, LikeType thisMemberLikeType) {
    return Row(
      children: <Widget>[
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

        Spacer(),
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
        IconButton(
            icon: ImageIcon(
              AssetImage(
                  "assets/images/basicons.xyz/CommentCircleChatMessage.png",
                  package: "eliud_pkg_feed"),
            ),
            onPressed: () => allowToAddComment(context, postModel, memberId),
            color: Colors.black),
        // if thumbsdown is allowed?
/*
        Spacer(),
        IconButton(
            icon: ImageIcon(
              AssetImage("assets/images/basicons.xyz/Forward.png",
                  package: "eliud_pkg_feed"),
            ),
            onPressed: null,
            color: Colors.black),
*/
      ],
    );
  }

  Future<void> _like(BuildContext context, PostModel postModel) async {
    BlocProvider.of<PostBloc>(context)
        .add(LikePostEvent(postModel, LikeType.Like));
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
