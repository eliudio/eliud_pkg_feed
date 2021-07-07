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
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FeedPostModelDetails {
  final String description;
  // final List<MemberMediumModel> memberMedia;
  final List<PostMediumModel> memberMedia;
  final PostPrivilege postPrivilege;
  final List<String> readAccess;

  FeedPostModelDetails({required this.description, required this.memberMedia, required this.postPrivilege, required this.readAccess});

  FeedPostModelDetails copyWith({String? description, List<PostMediumModel>? memberMedia, PostPrivilege? postPrivilege, List<String>? readAccess}) {
    return FeedPostModelDetails(description: description ?? this.description, memberMedia: memberMedia ?? this.memberMedia, postPrivilege: postPrivilege ?? this.postPrivilege, readAccess: readAccess ?? this.readAccess);
  }
}