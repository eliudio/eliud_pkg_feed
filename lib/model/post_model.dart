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
import 'package:eliud_core/tools/common_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/model_base.dart';

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

enum PostAccessibleByGroup {
  Public, Followers, Me, SpecificMembers, Unknown
}

enum PostArchiveStatus {
  Active, Archived, Unknown
}


PostAccessibleByGroup toPostAccessibleByGroup(int? index) {
  switch (index) {
    case 0: return PostAccessibleByGroup.Public;
    case 1: return PostAccessibleByGroup.Followers;
    case 2: return PostAccessibleByGroup.Me;
    case 3: return PostAccessibleByGroup.SpecificMembers;
  }
  return PostAccessibleByGroup.Unknown;
}

PostArchiveStatus toPostArchiveStatus(int? index) {
  switch (index) {
    case 0: return PostArchiveStatus.Active;
    case 1: return PostArchiveStatus.Archived;
  }
  return PostArchiveStatus.Unknown;
}


class PostModel implements ModelBase, WithAppId {
  String documentID;
  String authorId;
  DateTime? timestamp;

  // This is the identifier of the app to which this feed belongs
  String appId;

  // This is the identifier of the feed (optional as a post can also be used in an album)
  String? feedId;

  // This is the identifier of the app to where this feed points to
  String? postAppId;

  // This is the identifier of the page to where this feed points to
  String? postPageId;
  Map<String, dynamic>? pageParameters;
  String? html;
  String? description;
  int? likes;
  int? dislikes;
  PostAccessibleByGroup? accessibleByGroup;

  // In case accessibleByGroup == SpecificMembers, then these are the members
  List<String>? accessibleByMembers;
  List<String>? readAccess;
  PostArchiveStatus? archived;
  String? externalLink;
  List<MemberMediumContainerModel>? memberMedia;

  PostModel({required this.documentID, required this.authorId, this.timestamp, required this.appId, this.feedId, this.postAppId, this.postPageId, this.pageParameters, this.html, this.description, this.likes, this.dislikes, this.accessibleByGroup, this.accessibleByMembers, this.readAccess, this.archived, this.externalLink, this.memberMedia, })  {
    assert(documentID != null);
  }

  PostModel copyWith({String? documentID, String? authorId, DateTime? timestamp, String? appId, String? feedId, String? postAppId, String? postPageId, Map<String, dynamic>? pageParameters, String? html, String? description, int? likes, int? dislikes, PostAccessibleByGroup? accessibleByGroup, List<String>? accessibleByMembers, List<String>? readAccess, PostArchiveStatus? archived, String? externalLink, List<MemberMediumContainerModel>? memberMedia, }) {
    return PostModel(documentID: documentID ?? this.documentID, authorId: authorId ?? this.authorId, timestamp: timestamp ?? this.timestamp, appId: appId ?? this.appId, feedId: feedId ?? this.feedId, postAppId: postAppId ?? this.postAppId, postPageId: postPageId ?? this.postPageId, pageParameters: pageParameters ?? this.pageParameters, html: html ?? this.html, description: description ?? this.description, likes: likes ?? this.likes, dislikes: dislikes ?? this.dislikes, accessibleByGroup: accessibleByGroup ?? this.accessibleByGroup, accessibleByMembers: accessibleByMembers ?? this.accessibleByMembers, readAccess: readAccess ?? this.readAccess, archived: archived ?? this.archived, externalLink: externalLink ?? this.externalLink, memberMedia: memberMedia ?? this.memberMedia, );
  }

  @override
  int get hashCode => documentID.hashCode ^ authorId.hashCode ^ timestamp.hashCode ^ appId.hashCode ^ feedId.hashCode ^ postAppId.hashCode ^ postPageId.hashCode ^ pageParameters.hashCode ^ html.hashCode ^ description.hashCode ^ likes.hashCode ^ dislikes.hashCode ^ accessibleByGroup.hashCode ^ accessibleByMembers.hashCode ^ readAccess.hashCode ^ archived.hashCode ^ externalLink.hashCode ^ memberMedia.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is PostModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          authorId == other.authorId &&
          timestamp == other.timestamp &&
          appId == other.appId &&
          feedId == other.feedId &&
          postAppId == other.postAppId &&
          postPageId == other.postPageId &&
          pageParameters == other.pageParameters &&
          html == other.html &&
          description == other.description &&
          likes == other.likes &&
          dislikes == other.dislikes &&
          accessibleByGroup == other.accessibleByGroup &&
          ListEquality().equals(accessibleByMembers, other.accessibleByMembers) &&
          ListEquality().equals(readAccess, other.readAccess) &&
          archived == other.archived &&
          externalLink == other.externalLink &&
          ListEquality().equals(memberMedia, other.memberMedia);

