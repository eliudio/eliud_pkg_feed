import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostPrivilegeState extends Equatable {
  const PostPrivilegeState();

  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is PostPrivilegeState &&
              runtimeType == other.runtimeType;
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
  bool operator == (Object other) =>
      identical(this, other) ||
          other is PostPrivilegeUninitialized &&
              runtimeType == other.runtimeType;
}

class PostPrivilegeInitialized extends PostPrivilegeState {
  final PostPrivilege postPrivilege;

  const PostPrivilegeInitialized({ required this.postPrivilege });

  @override
  List<Object?> get props => [ postPrivilege ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is PostPrivilegeInitialized &&
              runtimeType == other.runtimeType &&
              postPrivilege == other.postPrivilege;
}
