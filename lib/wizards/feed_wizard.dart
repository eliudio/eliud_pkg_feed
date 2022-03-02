import 'package:eliud_core/core/wizards/registry/new_app_wizard_info_with_action_specification.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'builders/feed/feed_page_builder.dart';
import 'builders/feed/follow_requests_dashboard_page_builder.dart';
import 'builders/feed/followers_dashboard_page_builder.dart';
import 'builders/feed/following_dashboard_page_builder.dart';
import 'builders/feed/helpers/menu_helpers.dart';
import 'builders/feed/invite_dashboard_page_builder.dart';
import 'builders/feed/membership_dashboard_page_builder.dart';
import 'builders/feed/profile_page_builder.dart';

class FeedWizard extends NewAppWizardInfoWithActionSpecification {
  static String feedPageId = 'feed';
  static String feedMenuComponentIdentifier = 'feed_menu';
  static String feedHeaderComponentIdentifier = 'feed_header';
  static String feedProfileComponentIdentifier = 'feed_profile';
  static String profilePageId = 'profile';
  static String followRequestPageId = 'follow_request';
  static String followersPageId = 'followers';
  static String followingPageId = 'following';
  static String findFriendPageId = 'fiend_friends';
  static String appMembersPageId = 'app_members';
  static String followRequestComponentId = 'follow_request';
  static String followersComponentId = 'followers';
  static String followingComponentId = 'following';
  static String inviteComponentId = 'invite';
  static String membershipComponentId = 'membership';
  static String profileComponentId = 'profile';

  FeedWizard() : super('feed', 'Feed', 'Generate a default Feed');

  @override
  NewAppWizardParameters newAppWizardParameters() =>
      ActionSpecificationParametersBase(
        requiresAccessToLocalFileSystem: false,
        availableInLeftDrawer: true,
        availableInRightDrawer: false,
        availableInAppBar: false,
        availableInHomeMenu: true,
        available: false,
      );

  @override
  List<MenuItemModel>? getThoseMenuItems(String uniqueId, AppModel app) =>
      [menuItemFeed(uniqueId, app, feedPageId, 'Feed')];

