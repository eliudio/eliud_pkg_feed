import 'package:eliud_core/core/wizards/builders/single_component_page_builder.dart';
import 'package:eliud_core/core/wizards/tools/document_identifier.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_front_component.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'feed_menu_page_builder.dart';

class FeedFrontPageBuilder extends SingleComponentPageBuilder {
  FeedFrontPageBuilder(
    super.uniqueId,
    super.pageId,
    super.app,
    super.memberId,
    super.theHomeMenu,
    super.theAppBar,
    super.leftDrawer,
    super.rightDrawer,
  );

  static FeedFrontModel _dashboardModel(AppModel app, FeedModel feed,
      String uniqueId, String componentIdentifier) {
    return FeedFrontModel(
      documentID: constructDocumentId(
          uniqueId: uniqueId, documentId: componentIdentifier),
      appId: app.documentID,
      feed: feed,
      description: "Feed",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  static Future<FeedFrontModel> setupDashboard(AppModel app, FeedModel feed,
      String uniqueId, String componentIdentifier) async {
    return await feedFrontRepository(appId: app.documentID)!
        .add(_dashboardModel(app, feed, uniqueId, componentIdentifier));
  }

  Future<PageModel> run({
    FeedModel? feed,
    String? feedIdentifier,
    required String componentIdentifier,
  }) async {
    if (feedIdentifier == null) {
      throw Exception('If feed is null, feedIdentifier needs to be supplied');
    }
    var newFeed = await FeedMenuPageBuilder.assertFeedModel(
        feed, feedIdentifier, app.documentID, uniqueId);
    await setupDashboard(app, newFeed, uniqueId, componentIdentifier);
    return await doIt(
        componentName: AbstractFeedFrontComponent.componentName,
        componentIdentifier: componentIdentifier,
        title: "Find Friends",
        description: "Find Friends");
  }
}
