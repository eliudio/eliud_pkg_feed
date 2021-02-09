/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:collection/collection.dart';
import 'package:eliud_core/core/global_data.dart';
import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_storage/model/repository_export.dart';
import 'package:eliud_pkg_storage/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import 'package:eliud_pkg_storage/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import 'package:eliud_pkg_storage/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


import 'package:eliud_pkg_feed/model/post_entity.dart';

import 'package:eliud_core/tools/random.dart';

enum PostArchiveStatus {
  Active, Archived, Unknown
}


PostArchiveStatus toPostArchiveStatus(int index) {
  switch (index) {
    case 0: return PostArchiveStatus.Active;
    case 1: return PostArchiveStatus.Archived;
  }
  return PostArchiveStatus.Unknown;
}


class PostModel {
  String documentID;
  MemberPublicInfoModel author;
  String timestamp;

  // This is the identifier of the app to which this feed belongs
  String appId;

  // This is the identifier of the app to where this feed points to
  String postAppId;

  // This is the identifier of the page to where this feed points to
  String postPageId;
  Map<String, Object> pageParameters;
  String description;
  int likes;
  int dislikes;
  List<String> readAccess;
  PostArchiveStatus archived;
  List<MemberImageModel> memberImages;

  PostModel({this.documentID, this.author, this.timestamp, this.appId, this.postAppId, this.postPageId, this.pageParameters, this.description, this.likes, this.dislikes, this.readAccess, this.archived, this.memberImages, })  {
    assert(documentID != null);
  }

  PostModel copyWith({String documentID, MemberPublicInfoModel author, String timestamp, String appId, String postAppId, String postPageId, Map<String, Object> pageParameters, String description, int likes, int dislikes, List<String> readAccess, PostArchiveStatus archived, List<MemberImageModel> memberImages, }) {
    return PostModel(documentID: documentID ?? this.documentID, author: author ?? this.author, timestamp: timestamp ?? this.timestamp, appId: appId ?? this.appId, postAppId: postAppId ?? this.postAppId, postPageId: postPageId ?? this.postPageId, pageParameters: pageParameters ?? this.pageParameters, description: description ?? this.description, likes: likes ?? this.likes, dislikes: dislikes ?? this.dislikes, readAccess: readAccess ?? this.readAccess, archived: archived ?? this.archived, memberImages: memberImages ?? this.memberImages, );
  }

  @override
  int get hashCode => documentID.hashCode ^ author.hashCode ^ timestamp.hashCode ^ appId.hashCode ^ postAppId.hashCode ^ postPageId.hashCode ^ pageParameters.hashCode ^ description.hashCode ^ likes.hashCode ^ dislikes.hashCode ^ readAccess.hashCode ^ archived.hashCode ^ memberImages.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is PostModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          author == other.author &&
          timestamp == other.timestamp &&
          appId == other.appId &&
          postAppId == other.postAppId &&
          postPageId == other.postPageId &&
          pageParameters == other.pageParameters &&
          description == other.description &&
          likes == other.likes &&
          dislikes == other.dislikes &&
          ListEquality().equals(readAccess, other.readAccess) &&
          archived == other.archived &&
          ListEquality().equals(memberImages, other.memberImages);

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess.join(', ');
    String memberImagesCsv = (memberImages == null) ? '' : memberImages.join(', ');

    return 'PostModel{documentID: $documentID, author: $author, timestamp: $timestamp, appId: $appId, postAppId: $postAppId, postPageId: $postPageId, pageParameters: $pageParameters, description: $description, likes: $likes, dislikes: $dislikes, readAccess: String[] { $readAccessCsv }, archived: $archived, memberImages: MemberImage[] { $memberImagesCsv }}';
  }

  PostEntity toEntity({String appId}) {
    return PostEntity(
          authorId: (author != null) ? author.documentID : null, 
          timestamp: timestamp,           appId: (appId != null) ? appId : null, 
          postAppId: (postAppId != null) ? postAppId : null, 
          postPageId: (postPageId != null) ? postPageId : null, 
          pageParameters: pageParameters,           description: (description != null) ? description : null, 
          likes: (likes != null) ? likes : null, 
          dislikes: (dislikes != null) ? dislikes : null, 
          readAccess: (readAccess != null) ? readAccess : null, 
          archived: (archived != null) ? archived.index : null, 
          memberImages: (memberImages != null) ? memberImages
            .map((item) => item.toEntity(appId: appId))
            .toList() : null, 
    );
  }

  static PostModel fromEntity(String documentID, PostEntity entity) {
    if (entity == null) return null;
    return PostModel(
          documentID: documentID, 
          timestamp: entity.timestamp, 
          appId: entity.appId, 
          postAppId: entity.postAppId, 
          postPageId: entity.postPageId, 
          pageParameters: entity.pageParameters, 
          description: entity.description, 
          likes: entity.likes, 
          dislikes: entity.dislikes, 
          readAccess: entity.readAccess, 
          archived: toPostArchiveStatus(entity.archived), 
          memberImages: 
            entity.memberImages == null ? null :
            entity.memberImages
            .map((item) => MemberImageModel.fromEntity(newRandomKey(), item))
            .toList(), 
    );
  }

  static Future<PostModel> fromEntityPlus(String documentID, PostEntity entity, { String appId}) async {
    if (entity == null) return null;

    MemberPublicInfoModel authorHolder;
    if (entity.authorId != null) {
      try {
        await memberPublicInfoRepository(appId: appId).get(entity.authorId).then((val) {
          authorHolder = val;
        }).catchError((error) {});
      } catch (_) {}
    }

    return PostModel(
          documentID: documentID, 
          author: authorHolder, 
          timestamp: entity.timestamp, 
          appId: entity.appId, 
          postAppId: entity.postAppId, 
          postPageId: entity.postPageId, 
          pageParameters: entity.pageParameters, 
          description: entity.description, 
          likes: entity.likes, 
          dislikes: entity.dislikes, 
          readAccess: entity.readAccess, 
          archived: toPostArchiveStatus(entity.archived), 
          memberImages: 
            entity. memberImages == null ? null : new List<MemberImageModel>.from(await Future.wait(entity. memberImages
            .map((item) => MemberImageModel.fromEntityPlus(newRandomKey(), item, appId: appId))
            .toList())), 
    );
  }

}

