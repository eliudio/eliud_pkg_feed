import 'package:eliud_core_model/model/member_medium_container_model.dart';
import 'package:eliud_pkg_feed_model/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FeedPostFormEvent extends Equatable {
  const FeedPostFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewFeedPostFormEvent extends FeedPostFormEvent {
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<String>? postAccessibleByMembers;

  InitialiseNewFeedPostFormEvent(
      this.postAccessibleByGroup, this.postAccessibleByMembers);

  @override
  List<Object?> get props => [postAccessibleByGroup, postAccessibleByMembers];
}

class InitialiseUpdateFeedPostFormEvent extends FeedPostFormEvent {
  final String description;
  final List<MemberMediumContainerModel> memberMedia;
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<String>? postAccessibleByMembers;
  final PostModel originalPost;

  InitialiseUpdateFeedPostFormEvent(this.originalPost, this.description,
      this.memberMedia, this.postAccessibleByGroup,
      {this.postAccessibleByMembers});

  @override
  List<Object?> get props => [
        description,
        memberMedia,
        postAccessibleByGroup,
        postAccessibleByMembers
      ];
}

class ChangedFeedPostDescription extends FeedPostFormEvent {
  final String? value;

  ChangedFeedPostDescription({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChangedFeedPostDescription{ value: $value }';
}

class ChangedFeedPostPrivilege extends FeedPostFormEvent {
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<String>? postAccessibleByMembers;

  ChangedFeedPostPrivilege(
      {required this.postAccessibleByGroup, this.postAccessibleByMembers});

  @override
  List<Object?> get props => [postAccessibleByGroup, postAccessibleByMembers];

  @override
  String toString() =>
      'ChangedFeedPostPrivilege{ postAccessibleByGroup: $postAccessibleByGroup, postAccessibleByMembers: $postAccessibleByMembers }';
}

class ChangedMedia extends FeedPostFormEvent {
  final List<MemberMediumContainerModel> memberMedia;

  ChangedMedia({required this.memberMedia});

  @override
  List<Object?> get props => [memberMedia];

  @override
  String toString() => 'ChangedMedia{ memberMedia: $memberMedia }';
}

class UploadingMedium extends FeedPostFormEvent {
  final double progress;

  UploadingMedium({required this.progress});

  @override
  List<Object?> get props => [progress];

  @override
  String toString() => 'UploadingMedium{ progress: $progress }';
}

class SubmitPost extends FeedPostFormEvent {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'SubmitPost{}';
}
