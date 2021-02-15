import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/rgb_model.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';
import 'package:eliud_pkg_post/extensions/bloc/post_bloc.dart';
import 'package:eliud_pkg_post/extensions/post_widget.dart';
import 'package:eliud_pkg_post/model/abstract_repository_singleton.dart'
    as posts;
import 'package:eliud_pkg_post/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';

class FeedComponentConstructorDefault implements ComponentConstructor {
  FeedComponentConstructorDefault();

  Widget createNew({String id, Map<String, Object> parameters}) {
    return FeedComponent(id: id);
  }
}

class FeedComponent extends AbstractFeedComponent {
  String parentPageId;

  FeedComponent({String id}) : super(feedID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, FeedModel feedModel) {
    var modalRoute = ModalRoute.of(context);
    var settings = modalRoute.settings;
    parentPageId = settings.name;
    AccessState state = AccessBloc.getState(context);
    if (state is LoggedIn) {
      return _postPagedBloc(
          parentPageId,
          context,
          feedModel,
          EliudQuery()
              .withCondition(EliudQueryCondition('archived',
                  isEqualTo: PostArchiveStatus.Active.index))
              .withCondition(EliudQueryCondition('feedId',
                  isEqualTo: feedModel.documentID))
              // We could limit the posts retrieve by making adding the condition: 'authorId' whereIn FollowerHelper.following(me, state.app.documentID)
              // However, combining this query with arrayContainsAny in 1 query is not possible currently in the app.
              // For now we lay the responsibility with the one posting the post, i.e. that the readAccess includes the person.
              // More comments, see firestore.rules > match /post/{id} > allow create
              .withCondition(EliudQueryCondition('readAccess',
                  arrayContainsAny: [state.getMember().documentID, 'PUBLIC'])));
    } else if (state is AppLoaded) {
      return _postPagedBloc(
          parentPageId,
          context,
          feedModel,
          EliudQuery().withCondition(
              EliudQueryCondition('readAccess', arrayContains: 'PUBLIC')));
    } else {
      return Center(child: DelayedCircularProgressIndicator());
    }
  }

  Widget _postPagedBloc(String parentPageId, BuildContext context,
      FeedModel feedModel, EliudQuery eliudQuery) {
    return BlocProvider(
      create: (_) => PostListPagedBloc(eliudQuery,
          postRepository: posts.postRepository(appId: feedModel.appId))
        ..add(PostListPagedFetched()),
      child: PostsList(parentPageId: parentPageId),
    );
  }

  @override
  FeedRepository getFeedRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .feedRepository(AccessBloc.appId(context));
  }
}

class PostsList extends StatefulWidget {
  final String parentPageId;

  const PostsList({Key key, this.parentPageId}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  PostListPagedBloc _postBloc;
  AppModel _app;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostListPagedBloc>(context);
    _app = AccessBloc.app(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListPagedBloc, PostListPagedState>(
      builder: (context, state) {
        if (state is PostListPagedState) {
          var theState = state as PostListPagedState;
          return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return index >= theState.values.length
                    ? _buttonNextPage(!theState.hasReachedMax)
                    : post(context, theState.values[index]);
              },
              itemCount: theState.values.length + 1);
        } else {
          return Center(
            child: DelayedCircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget simplePost(BuildContext context, PostModel postModel) {
    return FlatButton(
        child: Text(postModel.documentID),
        onPressed: () => BlocProvider.of<PostListPagedBloc>(context)
            .add(DeletePostPaged(value: postModel)));
  }

  Widget post(BuildContext context, PostModel postModel) {
    var member = AccessBloc.memberFor(AccessBloc.getState(context));
    return BlocProvider<PostBloc>(
        create: (context) => PostBloc(postModel, member.documentID),
        child: PostWidget(
          isRecursive: postModel.postPageId == widget.parentPageId,
          member: member,
        ));
  }

  Widget _buttonNextPage(bool mightHaveMore) {
    if (mightHaveMore) {
      return MyButton(
        buttonColor: _app.formSubmitButtonColor,
        onClickFunction: _onClick,
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Divider(
                height: 5,
              );
            } else {
              return Center(
                  child: Text(
                "That's all folks",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ));
            }
          });
    }
  }

  void _onClick() {
    _postBloc.add(PostListPagedFetched());
  }
}

typedef OnClickFunction();

class MyButton extends StatefulWidget {
  final RgbModel buttonColor;
  final OnClickFunction onClickFunction;

  const MyButton({Key key, this.buttonColor, this.onClickFunction})
      : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool clicked;

  @override
  void initState() {
    super.initState();
    clicked = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!clicked) {
      return RaisedButton(
          color: RgbHelper.color(rgbo: widget.buttonColor),
          onPressed: () {
            setState(() {
              clicked = true;
            });
            widget.onClickFunction();
          },
          child: Text('More...'));
    } else {
      return RaisedButton(
          color: RgbHelper.color(rgbo: widget.buttonColor),
          onPressed: () {
            setState(() {
              clicked = true;
            });
            widget.onClickFunction();
          },
          child: Center(
              child: SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator())));
    }
  }
}
