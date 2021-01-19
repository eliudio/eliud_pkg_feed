import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/rgb_model.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/extensions/widgets/post.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/post_paged_bloc.dart';
import 'bloc/post_paged_event.dart';
import 'bloc/post_paged_state.dart';

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
      return _postPagedBloc(parentPageId, context, feedModel, EliudQuery()
          // We could limit the posts retrieve by making adding the condition: 'authorId' whereIn FollowerHelper.following(me, state.app.documentID)
          // However, combining this query with arrayContainsAny in 1 query is not possible currently in the app.
          // For now we lay the responsibility with the one posting the post, i.e. that the readAccess includes the person.
          // More comments, see firestore.rules > match /post/{id} > allow create
          .withCondition(EliudQueryCondition('readAccess', arrayContainsAny: [state.getMember().documentID, 'PUBLIC']))
        );
    } else if (state is AppLoaded) {
        return _postPagedBloc(parentPageId, context, feedModel, EliudQuery()
            .withCondition(EliudQueryCondition('readAccess', arrayContains: 'PUBLIC')));
    } else {
      return Center(child: DelayedCircularProgressIndicator());
    }
  }

  Widget _postPagedBloc(String parentPageId, BuildContext context, FeedModel feedModel, EliudQuery eliudQuery) {
    return BlocProvider(
      create: (_) => PostPagedBloc(
        eliudQuery,
        BlocProvider.of<AccessBloc>(context),
        postRepository: postRepository(appId: feedModel.appId),
      )..add(PostPagedFetched()),
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
  PostPagedBloc _postBloc;
  AppModel _app;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostPagedBloc>(context);
    _app = AccessBloc.app(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostPagedBloc, PostPagedState>(
      builder: (context, state) {
        switch (state.status) {
          case PostPagedStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PostPagedStatus.success:
            if (state.values.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.values.length
                    ? _buttonNextPage()
                    : post(state.values[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.values.length
                  : state.values.length + 1,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget post(PostModel postModel) {
    return Post(postModel, recursive: postModel.postPageId == widget.parentPageId,);
  }

  Widget _buttonNextPage() {
    return MyButton(
      buttonColor: _app.formSubmitButtonColor,
      onClickFunction: _onClick,
    );
  }

  void _onClick() {
    _postBloc.add(PostPagedFetched());
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
