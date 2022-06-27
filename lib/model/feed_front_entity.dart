/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_front_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/entity_base.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_core/tools/common_tools.dart';
class FeedFrontEntity implements EntityBase {
  final String? appId;
  final String? description;
  final String? feedId;
  final BackgroundEntity? backgroundOverridePosts;
  final BackgroundEntity? backgroundOverrideProfile;
  final StorageConditionsEntity? conditions;

  FeedFrontEntity({required this.appId, this.description, this.feedId, this.backgroundOverridePosts, this.backgroundOverrideProfile, this.conditions, });


  List<Object?> get props => [appId, description, feedId, backgroundOverridePosts, backgroundOverrideProfile, conditions, ];

  @override
  String toString() {
    return 'FeedFrontEntity{appId: $appId, description: $description, feedId: $feedId, backgroundOverridePosts: $backgroundOverridePosts, backgroundOverrideProfile: $backgroundOverrideProfile, conditions: $conditions}';
  }

  static FeedFrontEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var backgroundOverridePostsFromMap;
    backgroundOverridePostsFromMap = map['backgroundOverridePosts'];
    if (backgroundOverridePostsFromMap != null)
      backgroundOverridePostsFromMap = BackgroundEntity.fromMap(backgroundOverridePostsFromMap);
    var backgroundOverrideProfileFromMap;
    backgroundOverrideProfileFromMap = map['backgroundOverrideProfile'];
    if (backgroundOverrideProfileFromMap != null)
      backgroundOverrideProfileFromMap = BackgroundEntity.fromMap(backgroundOverrideProfileFromMap);
    var conditionsFromMap;
    conditionsFromMap = map['conditions'];
    if (conditionsFromMap != null)
      conditionsFromMap = StorageConditionsEntity.fromMap(conditionsFromMap);

    return FeedFrontEntity(
      appId: map['appId'], 
      description: map['description'], 
      feedId: map['feedId'], 
      backgroundOverridePosts: backgroundOverridePostsFromMap, 
      backgroundOverrideProfile: backgroundOverrideProfileFromMap, 
      conditions: conditionsFromMap, 
    );
  }

  Map<String, Object?> toDocument() {
    final Map<String, dynamic>? backgroundOverridePostsMap = backgroundOverridePosts != null 
        ? backgroundOverridePosts!.toDocument()
        : null;
    final Map<String, dynamic>? backgroundOverrideProfileMap = backgroundOverrideProfile != null 
        ? backgroundOverrideProfile!.toDocument()
        : null;
    final Map<String, dynamic>? conditionsMap = conditions != null 
        ? conditions!.toDocument()
        : null;

    Map<String, Object?> theDocument = HashMap();
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    if (feedId != null) theDocument["feedId"] = feedId;
      else theDocument["feedId"] = null;
    if (backgroundOverridePosts != null) theDocument["backgroundOverridePosts"] = backgroundOverridePostsMap;
      else theDocument["backgroundOverridePosts"] = null;
    if (backgroundOverrideProfile != null) theDocument["backgroundOverrideProfile"] = backgroundOverrideProfileMap;
      else theDocument["backgroundOverrideProfile"] = null;
    if (conditions != null) theDocument["conditions"] = conditionsMap;
      else theDocument["conditions"] = null;
    return theDocument;
  }

  static FeedFrontEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

  Future<Map<String, Object?>> enrichedDocument(Map<String, Object?> theDocument) async {
    return theDocument;
  }

}

