import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/router.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_core/tools/widgets/dialog_with_options.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/tools/action/post_action_model.dart';
import 'package:eliud_pkg_follow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';

enum PostPrivilege {
  Public, Followers, JustMe,
}

PostPrivilege toPostPrivilege(int index) {
  switch (index) {
    case 0: return PostPrivilege.Public;
    case 1: return PostPrivilege.Followers;
    case 2: return PostPrivilege.JustMe;
  }
  return PostPrivilege.JustMe;
}

class PostFollowersHelper {
  static Future<List<String>> as(PostPrivilege who, String appId,
      LoggedIn accessState) async {
    switch (who) {
      case PostPrivilege.Public:
        return asPublic();
      case PostPrivilege.JustMe:
        return asMe(accessState.member.documentID!);
      case PostPrivilege.Followers:
        return asFollowers(appId, accessState);
    }
  }

  // List all followers in a list to provide them access to this post
  static Future<List<String>> asFollowers(String appId,
      LoggedIn accessState) async {
    List<String> followers = (await followingRepository(appId: appId)!
            .valuesListWithDetails(
                eliudQuery: EliudQuery(theConditions: [
      EliudQueryCondition('followedId',
          isEqualTo: accessState.member.documentID)
    ])))
        .map((following) =>
            following!.follower!.documentID!)
        .toList();
    followers.add(accessState.member.documentID!); // add myself
    return followers;
  }

  // To allow a post to be publicly available
  static List<String> asPublic() {
    return ['PUBLIC'];
  }

  static List<String> asMe(String memberId) {
    return [memberId];
  }
}
