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
import 'package:eliud_pkg_feed/model/post_like_model.dart';
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
            _postComments(state is CommentsLoaded ? state.comments : null),
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
      widgets.add(IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () => _optionsPost(context),
      ));
    }
    return Row(children: widgets);
  }

  void _optionsPost(BuildContext context) {
    new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
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

  Widget _postComments(List<PostCommentContainer> comments) {
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
                  trailing: IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () => _optionsPostComments(),
                  ));
            } else {
              return _divider();
            }
          });
    }
  }

  void _optionsPostComments() {}

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
            onPressed: () => _comment(context, postModel, memberId),
            color: Colors.black),
        // if thumbsdown is allowed?
        Spacer(),
        IconButton(
            icon: ImageIcon(
              AssetImage("assets/images/basicons.xyz/Forward.png",
                  package: "eliud_pkg_feed"),
            ),
            onPressed: null,
            color: Colors.black),
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

  void _comment(BuildContext context, PostModel postModel, String memberId) {
    BlocProvider.of<PostBloc>(context)
        .add(AddCommentEvent(postModel, 'A comment'));
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
