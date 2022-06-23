/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/entity_base.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_core/tools/common_tools.dart';
class PostLikeEntity implements EntityBase {
  final String? postId;
  final String? postCommentId;
  final String? memberId;
  final Object? timestamp;
  final String? appId;
  final int? likeType;

  PostLikeEntity({required this.postId, this.postCommentId, required this.memberId, this.timestamp, required this.appId, this.likeType, });

  PostLikeEntity copyWith({Object? timestamp, }) {
    return PostLikeEntity(postId: postId, postCommentId: postCommentId, memberId: memberId, timestamp : timestamp, appId: appId, likeType: likeType, );
  }
  List<Object?> get props => [postId, postCommentId, memberId, timestamp, appId, likeType, ];

  @override
  String toString() {
    return 'PostLikeEntity{postId: $postId, postCommentId: $postCommentId, memberId: $memberId, timestamp: $timestamp, appId: $appId, likeType: $likeType}';
  }

  static PostLikeEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return PostLikeEntity(
      postId: map['postId'], 
      postCommentId: map['postCommentId'], 
      memberId: map['memberId'], 
      timestamp: map['timestamp'] == null ? null : (map['timestamp']  as Timestamp).millisecondsSinceEpoch,
      appId: map['appId'], 
      likeType: map['likeType'], 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (postId != null) theDocument["postId"] = postId;
      else theDocument["postId"] = null;
    if (postCommentId != null) theDocument["postCommentId"] = postCommentId;
      else theDocument["postCommentId"] = null;
    if (memberId != null) theDocument["memberId"] = memberId;
      else theDocument["memberId"] = null;
    theDocument["timestamp"] = timestamp;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (likeType != null) theDocument["likeType"] = likeType;
      else theDocument["likeType"] = null;
    return theDocument;
  }

  static PostLikeEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

