/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import 'package:eliud_pkg_storage/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

class PostCommentEntity {
  final String postId;
  final String postCommentId;
  final String memberId;
  final Object timestamp;
  final String appId;
  final String comment;
  final int likes;
  final int dislikes;
  final List<MemberImageEntity> memberImages;

  PostCommentEntity({this.postId, this.postCommentId, this.memberId, this.timestamp, this.appId, this.comment, this.likes, this.dislikes, this.memberImages, });

  PostCommentEntity copyWith({Object timestamp, }) {
    return PostCommentEntity(postId: postId, postCommentId: postCommentId, memberId: memberId, timestamp : timestamp, appId: appId, comment: comment, likes: likes, dislikes: dislikes, memberImages: memberImages, );
  }
  List<Object> get props => [postId, postCommentId, memberId, timestamp, appId, comment, likes, dislikes, memberImages, ];

  @override
  String toString() {
    String memberImagesCsv = (memberImages == null) ? '' : memberImages.join(', ');

    return 'PostCommentEntity{postId: $postId, postCommentId: $postCommentId, memberId: $memberId, timestamp: $timestamp, appId: $appId, comment: $comment, likes: $likes, dislikes: $dislikes, memberImages: MemberImage[] { $memberImagesCsv }}';
  }

  static PostCommentEntity fromMap(Map map) {
    if (map == null) return null;

    var memberImagesFromMap;
    memberImagesFromMap = map['memberImages'];
    var memberImagesList;
    if (memberImagesFromMap != null)
      memberImagesList = (map['memberImages'] as List<dynamic>)
        .map((dynamic item) =>
        MemberImageEntity.fromMap(item as Map))
        .toList();

    return PostCommentEntity(
      postId: map['postId'], 
      postCommentId: map['postCommentId'], 
      memberId: map['memberId'], 
      timestamp: postCommentRepository().timeStampToString(map['timestamp']), 
      appId: map['appId'], 
      comment: map['comment'], 
      likes: int.tryParse(map['likes'].toString()), 
      dislikes: int.tryParse(map['dislikes'].toString()), 
      memberImages: memberImagesList, 
    );
  }

  Map<String, Object> toDocument() {
    final List<Map<String, dynamic>> memberImagesListMap = memberImages != null 
        ? memberImages.map((item) => item.toDocument()).toList()
        : null;

    Map<String, Object> theDocument = HashMap();
    if (postId != null) theDocument["postId"] = postId;
      else theDocument["postId"] = null;
    if (postCommentId != null) theDocument["postCommentId"] = postCommentId;
      else theDocument["postCommentId"] = null;
    if (memberId != null) theDocument["memberId"] = memberId;
      else theDocument["memberId"] = null;
    theDocument["timestamp"] = timestamp;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (comment != null) theDocument["comment"] = comment;
      else theDocument["comment"] = null;
    if (likes != null) theDocument["likes"] = likes;
      else theDocument["likes"] = null;
    if (dislikes != null) theDocument["dislikes"] = dislikes;
      else theDocument["dislikes"] = null;
    if (memberImages != null) theDocument["memberImages"] = memberImagesListMap;
      else theDocument["memberImages"] = null;
    return theDocument;
  }

  static PostCommentEntity fromJsonString(String json) {
    Map<String, dynamic> generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