  List<NewAppTask>? getCreateTasks(
    String uniqueId,
    AppModel app,
    NewAppWizardParameters parameters,
    MemberModel member,
    HomeMenuProvider homeMenuProvider,
    AppBarProvider appBarProvider,
    DrawerProvider leftDrawerProvider,
    DrawerProvider rightDrawerProvider,
    PageProvider pageProvider,
    ActionProvider actionProvider,
  ) {
    if (parameters is ActionSpecificationParametersBase) {
      var feedSpecifications = parameters.actionSpecifications;
      if (feedSpecifications.shouldCreatePageDialogOrWorkflow()) {
        List<NewAppTask> tasks = [];
        var memberId = member.documentID!;
        var feedModel;
        tasks.add(() async {
          print("feedModel");
          feedModel = await FeedPageBuilder(
                  uniqueId,
                  feedPageId,
                  app,
                  memberId,
                  homeMenuProvider(),
                  appBarProvider(),
                  leftDrawerProvider(),
                  rightDrawerProvider(),
                  pageProvider,
                  actionProvider)
              .run(
                  feedMenuComponentIdentifier:
                      feedMenuComponentIdentifier,
                  headerComponentIdentifier:
                      feedHeaderComponentIdentifier,
                  profileComponentIdentifier:
                      feedProfileComponentIdentifier,
                  feedPageId: feedPageId,
                  profilePageId: profilePageId,
                  followRequestPageId: followRequestPageId,
                  followersPageId: followersPageId,
                  followingPageId: followingPageId,
                  fiendFriendsPageId: findFriendPageId,
                  appMembersPageId: appMembersPageId);
        });

        tasks.add(() async {
          print("Follow Request");
          await FollowRequestsDashboardPageBuilder(
                  uniqueId,
                  followRequestPageId,
                  app,
                  memberId,
                  homeMenuProvider(),
                  appBarProvider(),
                  leftDrawerProvider(),
                  rightDrawerProvider(),
                  pageProvider,
                  actionProvider)
              .run(
            componentIdentifier: followRequestComponentId,
            profilePageId: profilePageId,
            feedPageId: feedPageId,
            feedMenuComponentIdentifier:
                feedMenuComponentIdentifier,
            headerComponentIdentifier:
                feedHeaderComponentIdentifier,
          );
        });
        tasks.add(() async {
          print("Followers Dashboard");
          await FollowersDashboardPageBuilder(
                  uniqueId,
                  followersPageId,
                  app,
                  memberId,
                  homeMenuProvider(),
                  appBarProvider(),
                  leftDrawerProvider(),
                  rightDrawerProvider(),
                  pageProvider,
                  actionProvider)
              .run(
            componentIdentifier: followersComponentId,
            profilePageId: profilePageId,
            feedPageId: feedPageId,
            feedMenuComponentIdentifier:
                feedMenuComponentIdentifier,
            headerComponentIdentifier:
                feedHeaderComponentIdentifier,
          );
        });
        tasks.add(() async {
          print("Following Dashboard");
          await FollowingDashboardPageBuilder(
                  uniqueId,
                  followingPageId,
                  app,
                  memberId,
                  homeMenuProvider(),
                  appBarProvider(),
                  leftDrawerProvider(),
                  rightDrawerProvider(),
                  pageProvider,
                  actionProvider)
              .run(
            componentIdentifier: followingComponentId,
            profilePageId: profilePageId,
            feedPageId: feedPageId,
            feedMenuComponentIdentifier:
                feedMenuComponentIdentifier,
            headerComponentIdentifier:
                feedHeaderComponentIdentifier,
          );
        });
        tasks.add(() async {
          print("Invite Dashboard");
          await InviteDashboardPageBuilder(
                  uniqueId,
                  findFriendPageId,
                  app,
                  memberId,
                  homeMenuProvider(),
                  appBarProvider(),
                  leftDrawerProvider(),
                  rightDrawerProvider(),
                  pageProvider,
                  actionProvider)
              .run(
            componentIdentifier: inviteComponentId,
            profilePageId: profilePageId,
            feedPageId: feedPageId,
            feedMenuComponentIdentifier:
                feedMenuComponentIdentifier,
            headerComponentIdentifier:
                feedHeaderComponentIdentifier,
          );
        });
        tasks.add(() async {
          print("Membership Dashboard");
          await MembershipDashboardPageBuilder(
                  uniqueId,
                  appMembersPageId,
                  app,
                  memberId,
                  homeMenuProvider(),
                  appBarProvider(),
                  leftDrawerProvider(),
                  rightDrawerProvider(),
                  pageProvider,
                  actionProvider)
              .run(
            componentIdentifier: membershipComponentId,
            profilePageId: profilePageId,
            feedPageId: feedPageId,
            feedMenuComponentIdentifier:
                feedMenuComponentIdentifier,
            headerComponentIdentifier:
                feedHeaderComponentIdentifier,
          );
        });
        tasks.add(() async {
          print("Profile Page");
          await ProfilePageBuilder(
                  uniqueId,
                  profilePageId,
                  app,
                  memberId,
                  homeMenuProvider(),
                  appBarProvider(),
                  leftDrawerProvider(),
                  rightDrawerProvider(),
                  pageProvider,
                  actionProvider)
              .run(
            feed: feedModel,
            member: member,
            feedMenuComponentIdentifier:
                feedMenuComponentIdentifier,
            headerComponentIdentifier:
                feedHeaderComponentIdentifier,
            profileComponentIdentifier: profileComponentId,
          );
        });
        return tasks;
      }
    } else {
      throw Exception(
          'Unexpected class for parameters: ' + parameters.toString());
    }
  }

  @override
  AppModel updateApp(
    String uniqueId,
    NewAppWizardParameters parameters,
    AppModel adjustMe,
  ) =>
      adjustMe;

  @override
  String? getPageID(
      String uniqueId, NewAppWizardParameters parameters, String pageType) {
    if (pageType == 'profilePageId')
      return profilePageId;
    else if (pageType == 'pageIdProvider') return feedPageId;
    return null;
  }

  @override
  ActionModel? getAction(
    String uniqueId,
    NewAppWizardParameters parameters,
    AppModel app,
    String actionType,
  ) =>
      null;

  @override
  PublicMediumModel? getPublicMediumModel(String uniqueId, NewAppWizardParameters parameters, String pageType) => null;
}
