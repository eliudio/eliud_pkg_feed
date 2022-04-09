import 'package:eliud_core/core/wizards/builders/single_component_page_builder.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/core/wizards/tools/documentIdentifier.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_front_component.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'feed_menu_page_builder.dart';

class FeedFrontPageBuilder extends SingleComponentPageBuilder {
  FeedFrontPageBuilder(
      String uniqueId,
      String pageId,
      AppModel app,
      String memberId,
      HomeMenuModel theHomeMenu,
      AppBarModel theAppBar,
      DrawerModel leftDrawer,
      DrawerModel rightDrawer,
      PageProvider pageProvider,
      )
      : super(uniqueId, pageId, app, memberId, theHomeMenu, theAppBar,
            leftDrawer, rightDrawer, pageProvider, );

  static FeedFrontModel _dashboardModel(AppModel app, FeedModel feed, String uniqueId, String componentIdentifier) {
    return FeedFrontModel(
      documentID: constructDocumentId(uniqueId: uniqueId, documentId: componentIdentifier),
      appId: app.documentID!,
      feed: feed,
      description: "Feed",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
          PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  static Future<FeedFrontModel> setupDashboard(AppModel app, FeedModel feed, String uniqueId, String componentIdentifier) async {
    return await feedFrontRepository(appId: app.documentID!)!
        .add(_dashboardModel(app, feed, uniqueId, componentIdentifier));
  }

  Future<PageModel> run(
      {FeedModel? feed, String? feedIdentifier, required String componentIdentifier,
      }) async {
    if (feedIdentifier == null) {
      throw Exception('If feed is null, feedIdentifier needs to be supplied');
    }
    var newFeed = await FeedMenuPageBuilder.assertFeedModel(feed, feedIdentifier, app.documentID!, uniqueId);
    await setupDashboard(app, newFeed, uniqueId, componentIdentifier);
    return await doIt(
        componentName: AbstractFeedFrontComponent.componentName,
        componentIdentifier: componentIdentifier,
        title: "Find Friends");
  }
}
