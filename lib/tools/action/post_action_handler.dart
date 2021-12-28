import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/logged_in.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/core/navigate/router.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';

/*
 * Post the current page to the feed of the current user, for the user or for the user and his followers
 */
class PostActionHandler extends PackageActionHandler {
  @override
  Future<void> navigateTo(BuildContext context, ActionModel action,
      {Map<String, dynamic>? parameters}) async {
    if (action is PostActionModel) {
      var accessState = AccessBloc.getState(context);
      if (accessState is LoggedIn) {
        String name = action.app.documentID!;

        openSelectionDialog(action.app, context, action.app.documentID! + "/_addpagetofeed",
            title: 'Add page to feed ' + name,
            options: ['Only Me', 'My followers', 'Public'],
            onSelection: (int choice) {
              switch (choice) {
                case 0: addToMe(context, action, accessState); break;
                case 1: addToFollowers(context, action.app, action, accessState); break;
                case 2: addToPublic(context, action.app, action, accessState); break;
              }
            });
      }
    }
  }

  void addToMe(
      BuildContext context, PostActionModel action, LoggedIn accessState) {
    executePostIt(context, action,
        PostFollowersHelper.asMe(accessState.member.documentID!), accessState);
  }

  Future<void> addToFollowers(BuildContext context, AppModel app, PostActionModel action,
      LoggedIn accessState) async {
    executePostIt(context, action,
        await PostFollowersHelper.asFollowers(context, app, accessState), accessState);
  }

  Future<void> addToPublic(BuildContext context, AppModel app, PostActionModel action,
      LoggedIn accessState) async {
    executePostIt(context, action,
        await PostFollowersHelper.asPublic(context, app, accessState), accessState);
  }

  Future<void> executePostIt(BuildContext context, PostActionModel action,
      List<String> readAccess, LoggedIn accessState) async {
    var pageContextInfo = eliudrouter.Router.getPageContextInfo(context);
    var postAppId = pageContextInfo.appId;
    var postPageId = pageContextInfo.pageId;
    var parameters = pageContextInfo.parameters;
    // What is the current page?
    // Can we actually add the current page? (page should have an indicator if it's allowed to be added)

    postRepository(appId: action.app.documentID!)!.add(PostModel(
      documentID: newRandomKey(),
      authorId: accessState.member.documentID,
      appId: action.app.documentID,
      postAppId: postAppId,
      feedId: action.feed!.documentID,
      postPageId: postPageId,
      archived: PostArchiveStatus.Active,
      pageParameters: parameters,
      description: "Post added by Add To Post button",
      readAccess: readAccess,
    ));
  }
}
