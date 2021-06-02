import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_follow/model/abstract_repository_singleton.dart';

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
  static Future<List<String>> as(PostPrivilege who, LoggedIn accessState) async {
    return PostFollowersMemberHelper.as(who, accessState.app.documentID!, accessState.member.documentID!);
  }

  // List all followers in a list to provide them access to this post
  static Future<List<String>> asFollowers(LoggedIn accessState) async {
    return PostFollowersMemberHelper.asFollowers(accessState.app.documentID!, accessState.member.documentID!);
  }

  // To allow a post to be publicly available
  static Future<List<String>> asPublic(AccessState accessState) async {
    if (accessState is LoggedIn) {
      return PostFollowersMemberHelper.asFollowers(
          accessState.app.documentID!, accessState.member.documentID!);
    } else {
      return ['PUBLIC'];
    }
  }

  static List<String> asMe(String memberId) {
    return [memberId];
  }
}


class PostFollowersMemberHelper {
  static Future<List<String>> as(PostPrivilege who, String appId, String memberId) async {
    switch (who) {
      case PostPrivilege.Public:
        return asPublic(appId, memberId);
      case PostPrivilege.JustMe:
        return asMe(memberId);
      case PostPrivilege.Followers:
        return asFollowers(appId, memberId);
    }
  }

  // List all followers in a list to provide them access to this post
  static Future<List<String>> asFollowers(String appId, String memberId) async {
    List<String> followers = (await followingRepository(appId: appId)!
        .valuesListWithDetails(
        eliudQuery: EliudQuery(theConditions: [
          EliudQueryCondition('followedId',
              isEqualTo: memberId)
        ])))
        .map((following) =>
    following!.follower!.documentID!)
        .toList();
    followers.add(memberId); // add myself
    return followers;
  }

  // To allow a post to be publicly available
  static Future<List<String>> asPublic(String appId, String memberId) async {
    List<String> followers;
    followers = await asFollowers(appId, memberId);
    followers.add('PUBLIC');
    return followers;
  }

  static List<String> asMe(String memberId) {
    return [memberId];
  }
}
