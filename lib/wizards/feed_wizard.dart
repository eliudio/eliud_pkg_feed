import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_pkg_create/registry/registry.dart';
import 'package:eliud_pkg_create/widgets/new_app_bloc/action_specification.dart';
import 'package:eliud_pkg_create/widgets/new_app_bloc/builders/app_builder.dart';
import 'package:eliud_pkg_create/widgets/new_app_bloc/builders/helpers/menu_helpers.dart';
import 'package:eliud_pkg_create/widgets/new_app_widget.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'builders/feed/feed_page_builder.dart';
import 'builders/feed/follow_requests_dashboard_page_builder.dart';
import 'builders/feed/followers_dashboard_page_builder.dart';
import 'builders/feed/following_dashboard_page_builder.dart';
import 'builders/feed/invite_dashboard_page_builder.dart';
import 'builders/feed/membership_dashboard_page_builder.dart';
import 'builders/feed/profile_page_builder.dart';

class FeedWizard extends NewAppWizardInfo {
  static String FEED_PAGE_ID = 'feed';
  static String FEED_MENU_COMPONENT_IDENTIFIER = "feed_menu";
  static String FEED_HEADER_COMPONENT_IDENTIFIER = "feed_header";
  static String FEED_PROFILE_COMPONENT_IDENTIFIER = "feed_profile";
  static String PROFILE_PAGE_ID = 'profile';
  static String FOLLOW_REQUEST_PAGE_ID = 'follow_request';
  static String FOLLOWERS_PAGE_ID = 'followers';
  static String FOLLOWING_PAGE_ID = 'following';
  static String FIND_FRIEND_PAGE_ID = 'fiend_friends';
  static String APP_MEMBERS_PAGE_ID = 'app_members';
  static String FOLLOW_REQUEST_COMPONENT_ID = "follow_request";
  static String FOLLOWERS_COMPONENT_IDENTIFIER = "followers";
  static String FOLLOWING_COMPONENT_IDENTIFIER = "following";
  static String INVITE_COMPONENT_IDENTIFIER = "invite";
  static String MEMBERSHIP_COMPONENT_IDENTIFIER = "membership";
  static String PROFILE_COMPONENT_IDENTIFIER = "profile";

  FeedWizard() : super('feed', 'Feed');

  @override
  NewAppWizardParameters newAppWizardParameters() {
    return FeedParameters();
  }

  @override
  MenuItemModel? getMenuItemFor(AppModel app, NewAppWizardParameters parameters, MenuType type) {
    if (parameters is FeedParameters) {
      var feedSpecifications = parameters.feedPageSpecifications;
      bool generate = (type == MenuType.leftDrawerMenu) && feedSpecifications.availableInLeftDrawer ||
          (type == MenuType.rightDrawerMenu) && feedSpecifications.availableInRightDrawer ||
          (type == MenuType.bottomNavBarMenu) && feedSpecifications.availableInHomeMenu ||
          (type == MenuType.appBarMenu) && feedSpecifications.availableInAppBar;
      if (generate) {
        return menuItemFeed(app, FEED_PAGE_ID, 'Feed');
      }
    } else {
      throw Exception('Unexpected class for parameters: ' + parameters.toString());
    }
    return null;
  }

  @override
  Widget wizardParametersWidget(AppModel app, BuildContext context, NewAppWizardParameters parameters) {
    if (parameters is FeedParameters) {
      bool hasAccessToLocalFileSystem = AbstractMediumPlatform.platform!
          .hasAccessToLocalFilesystem();
      return ActionSpecificationWidget(
          app: app,
          enabled: hasAccessToLocalFileSystem,
          actionSpecification: parameters.feedPageSpecifications,
          label: 'Generate Feed');
    } else {
      return text(app, context, 'Unexpected class for parameters: ' + parameters.toString());
    }
  }

