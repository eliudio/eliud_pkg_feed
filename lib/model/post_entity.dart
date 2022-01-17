/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_core/tools/common_tools.dart';
class PostEntity {
  final String? authorId;
  final Object? timestamp;
  final String? appId;
  final String? feedId;
  final String? postAppId;
  final String? postPageId;
  final Map<String, dynamic>? pageParameters;
  final String? html;
  final String? description;
  final int? likes;
  final int? dislikes;
  final int? accessibleByGroup;
  final List<String>? accessibleByMembers;
  final List<String>? readAccess;
  final int? archived;
  final String? externalLink;
  final List<MemberMediumContainerEntity>? memberMedia;

  PostEntity({this.authorId, this.timestamp, this.appId, this.feedId, this.postAppId, this.postPageId, this.pageParameters, this.html, this.description, this.likes, this.dislikes, this.accessibleByGroup, this.accessibleByMembers, this.readAccess, this.archived, this.externalLink, this.memberMedia, });

  PostEntity copyWith({Object? timestamp, }) {
    return PostEntity(authorId: authorId, timestamp : timestamp, appId: appId, feedId: feedId, postAppId: postAppId, postPageId: postPageId, pageParameters: pageParameters, html: html, description: description, likes: likes, dislikes: dislikes, accessibleByGroup: accessibleByGroup, accessibleByMembers: accessibleByMembers, readAccess: readAccess, archived: archived, externalLink: externalLink, memberMedia: memberMedia, );
  }
  List<Object?> get props => [authorId, timestamp, appId, feedId, postAppId, postPageId, pageParameters, html, description, likes, dislikes, accessibleByGroup, accessibleByMembers, readAccess, archived, externalLink, memberMedia, ];

  @override
  String toString() {
    String accessibleByMembersCsv = (accessibleByMembers == null) ? '' : accessibleByMembers!.join(', ');
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');
    String memberMediaCsv = (memberMedia == null) ? '' : memberMedia!.join(', ');

    return 'PostEntity{authorId: $authorId, timestamp: $timestamp, appId: $appId, feedId: $feedId, postAppId: $postAppId, postPageId: $postPageId, pageParameters: $pageParameters, html: $html, description: $description, likes: $likes, dislikes: $dislikes, accessibleByGroup: $accessibleByGroup, accessibleByMembers: String[] { $accessibleByMembersCsv }, readAccess: String[] { $readAccessCsv }, archived: $archived, externalLink: $externalLink, memberMedia: MemberMediumContainer[] { $memberMediaCsv }}';
  }

  static PostEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var pageParametersFromMap;
    pageParametersFromMap = map['pageParameters'];
    if (pageParametersFromMap != null)
      pageParametersFromMap = map['pageParameters'];
    var memberMediaFromMap;
    memberMediaFromMap = map['memberMedia'];
    var memberMediaList;
    if (memberMediaFromMap != null)
      memberMediaList = (map['memberMedia'] as List<dynamic>)
        .map((dynamic item) =>
        MemberMediumContainerEntity.fromMap(item as Map)!)
        .toList();

    return PostEntity(
      authorId: map['authorId'], 
      timestamp: map['timestamp'] == null ? null : (map['timestamp']  as Timestamp).millisecondsSinceEpoch,
      appId: map['appId'], 
      feedId: map['feedId'], 
      postAppId: map['postAppId'], 
      postPageId: map['postPageId'], 
      pageParameters: pageParametersFromMap, 
      html: map['html'], 
      description: map['description'], 
      likes: int.tryParse(map['likes'].toString()), 
      dislikes: int.tryParse(map['dislikes'].toString()), 
      accessibleByGroup: map['accessibleByGroup'], 
      accessibleByMembers: map['accessibleByMembers'] == null ? null : List.from(map['accessibleByMembers']), 
      readAccess: map['readAccess'] == null ? null : List.from(map['readAccess']), 
      archived: map['archived'], 
      externalLink: map['externalLink'], 
      memberMedia: memberMediaList, 
    );
  }

  Map<String, Object?> toDocument() {
    final List<Map<String?, dynamic>>? memberMediaListMap = memberMedia != null 
        ? memberMedia!.map((item) => item.toDocument()).toList()
        : null;

    Map<String, Object?> theDocument = HashMap();
    if (authorId != null) theDocument["authorId"] = authorId;
      else theDocument["authorId"] = null;
    theDocument["timestamp"] = timestamp;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (feedId != null) theDocument["feedId"] = feedId;
      else theDocument["feedId"] = null;
    if (postAppId != null) theDocument["postAppId"] = postAppId;
      else theDocument["postAppId"] = null;
    if (postPageId != null) theDocument["postPageId"] = postPageId;
      else theDocument["postPageId"] = null;
    theDocument['pageParameters'] = pageParameters;

    if (html != null) theDocument["html"] = html;
      else theDocument["html"] = null;
    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    if (likes != null) theDocument["likes"] = likes;
      else theDocument["likes"] = null;
    if (dislikes != null) theDocument["dislikes"] = dislikes;
      else theDocument["dislikes"] = null;
    if (accessibleByGroup != null) theDocument["accessibleByGroup"] = accessibleByGroup;
      else theDocument["accessibleByGroup"] = null;
    if (accessibleByMembers != null) theDocument["accessibleByMembers"] = accessibleByMembers!.toList();
      else theDocument["accessibleByMembers"] = null;
    if (readAccess != null) theDocument["readAccess"] = readAccess!.toList();
      else theDocument["readAccess"] = null;
    if (archived != null) theDocument["archived"] = archived;
      else theDocument["archived"] = null;
    if (externalLink != null) theDocument["externalLink"] = externalLink;
      else theDocument["externalLink"] = null;
    if (memberMedia != null) theDocument["memberMedia"] = memberMediaListMap;
      else theDocument["memberMedia"] = null;
    return theDocument;
  }

  static PostEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

