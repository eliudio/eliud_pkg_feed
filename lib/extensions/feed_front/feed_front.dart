import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'posts/paged_posts_list.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart'
    as posts;

class FeedFront extends StatefulWidget {
  final AppModel app;
  final FeedFrontModel feedFrontModel;

  FeedFront(this.app, this.feedFrontModel);

  _FeedFrontState createState() => _FeedFrontState();
}

class _FeedFrontState extends State<FeedFront> {
  _FeedFrontState();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
          if (accessState is AccessDetermined) {
            return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
              if (state is ProfileInitialised) {
                return _getIt(context, accessState, widget.feedFrontModel, state);
              } else {
                return progressIndicator(widget.app, context);
              }
            });
          } else {
            return progressIndicator(widget.app, context);
          }
        });
  }

  Widget _getIt(
      BuildContext context, AccessDetermined accessDetermined, FeedFrontModel feedFrontModel, ProfileInitialised state) {
    EliudQuery eliudQuery = ProfileBloc.postQuery(state);
    return BlocProvider(
      create: (_) => PostListPagedBloc(accessDetermined, state.memberId() ?? 'PUBLIC', eliudQuery,
          postRepository: posts.postRepository(appId: feedFrontModel.appId)!)
        ..add(PostListPagedFetched()),
      child: PagedPostsList(widget.app, feedFrontModel, backgroundOverride: widget.feedFrontModel.backgroundOverridePosts,),
    );
  }
}
