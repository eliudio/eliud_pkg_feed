import 'package:eliud_core/core/wizards/builders/page_builder.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/core/wizards/tools/documentIdentifier.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/header_component.dart';
import 'package:eliud_pkg_feed/model/profile_component.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

class ProfilePageBuilder extends PageBuilder {
  ProfilePageBuilder(
      String uniqueId,
      String pageId,
      AppModel app,
      String memberId,
      HomeMenuModel theHomeMenu,
      AppBarModel theAppBar,
      DrawerModel leftDrawer,
      DrawerModel rightDrawer,
      PageProvider pageProvider,
      ActionProvider actionProvider)
      : super(uniqueId, pageId, app, memberId, theHomeMenu, theAppBar,
            leftDrawer, rightDrawer, pageProvider, actionProvider);

  Future<PageModel> _setupPage({
    required String profileComponentIdentifier,
    required String feedMenuComponentIdentifier,
    required String headerComponentIdentifier,
  }) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(app.documentID!)!
        .add(_page(
          profileComponentIdentifier: profileComponentIdentifier,
          feedMenuComponentIdentifier: feedMenuComponentIdentifier,
          headerComponentIdentifier: headerComponentIdentifier,
        ));
  }

  PageModel _page(
      {required String profileComponentIdentifier,
      required String feedMenuComponentIdentifier,
      required String headerComponentIdentifier}) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractFeedMenuComponent.componentName,
        componentId: constructDocumentId(uniqueId: uniqueId, documentId: feedMenuComponentIdentifier)));
    components.add(BodyComponentModel(
        documentID: "2",
        componentName: AbstractHeaderComponent.componentName,
        componentId: constructDocumentId(uniqueId: uniqueId, documentId: headerComponentIdentifier)));
    components.add(BodyComponentModel(
        documentID: "3",
        componentName: AbstractProfileComponent.componentName,
        componentId: constructDocumentId(uniqueId: uniqueId, documentId: profileComponentIdentifier)));

    return PageModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageId),
        appId: app.documentID!,
        title: "Profile",
        drawer: leftDrawer,
        endDrawer: rightDrawer,
        appBar: theAppBar,
        homeMenu: theHomeMenu,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.Level1PrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  ProfileModel profileModel(
      {required FeedModel feed, required String profileComponentIdentifier}) {
    return ProfileModel(
      documentID: constructDocumentId(uniqueId: uniqueId, documentId: profileComponentIdentifier),
      feed: feed,
      appId: app.documentID!,
      description: "My Profile",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<ProfileModel> _setupProfile(
      {required FeedModel feed,
      required String profileComponentIdentifier}) async {
    return await AbstractRepositorySingleton.singleton
        .profileRepository(app.documentID!)!
        .add(profileModel(
            feed: feed,
            profileComponentIdentifier: profileComponentIdentifier));
  }

  Future<PageModel> run(
      {required MemberModel member,
      required FeedModel feed,
      required String profileComponentIdentifier,
      required String feedMenuComponentIdentifier,
      required String headerComponentIdentifier}) async {
    await _setupProfile(
        feed: feed, profileComponentIdentifier: profileComponentIdentifier);
    return await _setupPage(
        profileComponentIdentifier: profileComponentIdentifier,
        feedMenuComponentIdentifier: feedMenuComponentIdentifier,
        headerComponentIdentifier: headerComponentIdentifier);
  }
}
