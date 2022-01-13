import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/logged_in.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_follow/model/abstract_repository_singleton.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum PostPrivilegeType {
  Public, Followers, SpecificPeople, JustMe,
}

class PostPrivilege extends Equatable {
  final PostPrivilegeType postPrivilegeType;
  final List<String>? specificFollowers;
  final List<String> readAccess;

  PostPrivilege._(this.postPrivilegeType, this.readAccess, {this.specificFollowers});

  static Future<PostPrivilege> construct1(PostPrivilegeType postPrivilegeType, AppModel app, String memberId, {List<String>? specificFollowers,}) async {
    var readAccess = await PostFollowersMemberHelper.as(postPrivilegeType, app, memberId, specificFollowers: specificFollowers);
    return PostPrivilege._(postPrivilegeType, readAccess, specificFollowers: specificFollowers);
  }

  static Future<PostPrivilege> construct2(BuildContext context, AppModel app, PostPrivilegeType postPrivilegeType, LoggedIn accessState, {List<String>? specificFollowers}) async {
    var readAccess = await PostFollowersHelper.as(context, app, postPrivilegeType, accessState);
    return PostPrivilege._(postPrivilegeType, readAccess, specificFollowers: specificFollowers);
  }

  @override
  List<Object?> get props => [postPrivilegeType, specificFollowers, readAccess];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is PostPrivilege &&
              runtimeType == other.runtimeType &&
              postPrivilegeType == other.postPrivilegeType &&
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
  static Future<PostPrivilege> determinePostPrivilege(List<String> readAccess, AppModel app, String memberId) async {
    return PostFollowersMemberHelper.determinePostPrivilege(readAccess, app, memberId);
  }

  static Future<List<String>> as(BuildContext context, AppModel app, PostPrivilegeType postPrivilegeType, LoggedIn accessState, {List<String>? specificFollowers}) async {
    return PostFollowersMemberHelper.as(postPrivilegeType, app, accessState.member.documentID!, specificFollowers: specificFollowers, );
  }

  // List all followers in a list to provide them access to this post
  static Future<List<String>> asFollowers(BuildContext context, AppModel app, LoggedIn accessState) async {
    return PostFollowersMemberHelper.asFollowers(app, accessState.member.documentID!);
  }

  // To allow a post to be publicly available
  static Future<List<String>> asPublic(BuildContext context, AppModel app, AccessDetermined accessState) async {
    if (accessState is LoggedIn) {
      return PostFollowersMemberHelper.asFollowers(app, accessState.member.documentID!);
    } else {
      return ['PUBLIC'];
    }
  }

  static List<String> asMe(String memberId) {
    return [memberId];
  }
}

class PostFollowersMemberHelper {
  static Future<PostPrivilege> determinePostPrivilege(List<String> readAccess, AppModel app, String memberId) async {
    var _asMe = asMe(memberId);
    var _asPublic = asPublic(app, memberId);
    var _asFollowers = asFollowers(app, memberId);

    if (ListHelper.listEquals(readAccess, _asMe)) return PostPrivilege.construct1(PostPrivilegeType.JustMe, app, memberId);
    if (ListHelper.listEquals(readAccess, await _asPublic)) return PostPrivilege.construct1(PostPrivilegeType.Public, app, memberId);
    if (ListHelper.listEquals(readAccess, await _asFollowers)) return PostPrivilege.construct1(PostPrivilegeType.Followers, app, memberId);

    return PostPrivilege.construct1(PostPrivilegeType.SpecificPeople, app, memberId, specificFollowers: readAccess);
  }

  static Future<List<String>> as(PostPrivilegeType postPrivilegeType, AppModel app, String memberId, {List<String>? specificFollowers}) async {
    switch (postPrivilegeType) {
      case PostPrivilegeType.Public:
        return asPublic(app, memberId);
      case PostPrivilegeType.JustMe:
        return asMe(memberId);
      case PostPrivilegeType.Followers:
        return asFollowers(app, memberId);
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
  static Future<List<String>> asFollowers(AppModel app, String memberId) async {
    List<String> followers = (await followingRepository(appId: app.documentID!)!
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
  static Future<List<String>> asPublic(AppModel app, String memberId) async {
    List<String> followers;
    followers = await asFollowers(app, memberId);
    followers.add('PUBLIC');
    return followers;
  }

  static List<String> asMe(String memberId) {
    return [memberId];
  }
}
