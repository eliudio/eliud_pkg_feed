import 'package:eliud_core/core/wizards/tools/documentIdentifier.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as coreRepo;
import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/wizards/builders/feed/helpers/menu_helpers.dart';
import 'package:flutter/material.dart';

class FeedMenu {
  final String uniqueId;
  final AppModel app;
  final String feedPageId;
  final String profilePageId;
  final String followRequestPageId;
  final String followersPageId;
  final String followingPageId;
  final String fiendFriendsPageId;
  final String appMembersPageId;

  FeedMenu(this.uniqueId, this.app,
      {required this.feedPageId,
      required this.profilePageId,
      required this.followRequestPageId,
      required this.followersPageId,
      required this.followingPageId,
      required this.fiendFriendsPageId,
      required this.appMembersPageId});

  static String FEED_MENU_ID_CURRENT_MEMBER = "feedMenuCurrentMember";
  static String FEED_MENU_ID_OTHER_MEMBER = "feedMenuOtherMember";

  MenuItemModel feedMenuItem() => MenuItemModel(
      documentID: '1',
      text: 'Feed',
      description: 'Your Feed',
      icon: IconModel(
          codePoint: Icons.people.codePoint,
          fontFamily: Icons.settings.fontFamily),
      action: GotoPage(app, pageID: constructDocumentId(uniqueId: uniqueId, documentId: feedPageId)));

  MenuItemModel profileMenuItem() => MenuItemModel(
      documentID: '2',
      text: 'Profile',
      description: 'Your profile',
      icon: IconModel(
          codePoint: Icons.person.codePoint,
          fontFamily: Icons.settings.fontFamily),
      action: GotoPage(app, pageID: constructDocumentId(uniqueId: uniqueId, documentId: profilePageId)));

  MenuDefModel menuDefCurrentMember() {
    var menuItems = <MenuItemModel>[
      feedMenuItem(),
      profileMenuItem(),
      menuItemFollowRequestsPage(uniqueId, app, followRequestPageId,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFollowersPage(uniqueId, app, followersPageId,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFollowingPage(uniqueId, app, followingPageId,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemFiendFriendsPage(uniqueId, app, fiendFriendsPageId,
          PrivilegeLevelRequired.NoPrivilegeRequired),
      menuItemAppMembersPage(uniqueId, app, appMembersPageId,
          PrivilegeLevelRequired.OwnerPrivilegeRequired),
    ];
    MenuDefModel menu = MenuDefModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: FEED_MENU_ID_CURRENT_MEMBER),
        appId: app.documentID!,
        name: "Current Member Feed Menu",
        menuItems: menuItems);
    return menu;
  }

  MenuDefModel menuDefOtherMember() {
    var menuItems = <MenuItemModel>[
      feedMenuItem(),
      profileMenuItem(),
    ];
    MenuDefModel menu = MenuDefModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: FEED_MENU_ID_OTHER_MEMBER),
        appId: app.documentID!,
        name: "Other Member Feed Menu",
        menuItems: menuItems);
    return menu;
  }

  Future<MenuDefModel> createMenuDefCurrentMember() async {
    return await coreRepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(app.documentID!)!
        .add(menuDefCurrentMember());
  }

  Future<MenuDefModel> createMenuDefOtherMember() async {
    return await coreRepo.AbstractRepositorySingleton.singleton
        .menuDefRepository(app.documentID!)!
        .add(menuDefOtherMember());
  }

  FeedMenuModel feedMenuModel({
    required FeedModel feed,
    required String feedMenuComponentIdentifier,
    required MenuDefModel menuCurrentMember,
    required MenuDefModel menuOtherMember,
  }) {
    return FeedMenuModel(
      documentID: constructDocumentId(uniqueId: uniqueId, documentId: feedMenuComponentIdentifier),
      appId: app.documentID!,
      description: "Feed Menu",
      feed: feed,
      menuCurrentMember: menuCurrentMember,
      menuOtherMember: menuOtherMember,
      //itemColor: EliudColors.black,
      //selectedItemColor: EliudColors.red,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<FeedMenuModel> createFeedMenuModel({
    required FeedModel feed,
    required String feedMenuComponentIdentifier,
    required MenuDefModel menuCurrentMember,
    required MenuDefModel menuOtherMember,
  }) async {
    return await AbstractRepositorySingleton.singleton
        .feedMenuRepository(app.documentID!)!
        .add(feedMenuModel(
            feed: feed,
            feedMenuComponentIdentifier: feedMenuComponentIdentifier,
            menuCurrentMember: menuCurrentMember,
            menuOtherMember: menuOtherMember));
  }

  Future<void> run({
    required FeedModel feed,
    required String feedMenuComponentIdentifier,
  }) async {
    var menuDefCurrentMember = await createMenuDefCurrentMember();
    var menuDefOtherMember = await createMenuDefOtherMember();
    await createFeedMenuModel(
        feed: feed,
        feedMenuComponentIdentifier: feedMenuComponentIdentifier,
        menuCurrentMember: menuDefCurrentMember,
        menuOtherMember: menuDefOtherMember);
  }
}
