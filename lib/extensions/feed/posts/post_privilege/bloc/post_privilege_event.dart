import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostPrivilegeEvent extends Equatable {
  const PostPrivilegeEvent();

  @override
  List<Object?> get props => [];
}

class InitialisePostPrivilegeEvent extends PostPrivilegeEvent {
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<String>? postAccessibleByMembers;

  InitialisePostPrivilegeEvent({required this.postAccessibleByGroup, this.postAccessibleByMembers });

  @override
  List<Object?> get props => [ postAccessibleByGroup, postAccessibleByMembers ];

  @override
  String toString() => 'InitialisePostPrivilegeEvent{ postAccessibleByGroup: $postAccessibleByGroup, postAccessibleByMembers: $postAccessibleByMembers }';
}

class ChangedPostPrivilege extends PostPrivilegeEvent {
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<String>? postAccessibleByMembers;

  ChangedPostPrivilege({required this.postAccessibleByGroup, this.postAccessibleByMembers });

  @override
  List<Object?> get props => [ postAccessibleByGroup, postAccessibleByMembers ];

  @override
  String toString() => 'ChangedPostPrivilege{ postAccessibleByGroup: $postAccessibleByGroup }';

  static ChangedPostPrivilege get(int? index) {
    if (index == PostAccessibleByGroup.Public.index) {
      return ChangedPostPrivilege(postAccessibleByGroup: PostAccessibleByGroup.Public);
    } else if (index == PostAccessibleByGroup.Followers.index) {
      return ChangedPostPrivilege(postAccessibleByGroup: PostAccessibleByGroup.Followers);
    } else if (index == PostAccessibleByGroup.SpecificMembers.index) {
      return ChangedPostPrivilege(postAccessibleByGroup: PostAccessibleByGroup.SpecificMembers);
    } else if (index == PostAccessibleByGroup.Me.index) {
      return ChangedPostPrivilege(postAccessibleByGroup: PostAccessibleByGroup.Me);
    }
    return ChangedPostPrivilege(postAccessibleByGroup: PostAccessibleByGroup.Unknown);
  }
}

