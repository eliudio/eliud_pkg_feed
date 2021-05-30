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
    switch (who) {
      case PostPrivilege.Public:
        return asPublic(accessState);
      case PostPrivilege.JustMe:
        return asMe(accessState.member.documentID!);
      case PostPrivilege.Followers:
        return asFollowers(accessState);
    }
  }

  // List all followers in a list to provide them access to this post
  static Future<List<String>> asFollowers(LoggedIn accessState) async {
    var appId = accessState.app.documentID!;
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
  static Future<List<String>> asPublic(LoggedIn accessState) async {
    List<String> followers = await asFollowers(accessState);
    followers.add('PUBLIC');
    return followers;
  }

  static List<String> asMe(String memberId) {
    return [memberId];
  }
}
