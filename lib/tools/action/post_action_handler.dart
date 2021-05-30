import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/core/navigate/router.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_core/tools/widgets/dialog_with_options.dart';
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
        String name = action.appID!;
        DialogStatefulWidgetHelper.openIt(
            context,
            DialogWithOptions(title: 'Add page to feed ' + name)
                .withOption(
                    'Only me', () => addToMe(context, action, accessState))
                .withOption('My followers',
                    () => addToFollowers(context, action, accessState))
                .withOptionConditional(accessState.memberIsOwner(), 'Public',
                    () => addToPublic(context, action, accessState)));
      }
    }
  }

  void addToMe(
      BuildContext context, PostActionModel action, LoggedIn accessState) {
    executePostIt(
        context, action, PostFollowersHelper.asMe(accessState.member.documentID!), accessState);
  }

  Future<void> addToFollowers(BuildContext context, PostActionModel action,
      LoggedIn accessState) async {
    executePostIt(context, action, await PostFollowersHelper.asFollowers(accessState), accessState);
  }

  Future<void> addToPublic(
      BuildContext context, PostActionModel action, LoggedIn accessState) async {
    executePostIt(context, action, await PostFollowersHelper.asPublic(accessState), accessState);
  }

  Future<void> executePostIt(BuildContext context, PostActionModel action,
      List<String> readAccess, LoggedIn accessState) async {
    var pageContextInfo = PageParamHelper.getPagaContextInfo(context);
    var postAppId = pageContextInfo.appId;
    var postPageId = pageContextInfo.pageId;
    var parameters = pageContextInfo.parameters;
    // What is the current page?
    // Can we actually add the current page? (page should have an indicator if it's allowed to be added)

    postRepository(appId: action.appID)!.add(PostModel(
      documentID: newRandomKey(),
      author: await memberPublicInfoRepository(appId: action.appID)!.get(
          accessState.member.documentID),
      appId: action.appID,
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
