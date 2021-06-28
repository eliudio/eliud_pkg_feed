/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


import 'package:eliud_pkg_feed/model/post_like_entity.dart';

import 'package:eliud_core/tools/random.dart';

enum LikeType {
  Like, Dislike, Unknown
}


LikeType toLikeType(int? index) {
  switch (index) {
    case 0: return LikeType.Like;
    case 1: return LikeType.Dislike;
  }
  return LikeType.Unknown;
}


class PostLikeModel {
  String? documentID;
  String? postId;
  String? postCommentId;
  String? memberId;
  String? timestamp;

  // This is the identifier of the app to which this feed belongs
  String? appId;
  LikeType? likeType;

  PostLikeModel({this.documentID, this.postId, this.postCommentId, this.memberId, this.timestamp, this.appId, this.likeType, })  {
    assert(documentID != null);
  }

  PostLikeModel copyWith({String? documentID, String? postId, String? postCommentId, String? memberId, String? timestamp, String? appId, LikeType? likeType, }) {
    return PostLikeModel(documentID: documentID ?? this.documentID, postId: postId ?? this.postId, postCommentId: postCommentId ?? this.postCommentId, memberId: memberId ?? this.memberId, timestamp: timestamp ?? this.timestamp, appId: appId ?? this.appId, likeType: likeType ?? this.likeType, );
  }

  @override
  int get hashCode => documentID.hashCode ^ postId.hashCode ^ postCommentId.hashCode ^ memberId.hashCode ^ timestamp.hashCode ^ appId.hashCode ^ likeType.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is PostLikeModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          postId == other.postId &&
          postCommentId == other.postCommentId &&
          memberId == other.memberId &&
          timestamp == other.timestamp &&
          appId == other.appId &&
          likeType == other.likeType;

  @override
  String toString() {
    return 'PostLikeModel{documentID: $documentID, postId: $postId, postCommentId: $postCommentId, memberId: $memberId, timestamp: $timestamp, appId: $appId, likeType: $likeType}';
  }

  PostLikeEntity toEntity({String? appId}) {
    return PostLikeEntity(
          postId: (postId != null) ? postId : null, 
          postCommentId: (postCommentId != null) ? postCommentId : null, 
          memberId: (memberId != null) ? memberId : null, 
          timestamp: timestamp, 
          appId: (appId != null) ? appId : null, 
          likeType: (likeType != null) ? likeType!.index : null, 
    );
  }

  static PostLikeModel? fromEntity(String documentID, PostLikeEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return PostLikeModel(
          documentID: documentID, 
          postId: entity.postId, 
          postCommentId: entity.postCommentId, 
          memberId: entity.memberId, 
          timestamp: entity.timestamp.toString(), 
          appId: entity.appId, 
          likeType: toLikeType(entity.likeType), 
    );
  }

  static Future<PostLikeModel?> fromEntityPlus(String documentID, PostLikeEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return PostLikeModel(
          documentID: documentID, 
          postId: entity.postId, 
          postCommentId: entity.postCommentId, 
          memberId: entity.memberId, 
          timestamp: entity.timestamp.toString(), 
          appId: entity.appId, 
          likeType: toLikeType(entity.likeType), 
    );
  }

}

