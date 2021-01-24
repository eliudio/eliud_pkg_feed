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
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

class PostLikeEntity {
  final String postId;
  final String memberId;
  final Object timestamp;
  final String appId;
  final int likeType;

  PostLikeEntity({this.postId, this.memberId, this.timestamp, this.appId, this.likeType, });

  PostLikeEntity copyWith({Object timestamp, }) {
    return PostLikeEntity(postId: postId, memberId: memberId, timestamp : timestamp, appId: appId, likeType: likeType, );
  }
  List<Object> get props => [postId, memberId, timestamp, appId, likeType, ];

  @override
  String toString() {
    return 'PostLikeEntity{postId: $postId, memberId: $memberId, timestamp: $timestamp, appId: $appId, likeType: $likeType}';
  }

  static PostLikeEntity fromMap(Map map) {
    if (map == null) return null;

    return PostLikeEntity(
      postId: map['postId'], 
      memberId: map['memberId'], 
      timestamp: postLikeRepository().timeStampToString(map['timestamp']), 
      appId: map['appId'], 
      likeType: map['likeType'], 
    );
  }

  Map<String, Object> toDocument() {
    Map<String, Object> theDocument = HashMap();
    if (postId != null) theDocument["postId"] = postId;
      else theDocument["postId"] = null;
    if (memberId != null) theDocument["memberId"] = memberId;
      else theDocument["memberId"] = null;
    theDocument["timestamp"] = timestamp;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (likeType != null) theDocument["likeType"] = likeType;
      else theDocument["likeType"] = null;
    return theDocument;
  }

  static PostLikeEntity fromJsonString(String json) {
    Map<String, dynamic> generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

