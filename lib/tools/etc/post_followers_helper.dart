import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_follow/model/abstract_repository_singleton.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

enum PostPrivilegeType {
  Public, Followers, SpecificPeople, JustMe,
}

class PostPrivilege extends Equatable {
  final PostPrivilegeType postPrivilegeType;
  final List<String>? specificFollowers;
  final List<String> readAccess;

  PostPrivilege._(this.postPrivilegeType, this.readAccess, {this.specificFollowers});

  static Future<PostPrivilege> construct1(PostPrivilegeType postPrivilegeType, String appId, String memberId, {List<String>? specificFollowers,}) async {
    var readAccess = await PostFollowersMemberHelper.as(postPrivilegeType, appId, memberId, specificFollowers: specificFollowers);
    return PostPrivilege._(postPrivilegeType, readAccess, specificFollowers: specificFollowers);
  }

  static Future<PostPrivilege> construct2(PostPrivilegeType postPrivilegeType, LoggedIn accessState, {List<String>? specificFollowers}) async {
    var readAccess = await PostFollowersHelper.as(postPrivilegeType, accessState);
    return PostPrivilege._(postPrivilegeType, readAccess, specificFollowers: specificFollowers);
  }

  @override
  List<Object?> get props => [postPrivilegeType, specificFollowers, readAccess];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is PostPrivilege &&
              runtimeType == other.runtimeType &&
              ListEquality().equals(specificFollowers, other.specificFollowers) &&
              ListEquality().equals(readAccess, other.readAccess);
}

PostPrivilegeType toPostPrivilegeType(int index) {
  switch (index) {
    case 0: return PostPrivilegeType.Public;
    case 1: return PostPrivilegeType.Followers;
    case 2: return PostPrivilegeType.SpecificPeople;
    case 3: return PostPrivilegeType.JustMe;
  }
  return PostPrivilegeType.JustMe;
}

class PostFollowersHelper {
  static Future<PostPrivilege> determinePostPrivilege(List<String> readAccess, String appId, String memberId) async {
    return PostFollowersMemberHelper.determinePostPrivilege(readAccess, appId, memberId);
  }

  static Future<List<String>> as(PostPrivilegeType postPrivilegeType, LoggedIn accessState, {List<String>? specificFollowers}) async {
    return PostFollowersMemberHelper.as(postPrivilegeType, accessState.app.documentID!, accessState.member.documentID!, specificFollowers: specificFollowers, );
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
  static Future<PostPrivilege> determinePostPrivilege(List<String> readAccess, String appId, String memberId) async {
    var _asMe = asMe(memberId);
    var _asPublic = asPublic(appId, memberId);
    var _asFollowers = asFollowers(appId, memberId);

    if (ListHelper.listEquals(readAccess, _asMe)) return PostPrivilege.construct1(PostPrivilegeType.JustMe, appId, memberId);
    if (ListHelper.listEquals(readAccess, await _asPublic)) return PostPrivilege.construct1(PostPrivilegeType.Public, appId, memberId);
    if (ListHelper.listEquals(readAccess, await _asFollowers)) return PostPrivilege.construct1(PostPrivilegeType.Followers, appId, memberId);

    return PostPrivilege.construct1(PostPrivilegeType.SpecificPeople, appId, memberId, specificFollowers: readAccess);
  }

  static Future<List<String>> as(PostPrivilegeType postPrivilegeType, String appId, String memberId, {List<String>? specificFollowers}) async {
    switch (postPrivilegeType) {
      case PostPrivilegeType.Public:
        return asPublic(appId, memberId);
      case PostPrivilegeType.JustMe:
        return asMe(memberId);
      case PostPrivilegeType.Followers:
        return asFollowers(appId, memberId);
      case PostPrivilegeType.SpecificPeople:
        {
          if (specificFollowers == null) return [memberId];
          if (specificFollowers.contains(memberId)) return specificFollowers;
          specificFollowers.add(memberId);
          return specificFollowers;
        }
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
