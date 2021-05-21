/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

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

class ChangedFeedPhotos extends FeedPostFormEvent {
  final List<PhotoWithThumbnail> photoWithThumbnails;

  ChangedFeedPhotos({required this.photoWithThumbnails});

  @override
  List<Object?> get props => [ photoWithThumbnails ];

  @override
  String toString() => 'ChangedFeedPhotos{ photoWithThumbnails: $photoWithThumbnails }';
}

class ChangedFeedVideos extends FeedPostFormEvent {
  final List<VideoWithThumbnail> videoWithThumbnails;

  ChangedFeedVideos({required this.videoWithThumbnails});

  @override
  List<Object?> get props => [ videoWithThumbnails ];

  @override
  String toString() => 'ChangedFeedVideos{ videoWithThumbnails: $videoWithThumbnails }';
}

