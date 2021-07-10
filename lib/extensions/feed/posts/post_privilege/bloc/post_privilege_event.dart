
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostPrivilegeEvent extends Equatable {
  const PostPrivilegeEvent();

  @override
  List<Object?> get props => [];
}

class InitialisePostPrivilegeEvent extends PostPrivilegeEvent {
}

class ChangedPostPrivilege extends PostPrivilegeEvent {
  final int value;
  final List<String>? specificFollowers;

  ChangedPostPrivilege({required this.value, this.specificFollowers });

  @override
  List<Object?> get props => [ value, specificFollowers ];

  @override
  String toString() => 'ChangedPostPrivilege{ value: $value }';
}

