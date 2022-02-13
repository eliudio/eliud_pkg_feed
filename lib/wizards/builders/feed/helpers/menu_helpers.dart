import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/display_conditions_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_follow/follow_package.dart';
import 'package:eliud_pkg_membership/membership_package.dart';
import 'package:eliud_pkg_workflow/model/workflow_model.dart';
import 'package:eliud_pkg_workflow/tools/action/workflow_action_model.dart';
import 'package:flutter/material.dart';

menuItemFollowRequests(AppModel app, dialogID) => MenuItemModel(
    documentID: dialogID,
    text: 'Follow requests',
    description: 'Follow requests',
    icon: IconModel(
        codePoint: Icons.favorite_border.codePoint,
        fontFamily: Icons.notifications.fontFamily),
    action: OpenDialog(
      app,
      dialogID: dialogID,
    ));

menuItemFollowRequestsPage(AppModel app, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: pageID,
        text: 'Follow Requests',
        description: 'Follow Requests',
        icon: IconModel(
            codePoint: Icons.person.codePoint,
            fontFamily: Icons.notifications.fontFamily),
        action: GotoPage(app, pageID: pageID, conditions: DisplayConditionsModel(
            privilegeLevelRequired: privilegeLevelRequired,
            packageCondition: FollowPackage.CONDITION_MEMBER_HAS_OPEN_REQUESTS)));

menuItemFollowers(AppModel app, dialogID, privilegeLevelRequired) => MenuItemModel(
    documentID: dialogID,
    text: 'Followers',
    description: 'Followers',
    icon: IconModel(
        codePoint: Icons.favorite_sharp.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: OpenDialog(app,
        dialogID: dialogID,
        conditions: DisplayConditionsModel(
            privilegeLevelRequired: privilegeLevelRequired,
            packageCondition: CorePackage.MUST_BE_LOGGED_ON)));

menuItemFollowersPage(AppModel app, pageID, privilegeLevelRequired) => MenuItemModel(
    documentID: pageID,
    text: 'Followers',
    description: 'Followers',
    icon: IconModel(
        codePoint: Icons.favorite_sharp.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(app,
        pageID: pageID,
        conditions: DisplayConditionsModel(
            privilegeLevelRequired: privilegeLevelRequired,
            packageCondition: CorePackage.MUST_BE_LOGGED_ON)));

menuItemFollowing(AppModel app, dialogID, privilegeLevelRequired) => MenuItemModel(
    documentID: dialogID,
    text: 'Following',
    description: 'Following',
    icon: IconModel(
        codePoint: Icons.favorite_sharp.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: OpenDialog(app,
        dialogID: dialogID,
        conditions: DisplayConditionsModel(
            privilegeLevelRequired: privilegeLevelRequired,
            packageCondition: CorePackage.MUST_BE_LOGGED_ON)));

menuItemFollowingPage(AppModel app, pageID, privilegeLevelRequired) => MenuItemModel(
    documentID: pageID,
    text: 'Following',
    description: 'Following',
    icon: IconModel(
        codePoint: Icons.favorite_sharp.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(app,
        pageID: pageID,
        conditions: DisplayConditionsModel(
            privilegeLevelRequired: privilegeLevelRequired,
            packageCondition: CorePackage.MUST_BE_LOGGED_ON)));

menuItemFiendFriendsPage(AppModel app, pageID, privilegeLevelRequired) =>
    MenuItemModel(
        documentID: pageID,
        text: 'Find friends',
        description: 'Fiend friends',
        icon: IconModel(
            codePoint: Icons.favorite_sharp.codePoint,
            fontFamily: Icons.settings.fontFamily),
        action: GotoPage(app,
            pageID: pageID,
            conditions: DisplayConditionsModel(
                privilegeLevelRequired: privilegeLevelRequired,
                packageCondition: CorePackage.MUST_BE_LOGGED_ON)));

menuItemAppMembersPage(AppModel app, pageID, privilegeLevelRequired) => MenuItemModel(
    documentID: pageID,
    text: 'App Members',
    description: 'Members of the app',
    icon: IconModel(
        codePoint: Icons.people.codePoint,
        fontFamily: Icons.notifications.fontFamily),
    action: GotoPage(
      app,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: privilegeLevelRequired,
          packageCondition: CorePackage.MUST_BE_LOGGED_ON),
      pageID: pageID,
    ));

menuItemFeed(AppModel app, pageID, text) => MenuItemModel(
    documentID: pageID,
    text: text,
    description: text,
    icon: IconModel(
        codePoint: Icons.group.codePoint,
        fontFamily: Icons.settings.fontFamily),
    action: GotoPage(app, pageID: pageID));

