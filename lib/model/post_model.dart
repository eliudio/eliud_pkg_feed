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


import 'package:eliud_pkg_feed/model/post_entity.dart';

import 'package:eliud_core/tools/random.dart';

enum PostArchiveStatus {
  Active, Archived, Unknown
}


PostArchiveStatus toPostArchiveStatus(int? index) {
  switch (index) {
    case 0: return PostArchiveStatus.Active;
    case 1: return PostArchiveStatus.Archived;
  }
  return PostArchiveStatus.Unknown;
}


class PostModel {
  String? documentID;
  MemberPublicInfoModel? author;
  String? timestamp;

  // This is the identifier of the app to which this feed belongs
  String? appId;

  // This is the identifier of the feed (optional as a post can also be used in an album)
  String? feedId;

  // This is the identifier of the app to where this feed points to
  String? postAppId;

  // This is the identifier of the page to where this feed points to
  String? postPageId;
  Map<String, dynamic>? pageParameters;
  String? description;
  int? likes;
  int? dislikes;
  List<String>? readAccess;
  PostArchiveStatus? archived;
  String? externalLink;
  List<PostMediumModel>? memberMedia;

  PostModel({this.documentID, this.author, this.timestamp, this.appId, this.feedId, this.postAppId, this.postPageId, this.pageParameters, this.description, this.likes, this.dislikes, this.readAccess, this.archived, this.externalLink, this.memberMedia, })  {
    assert(documentID != null);
  }

  PostModel copyWith({String? documentID, MemberPublicInfoModel? author, String? timestamp, String? appId, String? feedId, String? postAppId, String? postPageId, Map<String, dynamic>? pageParameters, String? description, int? likes, int? dislikes, List<String>? readAccess, PostArchiveStatus? archived, String? externalLink, List<PostMediumModel>? memberMedia, }) {
    return PostModel(documentID: documentID ?? this.documentID, author: author ?? this.author, timestamp: timestamp ?? this.timestamp, appId: appId ?? this.appId, feedId: feedId ?? this.feedId, postAppId: postAppId ?? this.postAppId, postPageId: postPageId ?? this.postPageId, pageParameters: pageParameters ?? this.pageParameters, description: description ?? this.description, likes: likes ?? this.likes, dislikes: dislikes ?? this.dislikes, readAccess: readAccess ?? this.readAccess, archived: archived ?? this.archived, externalLink: externalLink ?? this.externalLink, memberMedia: memberMedia ?? this.memberMedia, );
  }

  @override
  int get hashCode => documentID.hashCode ^ author.hashCode ^ timestamp.hashCode ^ appId.hashCode ^ feedId.hashCode ^ postAppId.hashCode ^ postPageId.hashCode ^ pageParameters.hashCode ^ description.hashCode ^ likes.hashCode ^ dislikes.hashCode ^ readAccess.hashCode ^ archived.hashCode ^ externalLink.hashCode ^ memberMedia.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is PostModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          author == other.author &&
          timestamp == other.timestamp &&
          appId == other.appId &&
          feedId == other.feedId &&
          postAppId == other.postAppId &&
          postPageId == other.postPageId &&
          pageParameters == other.pageParameters &&
          description == other.description &&
          likes == other.likes &&
          dislikes == other.dislikes &&
          ListEquality().equals(readAccess, other.readAccess) &&
          archived == other.archived &&
          externalLink == other.externalLink &&
          ListEquality().equals(memberMedia, other.memberMedia);

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');
    String memberMediaCsv = (memberMedia == null) ? '' : memberMedia!.join(', ');

    return 'PostModel{documentID: $documentID, author: $author, timestamp: $timestamp, appId: $appId, feedId: $feedId, postAppId: $postAppId, postPageId: $postPageId, pageParameters: $pageParameters, description: $description, likes: $likes, dislikes: $dislikes, readAccess: String[] { $readAccessCsv }, archived: $archived, externalLink: $externalLink, memberMedia: PostMedium[] { $memberMediaCsv }}';
  }

  PostEntity toEntity({String? appId}) {
    return PostEntity(
          authorId: (author != null) ? author!.documentID : null, 
          timestamp: timestamp, 
          appId: (appId != null) ? appId : null, 
          feedId: (feedId != null) ? feedId : null, 
          postAppId: (postAppId != null) ? postAppId : null, 
          postPageId: (postPageId != null) ? postPageId : null, 
          pageParameters: pageParameters, 
          description: (description != null) ? description : null, 
          likes: (likes != null) ? likes : null, 
          dislikes: (dislikes != null) ? dislikes : null, 
          readAccess: (readAccess != null) ? readAccess : null, 
          archived: (archived != null) ? archived!.index : null, 
          externalLink: (externalLink != null) ? externalLink : null, 
          memberMedia: (memberMedia != null) ? memberMedia
            !.map((item) => item.toEntity(appId: appId))
            .toList() : null, 
    );
  }

  static PostModel? fromEntity(String documentID, PostEntity? entity) {
    if (entity == null) return null;
    return PostModel(
          documentID: documentID, 
          timestamp: entity.timestamp.toString(), 
          appId: entity.appId, 
          feedId: entity.feedId, 
          postAppId: entity.postAppId, 
          postPageId: entity.postPageId, 
          pageParameters: entity.pageParameters, 
          description: entity.description, 
          likes: entity.likes, 
          dislikes: entity.dislikes, 
          readAccess: entity.readAccess, 
          archived: toPostArchiveStatus(entity.archived), 
          externalLink: entity.externalLink, 
          memberMedia: 
            entity.memberMedia == null ? null :
            entity.memberMedia
            !.map((item) => PostMediumModel.fromEntity(newRandomKey(), item)!)
            .toList(), 
    );
  }

  static Future<PostModel?> fromEntityPlus(String documentID, PostEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    MemberPublicInfoModel? authorHolder;
    if (entity.authorId != null) {
      try {
          authorHolder = await memberPublicInfoRepository(appId: appId)!.get(entity.authorId);
      } on Exception catch(e) {
        print('Error whilst trying to initialise author');
        print('Error whilst retrieving memberPublicInfo with id ${entity.authorId}');
        print('Exception: $e');
      }
    }

    return PostModel(
          documentID: documentID, 
          author: authorHolder, 
          timestamp: entity.timestamp.toString(), 
          appId: entity.appId, 
          feedId: entity.feedId, 
          postAppId: entity.postAppId, 
          postPageId: entity.postPageId, 
          pageParameters: entity.pageParameters, 
          description: entity.description, 
          likes: entity.likes, 
          dislikes: entity.dislikes, 
          readAccess: entity.readAccess, 
          archived: toPostArchiveStatus(entity.archived), 
          externalLink: entity.externalLink, 
          memberMedia: 
            entity. memberMedia == null ? null : new List<PostMediumModel>.from(await Future.wait(entity. memberMedia
            !.map((item) => PostMediumModel.fromEntityPlus(newRandomKey(), item, appId: appId))
            .toList())), 
    );
  }

}

