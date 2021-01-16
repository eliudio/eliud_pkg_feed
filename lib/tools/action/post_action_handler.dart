import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/router.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/widgets/post.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_model.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostActionHandler extends PackageActionHandler {
  @override
  Future<void> navigateTo(BuildContext context, ActionModel action, {Map<String, Object> parameters}) async {
    if (action is PostActionModel) {
      executePostIt(context, action);
    }
  }

  void executePostIt(BuildContext context, PostActionModel action) {
    var accessState = AccessBloc.getState(context);
    if (accessState is LoggedIn) {
      // What is the current page?
      // Can we actually add the current page? (page should have an indicator if it's allowed to be added)
      postRepository(appId: action.appID).add(PostModel(
        documentID: newRandomKey(),
        author: accessState.member,
        appId: action.appID,
        postAppId: action.feed.appId,
        postPageId: null,
        pageParameters: null,
        description: "",
        readAccess: null,
      ));
    }
  }
}


