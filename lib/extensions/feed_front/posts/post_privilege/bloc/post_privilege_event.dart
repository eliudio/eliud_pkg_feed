import 'package:eliud_pkg_feed_model/model/post_model.dart';
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

  InitialisePostPrivilegeEvent(
      {required this.postAccessibleByGroup, this.postAccessibleByMembers});

  @override
  List<Object?> get props => [postAccessibleByGroup, postAccessibleByMembers];

  @override
  String toString() =>
      'InitialisePostPrivilegeEvent{ postAccessibleByGroup: $postAccessibleByGroup, postAccessibleByMembers: $postAccessibleByMembers }';
}

class ChangedPostPrivilege extends PostPrivilegeEvent {
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<String>? postAccessibleByMembers;

  ChangedPostPrivilege(
      {required this.postAccessibleByGroup, this.postAccessibleByMembers});

  @override
  List<Object?> get props => [postAccessibleByGroup, postAccessibleByMembers];

  @override
  String toString() =>
      'ChangedPostPrivilege{ postAccessibleByGroup: $postAccessibleByGroup }';

  static ChangedPostPrivilege get(int? index) {
    if (index == PostAccessibleByGroup.public.index) {
      return ChangedPostPrivilege(
          postAccessibleByGroup: PostAccessibleByGroup.public);
    } else if (index == PostAccessibleByGroup.followers.index) {
      return ChangedPostPrivilege(
          postAccessibleByGroup: PostAccessibleByGroup.followers);
    } else if (index == PostAccessibleByGroup.specificMembers.index) {
      return ChangedPostPrivilege(
          postAccessibleByGroup: PostAccessibleByGroup.specificMembers);
    } else if (index == PostAccessibleByGroup.me.index) {
      return ChangedPostPrivilege(
          postAccessibleByGroup: PostAccessibleByGroup.me);
    }
    return ChangedPostPrivilege(
        postAccessibleByGroup: PostAccessibleByGroup.unknown);
  }
}
