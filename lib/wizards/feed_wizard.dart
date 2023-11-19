import 'package:eliud_core/core/wizards/registry/new_app_wizard_info_with_action_specification.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'builders/feed/feed_menu_page_builder.dart';
import 'builders/feed/helpers/menu_helpers.dart';

class FeedWizard extends NewAppWizardInfoWithActionSpecification {
  static String feedPageId = 'feed';
  static String feedIdentifier = "feed";
  static String feedMenuComponentIdentifier = "feed_menu";
  static String feedFrontComponentIdentifier = 'feed_front';
  static String followRequestsDashboardComponentIdentifier = 'follow_requests';
  static String feedProfileComponentIdentifier = 'profile';
  static String followersDashboardComponentIdentifier = 'followers';
  static String followingDashboardComponentIdentifier = 'following';
  static String inviteDashboardComponentIdentifier = 'invite';

  FeedWizard() : super('feed', 'Feed', 'Generate a default Feed');

  @override
  String getPackageName() => "eliud_pkg_feed";

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

  @override
  List<NewAppTask>? getCreateTasks(
    String uniqueId,
    AppModel app,
    NewAppWizardParameters parameters,
    MemberModel member,
    HomeMenuProvider homeMenuProvider,
    AppBarProvider appBarProvider,
    DrawerProvider leftDrawerProvider,
    DrawerProvider rightDrawerProvider,
  ) {
    if (parameters is ActionSpecificationParametersBase) {
      var feedSpecifications = parameters.actionSpecifications;
      if (feedSpecifications.shouldCreatePageDialogOrWorkflow()) {
        List<NewAppTask> tasks = [];
        var memberId = member.documentID;
        tasks.add(() async {
          print("feedModel");
          await FeedMenuPageBuilder(
            uniqueId,
            feedPageId,
            app,
            memberId,
            homeMenuProvider(),
            appBarProvider(),
            leftDrawerProvider(),
            rightDrawerProvider(),
          ).run(
            feed: null,
            feedIdentifier: feedIdentifier,
            feedMenuComponentIdentifier: feedMenuComponentIdentifier,
            feedFrontComponentIdentifier: feedFrontComponentIdentifier,
            followRequestsDashboardComponentIdentifier:
                followRequestsDashboardComponentIdentifier,
            profileComponentIdentifier: feedProfileComponentIdentifier,
            followersDashboardComponentIdentifier:
                followersDashboardComponentIdentifier,
            followingDashboardComponentIdentifier:
                followingDashboardComponentIdentifier,
            inviteDashboardComponentIdentifier:
                inviteDashboardComponentIdentifier,
          );
        });

        return tasks;
      }
    } else {
      throw Exception('Unexpected class for parameters: $parameters');
    }
    return null;
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
/*
    if (pageType == 'profilePageId')
      return profilePageId;
    else if (pageType == 'pageIdProvider') return feedPageId;
*/
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
  PublicMediumModel? getPublicMediumModel(String uniqueId,
          NewAppWizardParameters parameters, String mediumType) =>
      null;
}
