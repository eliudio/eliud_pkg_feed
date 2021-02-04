/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/global_data.dart';
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


import 'package:eliud_pkg_feed/model/post_comment_entity.dart';

import 'package:eliud_core/tools/random.dart';



class PostCommentModel {
  String documentID;
  String postId;
  String postCommentId;
  String memberId;
  String timestamp;

  // This is the identifier of the app to which this feed belongs
  String appId;
  String comment;
  int likes;
  int dislikes;

  PostCommentModel({this.documentID, this.postId, this.postCommentId, this.memberId, this.timestamp, this.appId, this.comment, this.likes, this.dislikes, })  {
    assert(documentID != null);
  }

  PostCommentModel copyWith({String documentID, String postId, String postCommentId, String memberId, String timestamp, String appId, String comment, int likes, int dislikes, }) {
    return PostCommentModel(documentID: documentID ?? this.documentID, postId: postId ?? this.postId, postCommentId: postCommentId ?? this.postCommentId, memberId: memberId ?? this.memberId, timestamp: timestamp ?? this.timestamp, appId: appId ?? this.appId, comment: comment ?? this.comment, likes: likes ?? this.likes, dislikes: dislikes ?? this.dislikes, );
  }

  @override
  int get hashCode => documentID.hashCode ^ postId.hashCode ^ postCommentId.hashCode ^ memberId.hashCode ^ timestamp.hashCode ^ appId.hashCode ^ comment.hashCode ^ likes.hashCode ^ dislikes.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is PostCommentModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          postId == other.postId &&
          postCommentId == other.postCommentId &&
          memberId == other.memberId &&
          timestamp == other.timestamp &&
          appId == other.appId &&
          comment == other.comment &&
          likes == other.likes &&
          dislikes == other.dislikes;

  @override
  String toString() {
    return 'PostCommentModel{documentID: $documentID, postId: $postId, postCommentId: $postCommentId, memberId: $memberId, timestamp: $timestamp, appId: $appId, comment: $comment, likes: $likes, dislikes: $dislikes}';
  }

  PostCommentEntity toEntity({String appId}) {
    return PostCommentEntity(
          postId: (postId != null) ? postId : null, 
          postCommentId: (postCommentId != null) ? postCommentId : null, 
          memberId: (memberId != null) ? memberId : null, 
          timestamp: timestamp,           appId: (appId != null) ? appId : null, 
          comment: (comment != null) ? comment : null, 
          likes: (likes != null) ? likes : null, 
          dislikes: (dislikes != null) ? dislikes : null, 
    );
  }

  static PostCommentModel fromEntity(String documentID, PostCommentEntity entity) {
    if (entity == null) return null;
    return PostCommentModel(
          documentID: documentID, 
          postId: entity.postId, 
          postCommentId: entity.postCommentId, 
          memberId: entity.memberId, 
          timestamp: entity.timestamp, 
          appId: entity.appId, 
          comment: entity.comment, 
          likes: entity.likes, 
          dislikes: entity.dislikes, 
    );
  }

  static Future<PostCommentModel> fromEntityPlus(String documentID, PostCommentEntity entity, { String appId}) async {
    if (entity == null) return null;

    return PostCommentModel(
          documentID: documentID, 
          postId: entity.postId, 
          postCommentId: entity.postCommentId, 
          memberId: entity.memberId, 
          timestamp: entity.timestamp, 
          appId: entity.appId, 
          comment: entity.comment, 
          likes: entity.likes, 
          dislikes: entity.dislikes, 
    );
  }

}

