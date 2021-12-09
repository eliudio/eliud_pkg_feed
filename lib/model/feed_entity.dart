/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_core/tools/common_tools.dart';
class FeedEntity {
  final String? appId;
  final String? description;
  final int? thumbImage;
  final bool? photoPost;
  final bool? videoPost;
  final bool? messagePost;
  final bool? audioPost;
  final bool? albumPost;
  final bool? articlePost;
  final StorageConditionsEntity? conditions;

  FeedEntity({this.appId, this.description, this.thumbImage, this.photoPost, this.videoPost, this.messagePost, this.audioPost, this.albumPost, this.articlePost, this.conditions, });


  List<Object?> get props => [appId, description, thumbImage, photoPost, videoPost, messagePost, audioPost, albumPost, articlePost, conditions, ];

  @override
  String toString() {
    return 'FeedEntity{appId: $appId, description: $description, thumbImage: $thumbImage, photoPost: $photoPost, videoPost: $videoPost, messagePost: $messagePost, audioPost: $audioPost, albumPost: $albumPost, articlePost: $articlePost, conditions: $conditions}';
  }

  static FeedEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var conditionsFromMap;
    conditionsFromMap = map['conditions'];
    if (conditionsFromMap != null)
      conditionsFromMap = StorageConditionsEntity.fromMap(conditionsFromMap);

    return FeedEntity(
      appId: map['appId'], 
      description: map['description'], 
      thumbImage: map['thumbImage'], 
      photoPost: map['photoPost'], 
      videoPost: map['videoPost'], 
      messagePost: map['messagePost'], 
      audioPost: map['audioPost'], 
      albumPost: map['albumPost'], 
      articlePost: map['articlePost'], 
      conditions: conditionsFromMap, 
    );
  }

  Map<String, Object?> toDocument() {
    final Map<String, dynamic>? conditionsMap = conditions != null 
        ? conditions!.toDocument()
        : null;

    Map<String, Object?> theDocument = HashMap();
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    if (thumbImage != null) theDocument["thumbImage"] = thumbImage;
      else theDocument["thumbImage"] = null;
    if (photoPost != null) theDocument["photoPost"] = photoPost;
      else theDocument["photoPost"] = null;
    if (videoPost != null) theDocument["videoPost"] = videoPost;
      else theDocument["videoPost"] = null;
    if (messagePost != null) theDocument["messagePost"] = messagePost;
      else theDocument["messagePost"] = null;
    if (audioPost != null) theDocument["audioPost"] = audioPost;
      else theDocument["audioPost"] = null;
    if (albumPost != null) theDocument["albumPost"] = albumPost;
      else theDocument["albumPost"] = null;
    if (articlePost != null) theDocument["articlePost"] = articlePost;
      else theDocument["articlePost"] = null;
    if (conditions != null) theDocument["conditions"] = conditionsMap;
      else theDocument["conditions"] = null;
    return theDocument;
  }

  static FeedEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

