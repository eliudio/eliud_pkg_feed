import 'package:eliud_core/core/wizards/builders/page_builder.dart';
import 'package:eliud_core/core/wizards/tools/document_identifier.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/profile_component.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

class ProfilePageBuilder extends PageBuilder {
  ProfilePageBuilder(
    super.uniqueId,
    super.pageId,
    super.app,
    super.memberId,
    super.theHomeMenu,
    super.theAppBar,
    super.leftDrawer,
    super.rightDrawer,
  );

  Future<PageModel> _setupPage({
    required String profileComponentIdentifier,
  }) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(app.documentID)!
        .add(_page(
          profileComponentIdentifier: profileComponentIdentifier,
        ));
  }

  PageModel _page({
    required String profileComponentIdentifier,
  }) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "3",
        componentName: AbstractProfileComponent.componentName,
        componentId: constructDocumentId(
            uniqueId: uniqueId, documentId: profileComponentIdentifier)));

    return PageModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageId),
        appId: app.documentID,
        title: "Profile",
        description: "Profile",
        drawer: leftDrawer,
        endDrawer: rightDrawer,
        appBar: theAppBar,
        homeMenu: theHomeMenu,
        layout: PageLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.level1PrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  static ProfileModel profileModel(
    AppModel app,
    String uniqueId,
    String componentIdentifier,
    FeedModel feed,
  ) {
    return ProfileModel(
      documentID: constructDocumentId(
          uniqueId: uniqueId, documentId: componentIdentifier),
      feed: feed,
      appId: app.documentID,
      description: "My Profile",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  static Future<ProfileModel> setupDashboard(
    AppModel app,
    String uniqueId,
    String componentIdentifier,
    FeedModel feed,
  ) async {
    return await AbstractRepositorySingleton.singleton
        .profileRepository(app.documentID)!
        .add(profileModel(
          app,
          uniqueId,
          componentIdentifier,
          feed,
        ));
  }

  Future<PageModel> run({
    required MemberModel member,
    required FeedModel feed,
    required String componentIdentifier,
  }) async {
    await setupDashboard(
      app,
      uniqueId,
      componentIdentifier,
      feed,
    );
    return await _setupPage(
      profileComponentIdentifier: componentIdentifier,
    );
  }
}
