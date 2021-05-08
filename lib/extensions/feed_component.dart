import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'paged_posts_list.dart';
import 'postlist_paged/postlist_paged_bloc.dart';
import 'postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart'
    as posts;
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';

class FeedComponentConstructorDefault implements ComponentConstructor {
  FeedComponentConstructorDefault();

  Widget createNew({String? id, Map<String, dynamic>? parameters}) {
    return FeedComponent(id: id);
  }
}

class FeedComponent extends AbstractFeedComponent {
  String? parentPageId;

  FeedComponent({String? id}) : super(feedID: id);

  @override
  void initState() {

  }

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, FeedModel? feedModel) {
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    var settings = modalRoute.settings;
    if (settings == null) return Text("no feed specified");
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
                  isEqualTo: feedModel!.documentID))
              // We could limit the posts retrieve by making adding the condition: 'authorId' whereIn FollowerHelper.following(me, state.app.documentID)
              // However, combining this query with arrayContainsAny in 1 query is not possible currently in the app.
              // For now we lay the responsibility with the one posting the post, i.e. that the readAccess includes the person.
              // More comments, see firestore.rules > match /post/{id} > allow create
              .withCondition(EliudQueryCondition('readAccess',
                  arrayContainsAny: [state.getMember()!.documentID, 'PUBLIC'])));
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

  Widget _postPagedBloc(String? parentPageId, BuildContext context,
      FeedModel? feedModel, EliudQuery eliudQuery) {
    var app = AccessBloc.app(context);
    var state = AccessBloc.getState(context);
    var memberPublicInfoModel = AccessBloc.memberPublicInfoModel(state);
    if (memberPublicInfoModel == null) {
      return Text("No member public info for member");
    } else {
      return BlocProvider(
        create: (_) =>
        PostListPagedBloc(eliudQuery,
            postRepository: posts.postRepository(appId: feedModel!.appId)!)
          ..add(PostListPagedFetched()),
        child: PagedPostsList(
            feedModel!, memberPublicInfoModel, parentPageId: parentPageId),
      );
    }
  }

  @override
  FeedRepository getFeedRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .feedRepository(AccessBloc.appId(context))!;
  }
}