  List<NewAppTask>? getCreateTasks(
      AppModel app,
      NewAppWizardParameters parameters,
      MemberModel member,
      HomeMenuProvider homeMenuProvider,
      AppBarProvider appBarProvider,
      DrawerProvider leftDrawerProvider,
      DrawerProvider rightDrawerProvider,
      ) {
    if (parameters is FeedParameters) {
      var feedSpecifications = parameters.feedPageSpecifications;
      if (feedSpecifications.shouldCreatePageDialogOrWorkflow()) {
        List<NewAppTask> tasks = [];
        var memberId = member.documentID!;
        var feedModel;
        tasks.add(() async {
          print("feedModel");
          feedModel = await FeedPageBuilder(FEED_PAGE_ID, app, memberId,
              homeMenuProvider(), appBarProvider(), leftDrawerProvider(), rightDrawerProvider())
              .run(
              feedMenuComponentIdentifier: FEED_MENU_COMPONENT_IDENTIFIER,
              headerComponentIdentifier: FEED_HEADER_COMPONENT_IDENTIFIER,
              profileComponentIdentifier: FEED_PROFILE_COMPONENT_IDENTIFIER,
              feedPageId: FEED_PAGE_ID,
              profilePageId: PROFILE_PAGE_ID,
              followRequestPageId: FOLLOW_REQUEST_PAGE_ID,
              followersPageId: FOLLOWERS_PAGE_ID,
              followingPageId: FOLLOWING_PAGE_ID,
              fiendFriendsPageId: FIND_FRIEND_PAGE_ID,
              appMembersPageId: APP_MEMBERS_PAGE_ID);
        });

        tasks.add(() async {
          print("Follow Request");
          await FollowRequestsDashboardPageBuilder(FOLLOW_REQUEST_PAGE_ID, app,
              memberId, homeMenuProvider(), appBarProvider(), leftDrawerProvider(), rightDrawerProvider())
              .run(
            componentIdentifier: FOLLOW_REQUEST_COMPONENT_ID,
            profilePageId: PROFILE_PAGE_ID,
            feedPageId: FEED_PAGE_ID,
            feedMenuComponentIdentifier: FEED_MENU_COMPONENT_IDENTIFIER,
            headerComponentIdentifier: FEED_HEADER_COMPONENT_IDENTIFIER,
          );
        });
        tasks.add(() async {
          print("Followers Dashboard");
          await FollowersDashboardPageBuilder(FOLLOWERS_PAGE_ID, app, memberId,
              homeMenuProvider(), appBarProvider(), leftDrawerProvider(), rightDrawerProvider())
              .run(
            componentIdentifier: FOLLOWERS_COMPONENT_IDENTIFIER,
            profilePageId: PROFILE_PAGE_ID,
            feedPageId: FEED_PAGE_ID,
            feedMenuComponentIdentifier: FEED_MENU_COMPONENT_IDENTIFIER,
            headerComponentIdentifier: FEED_HEADER_COMPONENT_IDENTIFIER,
          );
        });
        tasks.add(() async {
          print("Following Dashboard");
          await FollowingDashboardPageBuilder(FOLLOWING_PAGE_ID, app, memberId,
              homeMenuProvider(), appBarProvider(), leftDrawerProvider(), rightDrawerProvider())
              .run(
            componentIdentifier: FOLLOWING_COMPONENT_IDENTIFIER,
            profilePageId: PROFILE_PAGE_ID,
            feedPageId: FEED_PAGE_ID,
            feedMenuComponentIdentifier: FEED_MENU_COMPONENT_IDENTIFIER,
            headerComponentIdentifier: FEED_HEADER_COMPONENT_IDENTIFIER,
          );
        });
        tasks.add(() async {
          print("Invite Dashboard");
          await InviteDashboardPageBuilder(FIND_FRIEND_PAGE_ID, app, memberId,
              homeMenuProvider(), appBarProvider(), leftDrawerProvider(), rightDrawerProvider())
              .run(
            componentIdentifier: INVITE_COMPONENT_IDENTIFIER,
            profilePageId: PROFILE_PAGE_ID,
            feedPageId: FEED_PAGE_ID,
            feedMenuComponentIdentifier: FEED_MENU_COMPONENT_IDENTIFIER,
            headerComponentIdentifier: FEED_HEADER_COMPONENT_IDENTIFIER,
          );
        });
        tasks.add(() async {
          print("Membership Dashboard");
          await MembershipDashboardPageBuilder(APP_MEMBERS_PAGE_ID, app, memberId,
              homeMenuProvider(), appBarProvider(), leftDrawerProvider(), rightDrawerProvider())
              .run(
            componentIdentifier: MEMBERSHIP_COMPONENT_IDENTIFIER,
            profilePageId: PROFILE_PAGE_ID,
            feedPageId: FEED_PAGE_ID,
            feedMenuComponentIdentifier: FEED_MENU_COMPONENT_IDENTIFIER,
            headerComponentIdentifier: FEED_HEADER_COMPONENT_IDENTIFIER,
          );
        });
        tasks.add(() async {
          print("Profile Page");
          await ProfilePageBuilder(PROFILE_PAGE_ID, app, memberId, homeMenuProvider(), appBarProvider(), leftDrawerProvider(), rightDrawerProvider())
              .run(
            feed: feedModel,
            member: member,
            feedMenuComponentIdentifier: FEED_MENU_COMPONENT_IDENTIFIER,
            headerComponentIdentifier: FEED_HEADER_COMPONENT_IDENTIFIER,
            profileComponentIdentifier: PROFILE_COMPONENT_IDENTIFIER,
          );
        });
        return tasks;
      }
    } else {
      throw Exception('Unexpected class for parameters: ' + parameters.toString());
    }
  }

  @override
  AppModel updateApp(NewAppWizardParameters parameters, AppModel adjustMe, ) => adjustMe;

  @override
  String? getPageID(String pageType) {
    if (pageType == 'profilePageId') return PROFILE_PAGE_ID;
    else if (pageType == 'pageIdProvider') return FEED_PAGE_ID;
    return null;
  }
}

class FeedParameters extends NewAppWizardParameters {
  late  ActionSpecification feedPageSpecifications;

  FeedParameters() {
    feedPageSpecifications = ActionSpecification(
      requiresAccessToLocalFileSystem: false,
      availableInLeftDrawer: true,
      availableInRightDrawer: false,
      availableInAppBar: false,
      availableInHomeMenu: true,
      available: false,
    );
  }
}