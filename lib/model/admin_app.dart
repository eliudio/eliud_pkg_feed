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
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

class AdminApp extends AdminAppInstallerBase {
  final String appId;
  final DrawerModel _drawer;
  final DrawerModel _endDrawer;
  final AppBarModel _appBar;
  final HomeMenuModel _homeMenu;
  final RgbModel menuItemColor;
  final RgbModel selectedMenuItemColor;
  final RgbModel backgroundColor;
  
  AdminApp(this.appId, this._drawer, this._endDrawer, this._appBar, this._homeMenu, this.menuItemColor, this.selectedMenuItemColor, this.backgroundColor);


  PageModel _feedsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-feeds", componentName: "eliud_pkg_feed_internalWidgets", componentId: "feeds"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_feeds_page",
        title: "Feeds",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.OnlyTheFirstComponent
    );
    return page;
  }


  PageModel _feedFrontsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-feedFronts", componentName: "eliud_pkg_feed_internalWidgets", componentId: "feedFronts"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_feedfronts_page",
        title: "FeedFronts",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.OnlyTheFirstComponent
    );
    return page;
  }


  PageModel _feedMenusPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-feedMenus", componentName: "eliud_pkg_feed_internalWidgets", componentId: "feedMenus"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_feedmenus_page",
        title: "FeedMenus",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.OnlyTheFirstComponent
    );
    return page;
  }


  PageModel _postsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-posts", componentName: "eliud_pkg_feed_internalWidgets", componentId: "posts"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_posts_page",
        title: "Posts",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.OnlyTheFirstComponent
    );
    return page;
  }


  PageModel _postCommentsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-postComments", componentName: "eliud_pkg_feed_internalWidgets", componentId: "postComments"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_postcomments_page",
        title: "PostComments",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.OnlyTheFirstComponent
    );
    return page;
  }


  PageModel _postLikesPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-postLikes", componentName: "eliud_pkg_feed_internalWidgets", componentId: "postLikes"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_postlikes_page",
        title: "PostLikes",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.OnlyTheFirstComponent
    );
    return page;
  }


  PageModel _profilesPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-profiles", componentName: "eliud_pkg_feed_internalWidgets", componentId: "profiles"));
    PageModel page = PageModel(
        conditions: StorageConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple,
        ),
        appId: appId,
        documentID: "eliud_pkg_feed_profiles_page",
        title: "Profiles",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.OnlyTheFirstComponent
    );
    return page;
  }


  Future<void> _setupAdminPages() {

    return pageRepository(appId: appId)!.add(_feedsPages())

        .then((_) => pageRepository(appId: appId)!.add(_feedFrontsPages()))

        .then((_) => pageRepository(appId: appId)!.add(_feedMenusPages()))

        .then((_) => pageRepository(appId: appId)!.add(_postsPages()))

        .then((_) => pageRepository(appId: appId)!.add(_postCommentsPages()))

        .then((_) => pageRepository(appId: appId)!.add(_postLikesPages()))

        .then((_) => pageRepository(appId: appId)!.add(_profilesPages()))

    ;
  }

  @override
  Future<void> run() async {
    return _setupAdminPages();
  }


}

class AdminMenu extends AdminAppMenuInstallerBase {

  Future<MenuDefModel> menu(AppModel app) async {
    var menuItems = <MenuItemModel>[];

    menuItems.add(
      MenuItemModel(
        documentID: "Feeds",
        text: "Feeds",
        description: "Feeds",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_feeds_page"))
    );


    menuItems.add(
      MenuItemModel(
        documentID: "FeedFronts",
        text: "FeedFronts",
        description: "FeedFronts",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_feedfronts_page"))
    );


    menuItems.add(
      MenuItemModel(
        documentID: "FeedMenus",
        text: "FeedMenus",
        description: "FeedMenus",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_feedmenus_page"))
    );


    menuItems.add(
      MenuItemModel(
        documentID: "Posts",
        text: "Posts",
        description: "Posts",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_posts_page"))
    );


    menuItems.add(
      MenuItemModel(
        documentID: "PostComments",
        text: "PostComments",
        description: "PostComments",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_postcomments_page"))
    );


    menuItems.add(
      MenuItemModel(
        documentID: "PostLikes",
        text: "PostLikes",
        description: "PostLikes",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_postlikes_page"))
    );


    menuItems.add(
      MenuItemModel(
        documentID: "Profiles",
        text: "Profiles",
        description: "Profiles",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(app, pageID: "eliud_pkg_feed_profiles_page"))
    );


    MenuDefModel menu = MenuDefModel(
      admin: true,
      documentID: "eliud_pkg_feed_admin_menu",
      appId: app.documentID,
      name: "eliud_pkg_feed",
      menuItems: menuItems
    );
    await menuDefRepository(appId: app.documentID!)!.add(menu);
    return menu;
  }
}

class AdminAppWiper extends AdminAppWiperBase {

  @override
  Future<void> deleteAll(String appId) async {
    ;
  }


}

