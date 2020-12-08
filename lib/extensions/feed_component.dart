import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_feed/extensions/widgets/post.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';
import 'package:eliud_pkg_feed/model/post_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_list_event.dart';
import 'package:eliud_pkg_feed/model/post_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedComponentConstructorDefault implements ComponentConstructor {
  Widget createNew({String id, Map<String, String> parameters}) {
    return FeedComponent(id: id);
  }
}

class FeedComponent extends AbstractFeedComponent {
  FeedComponent({String id}) : super(feedID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, FeedModel feedModel) {
    // if logged on: show this person's feed
    // if not logged on, show public feed only
    // feed = posts where feedDocumentID == feedModel.documentID && appId = feedModel.appIdx
    // Need to improve generation of list bloc so that we can support multi page (or "load more") type of entries
    // Need to implement manually (I guess) the list widget
    // Need to support ordering
    return MultiBlocProvider(providers: [
      BlocProvider<PostListBloc>(
        create: (context) => PostListBloc(
          postRepository: postRepository(appId: feedModel.appId),
        )..add(LoadPostList(orderBy: 'timestamp', descending: true)),
      )
    ], child: _widget(context));
  }

  Widget _widget(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    if (accessState is AppLoaded) {
      return BlocBuilder<PostListBloc, PostListState>(
          builder: (context, state) {
        if (state is PostListLoaded) {
          final values = state.values;
          return ListView.builder(
            itemBuilder: buildList,
            itemCount: values.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  FeedRepository getFeedRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .feedRepository(AccessBloc.appId(context));
  }

  Widget buildList(BuildContext context, int index) {
    return Post(index);
  }
}
