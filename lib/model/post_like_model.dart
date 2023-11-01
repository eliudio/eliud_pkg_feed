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

import 'package:eliud_core/core/base/model_base.dart';

import 'package:eliud_pkg_feed/model/entity_export.dart';


import 'package:eliud_pkg_feed/model/post_like_entity.dart';


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


class PostLikeModel implements ModelBase, WithAppId {
  static const String packageName = 'eliud_pkg_feed';
  static const String id = 'postLikes';

  String documentID;
  String postId;
  String? postCommentId;
  String memberId;
  DateTime? timestamp;

  // This is the identifier of the app to which this feed belongs
  String appId;
  LikeType? likeType;

  PostLikeModel({required this.documentID, required this.postId, this.postCommentId, required this.memberId, this.timestamp, required this.appId, this.likeType, });

  PostLikeModel copyWith({String? documentID, String? postId, String? postCommentId, String? memberId, DateTime? timestamp, String? appId, LikeType? likeType, }) {
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

  Future<List<ModelReference>> collectReferences({String? appId}) async {
    List<ModelReference> referencesCollector = [];
    return referencesCollector;
  }

  PostLikeEntity toEntity({String? appId}) {
    return PostLikeEntity(
          postId: (postId != null) ? postId : null, 
          postCommentId: (postCommentId != null) ? postCommentId : null, 
          memberId: (memberId != null) ? memberId : null, 
          timestamp: (timestamp == null) ? null : timestamp!.millisecondsSinceEpoch, 
          appId: (appId != null) ? appId : null, 
          likeType: (likeType != null) ? likeType!.index : null, 
    );
  }

  static Future<PostLikeModel?> fromEntity(String documentID, PostLikeEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return PostLikeModel(
          documentID: documentID, 
          postId: entity.postId ?? '', 
          postCommentId: entity.postCommentId, 
          memberId: entity.memberId ?? '', 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
          appId: entity.appId ?? '', 
          likeType: toLikeType(entity.likeType), 
    );
  }

  static Future<PostLikeModel?> fromEntityPlus(String documentID, PostLikeEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return PostLikeModel(
          documentID: documentID, 
          postId: entity.postId ?? '', 
          postCommentId: entity.postCommentId, 
          memberId: entity.memberId ?? '', 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
          appId: entity.appId ?? '', 
          likeType: toLikeType(entity.likeType), 
    );
  }

}

