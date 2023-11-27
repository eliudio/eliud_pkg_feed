import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/apis/action_api/actions/open_dialog.dart';
import 'package:eliud_core_main/wizards/tools/document_identifier.dart';
import 'package:eliud_core/core_package.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/display_conditions_model.dart';
import 'package:eliud_core_main/model/icon_model.dart';
import 'package:eliud_core_main/model/menu_item_model.dart';
import 'package:eliud_pkg_follow/follow_package.dart';
import 'package:flutter/material.dart';

MenuItemModel menuItemFollowRequests(String uniqueId, AppModel app, dialogID) =>
    MenuItemModel(
        documentID:
            constructDocumentId(uniqueId: uniqueId, documentId: dialogID),
        text: 'Follow requests',
        description: 'Follow requests',
        icon: IconModel(
            codePoint: Icons.favorite_border.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: OpenDialog(
          app,
          dialogID:
              constructDocumentId(uniqueId: uniqueId, documentId: dialogID),
        ));

MenuItemModel menuItemFollowRequestsPage(
        String uniqueId, AppModel app, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
        text: 'Follow Requests',
        description: 'Follow Requests',
        icon: IconModel(
            codePoint: Icons.person.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: GotoPage(app,
            pageID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition:
                    FollowPackage.conditionMemberHasOpenRequests)));

MenuItemModel menuItemFollowers(
        String uniqueId, AppModel app, dialogID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID:
            constructDocumentId(uniqueId: uniqueId, documentId: dialogID),
        text: 'Followers',
        description: 'Followers',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: OpenDialog(app,
            dialogID:
                constructDocumentId(uniqueId: uniqueId, documentId: dialogID),
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));

MenuItemModel menuItemFollowersPage(
        String uniqueId, AppModel app, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
        text: 'Followers',
        description: 'Followers',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(app,
            pageID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));

MenuItemModel menuItemFollowing(
        String uniqueId, AppModel app, dialogID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID:
            constructDocumentId(uniqueId: uniqueId, documentId: dialogID),
        text: 'Following',
        description: 'Following',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: OpenDialog(app,
            dialogID:
                constructDocumentId(uniqueId: uniqueId, documentId: dialogID),
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));

MenuItemModel menuItemFollowingPage(
        String uniqueId, AppModel app, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
        text: 'Following',
        description: 'Following',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(app,
            pageID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));

MenuItemModel menuItemFiendFriendsPage(
        String uniqueId, AppModel app, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
        text: 'Find friends',
        description: 'Fiend friends',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(app,
            pageID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.mustBeLoggedIn)));

MenuItemModel menuItemAppMembersPage(
        String uniqueId, AppModel app, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
        text: 'App Members',
        description: 'Members of the app',
        icon: IconModel(
            codePoint: Icons.people.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: GotoPage(
          app,
          conditions: DisplayConditionsModel(
              privilegeLevelRequired: privilegeLevelRequired,
              packageCondition: CorePackage.mustBeLoggedIn),
          pageID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
        ));

MenuItemModel menuItemFeed(String uniqueId, AppModel app, pageID, text) =>
    MenuItemModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: pageID),
        text: text,
        description: text,
        icon: IconModel(
            codePoint: Icons.group.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(app,
            pageID:
                constructDocumentId(uniqueId: uniqueId, documentId: pageID)));