  @override
  String toString() {
    String accessibleByMembersCsv = (accessibleByMembers == null) ? '' : accessibleByMembers!.join(', ');
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');
    String memberMediaCsv = (memberMedia == null) ? '' : memberMedia!.join(', ');

    return 'PostModel{documentID: $documentID, authorId: $authorId, timestamp: $timestamp, appId: $appId, feedId: $feedId, postAppId: $postAppId, postPageId: $postPageId, pageParameters: $pageParameters, html: $html, description: $description, likes: $likes, dislikes: $dislikes, accessibleByGroup: $accessibleByGroup, accessibleByMembers: String[] { $accessibleByMembersCsv }, readAccess: String[] { $readAccessCsv }, archived: $archived, externalLink: $externalLink, memberMedia: MemberMediumContainer[] { $memberMediaCsv }}';
  }

  PostEntity toEntity({String? appId}) {
    return PostEntity(
          authorId: (authorId != null) ? authorId : null, 
          timestamp: (timestamp == null) ? null : timestamp!.millisecondsSinceEpoch, 
          appId: (appId != null) ? appId : null, 
          feedId: (feedId != null) ? feedId : null, 
          postAppId: (postAppId != null) ? postAppId : null, 
          postPageId: (postPageId != null) ? postPageId : null, 
          pageParameters: pageParameters, 
          html: (html != null) ? html : null, 
          description: (description != null) ? description : null, 
          likes: (likes != null) ? likes : null, 
          dislikes: (dislikes != null) ? dislikes : null, 
          accessibleByGroup: (accessibleByGroup != null) ? accessibleByGroup!.index : null, 
          accessibleByMembers: (accessibleByMembers != null) ? accessibleByMembers : null, 
          readAccess: (readAccess != null) ? readAccess : null, 
          archived: (archived != null) ? archived!.index : null, 
          externalLink: (externalLink != null) ? externalLink : null, 
          memberMedia: (memberMedia != null) ? memberMedia
            !.map((item) => item.toEntity(appId: appId))
            .toList() : null, 
    );
  }

  static Future<PostModel?> fromEntity(String documentID, PostEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return PostModel(
          documentID: documentID, 
          authorId: entity.authorId ?? '', 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
          appId: entity.appId ?? '', 
          feedId: entity.feedId, 
          postAppId: entity.postAppId, 
          postPageId: entity.postPageId, 
          pageParameters: entity.pageParameters, 
          html: entity.html, 
          description: entity.description, 
          likes: entity.likes, 
          dislikes: entity.dislikes, 
          accessibleByGroup: toPostAccessibleByGroup(entity.accessibleByGroup), 
          accessibleByMembers: entity.accessibleByMembers, 
          readAccess: entity.readAccess, 
          archived: toPostArchiveStatus(entity.archived), 
          externalLink: entity.externalLink, 
          memberMedia: 
            entity.memberMedia == null ? null : List<MemberMediumContainerModel>.from(await Future.wait(entity. memberMedia
            !.map((item) {
            counter++;
              return MemberMediumContainerModel.fromEntity(counter.toString(), item);
            })
            .toList())), 
    );
  }

  static Future<PostModel?> fromEntityPlus(String documentID, PostEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return PostModel(
          documentID: documentID, 
          authorId: entity.authorId ?? '', 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
          appId: entity.appId ?? '', 
          feedId: entity.feedId, 
          postAppId: entity.postAppId, 
          postPageId: entity.postPageId, 
          pageParameters: entity.pageParameters, 
          html: entity.html, 
          description: entity.description, 
          likes: entity.likes, 
          dislikes: entity.dislikes, 
          accessibleByGroup: toPostAccessibleByGroup(entity.accessibleByGroup), 
          accessibleByMembers: entity.accessibleByMembers, 
          readAccess: entity.readAccess, 
          archived: toPostArchiveStatus(entity.archived), 
          externalLink: entity.externalLink, 
          memberMedia: 
            entity. memberMedia == null ? null : List<MemberMediumContainerModel>.from(await Future.wait(entity. memberMedia
            !.map((item) {
            counter++;
            return MemberMediumContainerModel.fromEntityPlus(counter.toString(), item, appId: appId);})
            .toList())), 
    );
  }

}

