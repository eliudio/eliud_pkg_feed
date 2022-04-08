import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/core/wizards/tools/documentIdentifier.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_front_component.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/profile_component.dart';
import 'package:eliud_pkg_feed/wizards/builders/feed/follow_requests_dashboard_page_builder.dart';
import 'package:eliud_pkg_feed/wizards/builders/feed/followers_dashboard_page_builder.dart';
import 'package:eliud_pkg_feed/wizards/builders/feed/following_dashboard_page_builder.dart';
import 'package:eliud_pkg_feed/wizards/builders/feed/invite_dashboard_page_builder.dart';
import 'package:eliud_pkg_follow/model/follow_requests_dashboard_component.dart';
import 'package:eliud_pkg_follow/model/following_dashboard_component.dart';
import 'package:eliud_pkg_follow/model/invite_dashboard_component.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component.dart';
import 'package:flutter/material.dart';

import 'feed_front_page_builder.dart';
import 'other_feed_pages_builder.dart';

class FeedMenuPageBuilder extends OtherFeedPageBuilder {
  FeedMenuPageBuilder(
    String uniqueId,
    String pageId,
    AppModel app,
    String memberId,
    HomeMenuModel theHomeMenu,
    AppBarModel theAppBar,
    DrawerModel leftDrawer,
    DrawerModel rightDrawer,
    PageProvider pageProvider,
  ) : super(
          uniqueId,
          pageId,
          app,
          memberId,
          theHomeMenu,
          theAppBar,
          leftDrawer,
          rightDrawer,
          pageProvider,
        );

  static Future<FeedModel> assertFeedModel(FeedModel? feed, String? feedIdentifier, String appId, String uniqueId) async {
    if (feed == null) {
      if (feedIdentifier == null) {
        throw Exception('If feed is null, feedIdentifier needs to be supplied');
      } else {
        var newFeed = FeedModel(
            documentID: constructDocumentId(
                uniqueId: uniqueId, documentId: feedIdentifier),
            appId: appId,
            description: 'New feed',
            thumbImage: ThumbStyle.Thumbs,
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
    var appId = app.documentID!;
    var newFeed = await assertFeedModel(feed, feedIdentifier, appId, uniqueId);
    var feedMenuPageId = constructDocumentId(uniqueId: uniqueId, documentId: pageId);

    var newFeedFront = await FeedFrontPageBuilder.setupDashboard(
        app, newFeed, uniqueId, feedFrontComponentIdentifier);
    await FollowRequestsDashboardPageBuilder.setupDashboard(feedMenuPageId,
        app, uniqueId, followRequestsDashboardComponentIdentifier);
    await FollowersDashboardPageBuilder.setupDashboard(feedMenuPageId,
        app, uniqueId, followersDashboardComponentIdentifier);
    await FollowingDashboardPageBuilder.setupDashboard(feedMenuPageId,
        app, uniqueId, followingDashboardComponentIdentifier);
    await InviteDashboardPageBuilder.setupDashboard(feedMenuPageId,
        app, uniqueId, inviteDashboardComponentIdentifier);
    var feedMenu = FeedMenuModel(
      documentID: constructDocumentId(
          uniqueId: uniqueId, documentId: feedMenuComponentIdentifier),
      appId: app.documentID,
      description: 'Feed',
      itemColor: null,
      selectedItemColor: null,
      feedFront: newFeedFront,
      bodyComponentsCurrentMemberLabels: [
        "Follow Requests",
        "Followers",
        "Following",
        "Invite",
      ],
      bodyComponentsCurrentMember: [
        followRequestsDashboardComponent(
            followRequestsDashboardComponentIdentifier),
        followersDashboardComponent(followersDashboardComponentIdentifier),
        followingDashboardComponent(followingDashboardComponentIdentifier),
        inviteDashboardComponent(inviteDashboardComponentIdentifier),
      ],
      bodyComponentsOtherMember: [],
      bodyComponentsOtherMemberLabels: [],
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
    feedMenuRepository(appId: app.documentID)!.add(feedMenu);
    return await doIt(
        componentName: AbstractFeedMenuComponent.componentName,
        componentIdentifier: feedMenuComponentIdentifier,
        title: "Feed");
  }

  BodyComponentModel feedFrontComponent(String componentId) =>
      BodyComponentModel(
          documentID: newRandomKey(),
          componentName: AbstractFeedFrontComponent.componentName,
          componentId: constructDocumentId(uniqueId: uniqueId, documentId: componentId));
  BodyComponentModel followRequestsDashboardComponent(String componentId) =>
      BodyComponentModel(
          documentID: newRandomKey(),
          componentName: AbstractFollowRequestsDashboardComponent.componentName,
          componentId: constructDocumentId(uniqueId: uniqueId, documentId: componentId));
  BodyComponentModel followersDashboardComponent(String componentId) =>
      BodyComponentModel(
          documentID: newRandomKey(),
          componentName: AbstractFollowingDashboardComponent.componentName,
          componentId: constructDocumentId(uniqueId: uniqueId, documentId: componentId));
  BodyComponentModel followingDashboardComponent(String componentId) =>
      BodyComponentModel(
          documentID: newRandomKey(),
          componentName: AbstractFollowingDashboardComponent.componentName,
          componentId: constructDocumentId(uniqueId: uniqueId, documentId: componentId));
  BodyComponentModel inviteDashboardComponent(String componentId) =>
      BodyComponentModel(
          documentID: newRandomKey(),
          componentName: AbstractInviteDashboardComponent.componentName,
          componentId: constructDocumentId(uniqueId: uniqueId, documentId: componentId));
  BodyComponentModel profileComponent(String componentId) => BodyComponentModel(
      documentID: newRandomKey(),
      componentName: AbstractProfileComponent.componentName,
      componentId: constructDocumentId(uniqueId: uniqueId, documentId: componentId));
}
