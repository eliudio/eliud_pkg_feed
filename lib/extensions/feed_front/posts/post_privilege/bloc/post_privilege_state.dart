import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_privilege/bloc/member_service.dart';
import 'package:eliud_pkg_feed_model/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

@immutable
abstract class PostPrivilegeState extends Equatable {
  const PostPrivilegeState();

  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostPrivilegeState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class PostPrivilegeUninitialized extends PostPrivilegeState {
  @override
  String toString() {
    return '''PostPrivilegeUninitialized()''';
  }

  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostPrivilegeUninitialized && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class PostPrivilegeInitialized extends PostPrivilegeState {
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<SelectedMember>? specificSelectedMembers;

  const PostPrivilegeInitialized(
      {required this.postAccessibleByGroup, this.specificSelectedMembers});

  @override
  List<Object?> get props => [postAccessibleByGroup, specificSelectedMembers];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostPrivilegeInitialized &&
          runtimeType == other.runtimeType &&
          postAccessibleByGroup == other.postAccessibleByGroup &&
          ListEquality()
              .equals(specificSelectedMembers, other.specificSelectedMembers);

  List<String>? getPostAccessibleByMembers() => specificSelectedMembers == null
      ? null
      : specificSelectedMembers!.map((e) => e.memberId).toList();

  @override
  int get hashCode =>
      postAccessibleByGroup.hashCode ^ specificSelectedMembers.hashCode;
}
