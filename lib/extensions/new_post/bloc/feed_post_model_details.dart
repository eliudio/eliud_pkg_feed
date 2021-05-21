/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FeedPostModelDetails {
  final String description;
  final List<PhotoWithThumbnail> photoWithThumbnails;
  final List<VideoWithThumbnail> videoWithThumbnails;
  final PostPrivilege postPrivilege;

  FeedPostModelDetails({required this.description, required this.photoWithThumbnails, required this.videoWithThumbnails, required this.postPrivilege, });

  FeedPostModelDetails copyWith({String? description, List<PhotoWithThumbnail>? photoWithThumbnails, List<VideoWithThumbnail>? videoWithThumbnails, PostPrivilege? postPrivilege, }) {
    return FeedPostModelDetails(description: description ?? this.description, photoWithThumbnails: photoWithThumbnails ?? this.photoWithThumbnails, videoWithThumbnails: videoWithThumbnails ?? this.videoWithThumbnails, postPrivilege: postPrivilege ?? this.postPrivilege, );
  }
}