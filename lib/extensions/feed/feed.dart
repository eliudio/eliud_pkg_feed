import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'posts/paged_posts_list.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart'
    as posts;

class Feed extends StatefulWidget {
  final FeedModel feedModel;

  Feed(this.feedModel);

  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  _FeedState();

  @override
  Widget build(BuildContext context) {
    var theState = AccessBloc.getState(context);
    if (theState is AppLoaded) {
      return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileInitialised) {
          return _getIt(context, widget.feedModel, state);
        } else {
          return StyleRegistry.registry()
              .styleWithContext(context)
              .frontEndStyle()
              .progressIndicatorStyle()
              .progressIndicator(context);
        }
      });
    } else {
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .textStyle()
          .text(context, 'App not loaded');
    }
  }

  Widget _getIt(
      BuildContext context, FeedModel feedModel, ProfileInitialised state) {
    EliudQuery eliudQuery = ProfileBloc.postQuery(state);
    return BlocProvider(
      create: (_) => PostListPagedBloc(state.memberId() ?? 'PUBLIC', eliudQuery,
          postRepository: posts.postRepository(appId: feedModel.appId)!)
        ..add(PostListPagedFetched()),
      child: PagedPostsList(feedModel),
    );
  }
}
