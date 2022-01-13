import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';

@immutable
abstract class FeedPostFormEvent extends Equatable {
  const FeedPostFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewFeedPostFormEvent extends FeedPostFormEvent {
}

class InitialiseUpdateFeedPostFormEvent extends FeedPostFormEvent {
  final String description;
  final List<PostMediumModel> memberMedia;
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<String>? postAccessibleByMembers;

  InitialiseUpdateFeedPostFormEvent(this.description, this.memberMedia, this.postAccessibleByGroup, {this.postAccessibleByMembers});

  @override
  List<Object?> get props => [description, memberMedia, postAccessibleByGroup, postAccessibleByMembers];
}

class ChangedFeedPostDescription extends FeedPostFormEvent {
  final String? value;

  ChangedFeedPostDescription({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedFeedPostDescription{ value: $value }';
}

class ChangedFeedPostPrivilege extends FeedPostFormEvent {
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<String>? postAccessibleByMembers;

  ChangedFeedPostPrivilege({required this.postAccessibleByGroup, this.postAccessibleByMembers });

  @override
  List<Object?> get props => [ postAccessibleByGroup, postAccessibleByMembers ];

  @override
  String toString() => 'ChangedFeedPostPrivilege{ postAccessibleByGroup: $postAccessibleByGroup, postAccessibleByMembers: $postAccessibleByMembers }';
}

class ChangedMedia extends FeedPostFormEvent {
  final List<PostMediumModel> memberMedia;

  ChangedMedia({required this.memberMedia});

  @override
  List<Object?> get props => [ memberMedia ];

  @override
  String toString() => 'ChangedMedia{ memberMedia: $memberMedia }';
}

class UploadingMedium extends FeedPostFormEvent {
  final double progress;

  UploadingMedium({required this.progress});

  @override
  List<Object?> get props => [ progress ];

  @override
  String toString() => 'UploadingMedium{ progress: $progress }';
}

class SubmitPost extends FeedPostFormEvent {

  @override
  List<Object?> get props => [  ];

  @override
  String toString() => 'SubmitPost{}';
}
