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
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

class PostEntity {
  final String authorId;
  final Object timestamp;
  final String appId;
  final String postAppId;
  final String postPageId;
  final Map<String, Object> pageParameters;
  final String description;
  final int likes;
  final int dislikes;
  final List<String> readAccess;
  final int archived;

  PostEntity({this.authorId, this.timestamp, this.appId, this.postAppId, this.postPageId, this.pageParameters, this.description, this.likes, this.dislikes, this.readAccess, this.archived, });

  PostEntity copyWith({Object timestamp, }) {
    return PostEntity(authorId: authorId, timestamp : timestamp, appId: appId, postAppId: postAppId, postPageId: postPageId, pageParameters: pageParameters, description: description, likes: likes, dislikes: dislikes, readAccess: readAccess, archived: archived, );
  }
  List<Object> get props => [authorId, timestamp, appId, postAppId, postPageId, pageParameters, description, likes, dislikes, readAccess, archived, ];

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess.join(', ');

    return 'PostEntity{authorId: $authorId, timestamp: $timestamp, appId: $appId, postAppId: $postAppId, postPageId: $postPageId, pageParameters: $pageParameters, description: $description, likes: $likes, dislikes: $dislikes, readAccess: String[] { $readAccessCsv }, archived: $archived}';
  }

  static PostEntity fromMap(Map map) {
    if (map == null) return null;

    var pageParametersFromMap;
    pageParametersFromMap = map['pageParameters'];
    if (pageParametersFromMap != null)
      pageParametersFromMap = map['pageParameters'];
    return PostEntity(
      authorId: map['authorId'], 
      timestamp: postRepository().timeStampToString(map['timestamp']), 
      appId: map['appId'], 
      postAppId: map['postAppId'], 
      postPageId: map['postPageId'], 
      pageParameters: pageParametersFromMap, 
      description: map['description'], 
      likes: int.tryParse(map['likes'].toString()), 
      dislikes: int.tryParse(map['dislikes'].toString()), 
      readAccess: map['readAccess'] == null ? null : List.from(map['readAccess']), 
      archived: map['archived'], 
    );
  }

  Map<String, Object> toDocument() {
    Map<String, Object> theDocument = HashMap();
    if (authorId != null) theDocument["authorId"] = authorId;
      else theDocument["authorId"] = null;
    theDocument["timestamp"] = timestamp;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (postAppId != null) theDocument["postAppId"] = postAppId;
      else theDocument["postAppId"] = null;
    if (postPageId != null) theDocument["postPageId"] = postPageId;
      else theDocument["postPageId"] = null;
    theDocument['pageParameters'] = pageParameters;

    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    if (likes != null) theDocument["likes"] = likes;
      else theDocument["likes"] = null;
    if (dislikes != null) theDocument["dislikes"] = dislikes;
      else theDocument["dislikes"] = null;
    if (readAccess != null) theDocument["readAccess"] = readAccess.toList();
      else theDocument["readAccess"] = null;
    if (archived != null) theDocument["archived"] = archived;
      else theDocument["archived"] = null;
    return theDocument;
  }

  static PostEntity fromJsonString(String json) {
    Map<String, dynamic> generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

