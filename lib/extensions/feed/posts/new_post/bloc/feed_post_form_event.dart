import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';

import 'feed_post_model_details.dart';
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
  List<String> readAccess;

  InitialiseUpdateFeedPostFormEvent(this.description, this.memberMedia, this.readAccess);

  @override
  List<Object?> get props => [description, memberMedia, readAccess];
}

class ChangedFeedPostDescription extends FeedPostFormEvent {
  final String? value;

  ChangedFeedPostDescription({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedPostDescription{ value: $value }';
}

class ChangedFeedPostPrivilege extends FeedPostFormEvent {
  final PostPrivilege? value;

  ChangedFeedPostPrivilege({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedPostDescription{ value: $value }';
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
