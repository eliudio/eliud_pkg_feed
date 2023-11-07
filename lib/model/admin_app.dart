/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/admin_app.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/admin_app_base.dart';
import '../tools/bespoke_models.dart';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';

class AdminApp extends AdminAppInstallerBase {
  final String appId;
  final DrawerModel _drawer;
  final DrawerModel _endDrawer;
  final AppBarModel _appBar;
  final HomeMenuModel _homeMenu;
  final RgbModel menuItemColor;
  final RgbModel selectedMenuItemColor;
  final RgbModel backgroundColor;

  /// Construct the AdminApp
  AdminApp(
      this.appId,
      this._drawer,
      this._endDrawer,
      this._appBar,
      this._homeMenu,
      this.menuItemColor,
      this.selectedMenuItemColor,
      this.backgroundColor);

  /// Retrieve the admin pages
  PageModel _feedsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "internalWidget-feeds",
        componentName: "eliud_pkg_feed_internalWidgets",
        componentId: "feeds"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_feeds_page",
        title: "Feeds",
        description: "Feeds",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.onlyTheFirstComponent);
    return page;
  }

  /// Retrieve the admin pages
  PageModel _feedFrontsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "internalWidget-feedFronts",
        componentName: "eliud_pkg_feed_internalWidgets",
        componentId: "feedFronts"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_feedfronts_page",
        title: "FeedFronts",
        description: "FeedFronts",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.onlyTheFirstComponent);
    return page;
  }

  /// Retrieve the admin pages
  PageModel _feedMenusPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "internalWidget-feedMenus",
        componentName: "eliud_pkg_feed_internalWidgets",
        componentId: "feedMenus"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_feedmenus_page",
        title: "FeedMenus",
        description: "FeedMenus",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.onlyTheFirstComponent);
    return page;
  }

  /// Retrieve the admin pages
  PageModel _postsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "internalWidget-posts",
        componentName: "eliud_pkg_feed_internalWidgets",
        componentId: "posts"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_posts_page",
        title: "Posts",
        description: "Posts",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.onlyTheFirstComponent);
    return page;
  }

  /// Retrieve the admin pages
  PageModel _postCommentsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "internalWidget-postComments",
        componentName: "eliud_pkg_feed_internalWidgets",
        componentId: "postComments"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_postcomments_page",
        title: "PostComments",
        description: "PostComments",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.onlyTheFirstComponent);
    return page;
  }

  /// Retrieve the admin pages
  PageModel _postLikesPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "internalWidget-postLikes",
        componentName: "eliud_pkg_feed_internalWidgets",
        componentId: "postLikes"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_postlikes_page",
        title: "PostLikes",
        description: "PostLikes",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.onlyTheFirstComponent);
    return page;
  }

  /// Retrieve the admin pages
  PageModel _profilesPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "internalWidget-profiles",
        componentName: "eliud_pkg_feed_internalWidgets",
        componentId: "profiles"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_profiles_page",
        title: "Profiles",
        description: "Profiles",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.onlyTheFirstComponent);
    return page;
  }

  Future<void> _setupAdminPages() {
    return pageRepository(appId: appId)!
        .add(_feedsPages())
        .then((_) => pageRepository(appId: appId)!.add(_feedFrontsPages()))
        .then((_) => pageRepository(appId: appId)!.add(_feedMenusPages()))
        .then((_) => pageRepository(appId: appId)!.add(_postsPages()))
        .then((_) => pageRepository(appId: appId)!.add(_postCommentsPages()))
        .then((_) => pageRepository(appId: appId)!.add(_postLikesPages()))
        .then((_) => pageRepository(appId: appId)!.add(_profilesPages()));
  }

  /// Run the admin, i.e setup all admin pages
  @override
  Future<void> run() async {
    return _setupAdminPages();
  }
}

class AdminMenu extends AdminAppMenuInstallerBase {
  /// Construct the admin menu
  @override
  Future<MenuDefModel> menu(AppModel app) async {
    var menuItems = <MenuItemModel>[];

    menuItems.add(MenuItemModel(
        documentID: "Feeds",
        text: "Feeds",
        description: "Feeds",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_feeds_page")));

    menuItems.add(MenuItemModel(
        documentID: "FeedFronts",
        text: "FeedFronts",
        description: "FeedFronts",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_feedfronts_page")));

    menuItems.add(MenuItemModel(
        documentID: "FeedMenus",
        text: "FeedMenus",
        description: "FeedMenus",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_feedmenus_page")));

    menuItems.add(MenuItemModel(
        documentID: "Posts",
        text: "Posts",
        description: "Posts",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_posts_page")));

    menuItems.add(MenuItemModel(
        documentID: "PostComments",
        text: "PostComments",
        description: "PostComments",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_postcomments_page")));

    menuItems.add(MenuItemModel(
        documentID: "PostLikes",
        text: "PostLikes",
        description: "PostLikes",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_postlikes_page")));

    menuItems.add(MenuItemModel(
        documentID: "Profiles",
        text: "Profiles",
        description: "Profiles",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_profiles_page")));

    MenuDefModel menu = MenuDefModel(
        admin: true,
        documentID: "eliud_pkg_feed_admin_menu",
        appId: app.documentID,
        name: "eliud_pkg_feed",
        menuItems: menuItems);
    await menuDefRepository(appId: app.documentID)!.add(menu);
    return menu;
  }
}

class AdminAppWiper extends AdminAppWiperBase {
  /// Delete all admin pages
  @override
  Future<void> deleteAll(String appID) async {}
}
