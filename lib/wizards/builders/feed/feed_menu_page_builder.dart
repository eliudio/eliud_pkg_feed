import 'package:eliud_core/core/wizards/builders/single_component_page_builder.dart';
import 'package:eliud_core/core/wizards/tools/document_identifier.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core_model/tools/etc/random.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_model.dart';
import 'package:eliud_pkg_follow/wizards/builders/follow/follow_requests_dashboard_page_builder.dart';
import 'package:eliud_pkg_follow/wizards/builders/follow/followers_dashboard_page_builder.dart';
import 'package:eliud_pkg_follow/wizards/builders/follow/following_dashboard_page_builder.dart';
import 'package:eliud_pkg_follow/wizards/builders/follow/invite_dashboard_page_builder.dart';
import 'package:eliud_pkg_follow/model/follow_requests_dashboard_component.dart';
import 'package:eliud_pkg_follow/model/following_dashboard_component.dart';
import 'package:eliud_pkg_follow/model/invite_dashboard_component.dart';

import 'feed_front_page_builder.dart';

class FeedMenuPageBuilder extends SingleComponentPageBuilder {
  FeedMenuPageBuilder(
    super.uniqueId,
    super.pageId,
    super.app,
    super.memberId,
    super.theHomeMenu,
    super.theAppBar,
    super.leftDrawer,
    super.rightDrawer,
  );

  static Future<FeedModel> assertFeedModel(FeedModel? feed,
      String? feedIdentifier, String appId, String uniqueId) async {
    if (feed == null) {
      if (feedIdentifier == null) {
        throw Exception('If feed is null, feedIdentifier needs to be supplied');
      } else {
        var newFeed = FeedModel(
            documentID: constructDocumentId(
                uniqueId: uniqueId, documentId: feedIdentifier),
            appId: appId,
            description: 'New feed',
            thumbImage: ThumbStyle.thumbs,
            photoPost: true,
            videoPost: true,
            messagePost: true,
            audioPost: false,
            albumPost: true,
            articlePost: true);
        await feedRepository(appId: appId)!.add(newFeed);
        return newFeed;
      }
    } else {
      return feed;
    }
  }

  Future<PageModel> run({
    required FeedModel? feed,
    required String? feedIdentifier,
    required String feedMenuComponentIdentifier,
    required String feedFrontComponentIdentifier,
    required String followRequestsDashboardComponentIdentifier,
    required String followersDashboardComponentIdentifier,
    required String followingDashboardComponentIdentifier,
    required String inviteDashboardComponentIdentifier,
    required String profileComponentIdentifier,
  }) async {
    var appId = app.documentID;
    var newFeed = await assertFeedModel(feed, feedIdentifier, appId, uniqueId);
    var feedMenuPageId =
        constructDocumentId(uniqueId: uniqueId, documentId: pageId);

    var newFeedFront = await FeedFrontPageBuilder.setupDashboard(
        app, newFeed, uniqueId, feedFrontComponentIdentifier);
    await FollowRequestsDashboardPageBuilder.setupDashboard(feedMenuPageId, app,
        uniqueId, followRequestsDashboardComponentIdentifier);
    await FollowersDashboardPageBuilder.setupDashboard(
        feedMenuPageId, app, uniqueId, followersDashboardComponentIdentifier);
    await FollowingDashboardPageBuilder.setupDashboard(
        feedMenuPageId, app, uniqueId, followingDashboardComponentIdentifier);
    await InviteDashboardPageBuilder.setupDashboard(
        feedMenuPageId, app, uniqueId, inviteDashboardComponentIdentifier);
    var feedMenu = FeedMenuModel(
      documentID: constructDocumentId(
          uniqueId: uniqueId, documentId: feedMenuComponentIdentifier),
      appId: app.documentID,
      description: 'Feed',
      itemColor: null,
      selectedItemColor: null,
      feedFront: newFeedFront,
      bodyComponentsCurrentMember: [
        followRequestsDashboardComponent(
            followRequestsDashboardComponentIdentifier),
        followersDashboardComponent(followersDashboardComponentIdentifier),
        followingDashboardComponent(followingDashboardComponentIdentifier),
        inviteDashboardComponent(inviteDashboardComponentIdentifier),
      ],
      bodyComponentsOtherMember: [],
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
    feedMenuRepository(appId: app.documentID)!.add(feedMenu);
    return await doIt(
        componentName: AbstractFeedMenuComponent.componentName,
        componentIdentifier: feedMenuComponentIdentifier,
        title: "Feed",
        description: "Feed");
  }

  LabelledBodyComponentModel followRequestsDashboardComponent(
          String componentId) =>
      LabelledBodyComponentModel(
          documentID: newRandomKey(),
          label: 'Follow Requests',
          componentName: AbstractFollowRequestsDashboardComponent.componentName,
          componentId:
              constructDocumentId(uniqueId: uniqueId, documentId: componentId));
  LabelledBodyComponentModel followersDashboardComponent(String componentId) =>
      LabelledBodyComponentModel(
          documentID: newRandomKey(),
          label: 'Followers',
          componentName: AbstractFollowingDashboardComponent.componentName,
          componentId:
              constructDocumentId(uniqueId: uniqueId, documentId: componentId));
  LabelledBodyComponentModel followingDashboardComponent(String componentId) =>
      LabelledBodyComponentModel(
          documentID: newRandomKey(),
          label: 'Following',
          componentName: AbstractFollowingDashboardComponent.componentName,
          componentId:
              constructDocumentId(uniqueId: uniqueId, documentId: componentId));
  LabelledBodyComponentModel inviteDashboardComponent(String componentId) =>
      LabelledBodyComponentModel(
          documentID: newRandomKey(),
          label: 'Invite',
          componentName: AbstractInviteDashboardComponent.componentName,
          componentId:
              constructDocumentId(uniqueId: uniqueId, documentId: componentId));
}
