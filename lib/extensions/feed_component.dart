import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/navigation_event.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
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
  FeedComponent({String? id}) : super(feedID: id);

  @override
  void initState() {}

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, FeedModel? feedModel) {
/*
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    var settings = modalRoute.settings;
    parentPageId = settings.name;
*/
    AccessState state = AccessBloc.getState(context);
    var pageContextInfo = PageParamHelper.getPagaContextInfo(context);
    var parentPageId = pageContextInfo.pageId;
    if (state is LoggedIn) {
      SwitchFeedHelper switchFeedHelper =
          SwitchFeedHelper(pageContextInfo, state);

      return FutureBuilder<WhichFeed>(
          future: switchFeedHelper.getWhichFeed(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var whichFeed = snapshot.data;
              var feedMemberId = switchFeedHelper.feedMember();
              var memberId = state.member.documentID!;
              // We could limit the posts retrieve by making adding the condition: 'authorId' whereIn FollowerHelper.following(me, state.app.documentID)
              // However, combining this query with arrayContainsAny in 1 query is not possible currently in the app.
              // For now we lay the responsibility with the one posting the post, i.e. that the readAccess includes the person.
              // More comments, see firestore.rules > match /post/{id} > allow create

              // When we post, we indicate we post to public, followers or just me. The readAccess field is determined with that indicator with the following entries
              // - public: readAccess becomes "PUBLIC", + the list of followers + me
              // - followers: readAccess becomes the list of followers + me
              // - me: readAccess becomes me
              var query;
              switch (whichFeed) {
                case WhichFeed.MyFeed:
                  // query where I'm in the readAccess, which means I see my posts and everybody's
                  // posts where I was included as follower, be it indicated as publc of as follower:
                  // We're not interested in ALL people's posts, we're only interested in the posts of ourselves or
                  // or the people I follow
                  query = EliudQuery()
                      .withCondition(EliudQueryCondition('archived',
                      isEqualTo: PostArchiveStatus.Active.index))
                      .withCondition(
                      EliudQueryCondition('feedId', isEqualTo: feedModel!.documentID))
                      .withCondition(EliudQueryCondition('readAccess',
                      arrayContainsAny: [switchFeedHelper.currentMember()]));
                  break;
                case WhichFeed.OnlyMyFeed:
                  // query where I'm the author. We could include that we're part of the readAccess but that's obsolete
                  query = EliudQuery()
                      .withCondition(EliudQueryCondition('archived',
                      isEqualTo: PostArchiveStatus.Active.index))
                      .withCondition(
                      EliudQueryCondition('authorId', isEqualTo: switchFeedHelper.currentMember()))
                      .withCondition(
                      EliudQueryCondition('feedId', isEqualTo: feedModel!.documentID)
                      );
                  break;
                case WhichFeed.SomeoneIFollow:
                  // query where that person is the author and I'm in the readAccess
                  query = EliudQuery()
                      .withCondition(EliudQueryCondition('archived',
                      isEqualTo: PostArchiveStatus.Active.index))
                      .withCondition(EliudQueryCondition('authorId',
                      isEqualTo: switchFeedHelper.feedMember()))
                      .withCondition(
                      EliudQueryCondition('feedId', isEqualTo: feedModel!.documentID))
                      .withCondition(EliudQueryCondition('readAccess',
                      arrayContainsAny: [switchFeedHelper.currentMember()]));
                  break;
                case WhichFeed.SomeoneElse:
                  // query where that person is the author and PUBLIC in the readAccess
                  query = EliudQuery()
                      .withCondition(EliudQueryCondition('archived',
                      isEqualTo: PostArchiveStatus.Active.index))
                      .withCondition(EliudQueryCondition('authorId',
                      isEqualTo: switchFeedHelper.feedMember()))
                      .withCondition(
                      EliudQueryCondition('feedId', isEqualTo: feedModel!.documentID))
                      .withCondition(EliudQueryCondition('readAccess',
                      arrayContainsAny: ['PUBLIC']));
                  break;
              }

              /*
         Watching my feed: query where I'm part of readAccess, which means I see my posts and everybody's posts
         Watching my feed only: query where I'm the author
         Watching someone else's feed which I follow: query where I'm part of readAccess and author is that person
         Watching someone else's feed which I do not follow: query where PUBLIC is in readAccess
      */
              return _postPagedBloc(
                  parentPageId, context, feedModel, query, switchFeedHelper);
            } else {
              return Center(child: DelayedCircularProgressIndicator());
            }
          }
      );

    } else if (state is AppLoaded) {
      return Text("No feed, not logged in");
    } else {
      return Center(child: DelayedCircularProgressIndicator());
    }
  }

  Widget _postPagedBloc(
      String? parentPageId,
      BuildContext context,
      FeedModel? feedModel,
      EliudQuery eliudQuery,
      SwitchFeedHelper switchFeedHelper) {
    var app = AccessBloc.app(context);
    var state = AccessBloc.getState(context);
    var memberPublicInfoModel = AccessBloc.memberPublicInfoModel(state);
    if (memberPublicInfoModel == null) {
      return Text("No member public info for member");
    } else {
      return BlocProvider(
        create: (_) => PostListPagedBloc(eliudQuery,
            postRepository: posts.postRepository(appId: feedModel!.appId)!)
          ..add(PostListPagedFetched()),
        child:
            PagedPostsList(feedModel!, memberPublicInfoModel, switchFeedHelper),
      );
    }
  }

  @override
  FeedRepository getFeedRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .feedRepository(AccessBloc.appId(context))!;
  }
}
