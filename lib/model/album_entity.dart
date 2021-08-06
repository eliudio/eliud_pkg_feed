/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_entity.dart
                       
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
class AlbumEntity {
  final String? appId;
  final String? postId;
  final String? description;
  final ConditionsSimpleEntity? conditions;

  AlbumEntity({this.appId, this.postId, this.description, this.conditions, });


  List<Object?> get props => [appId, postId, description, conditions, ];

  @override
  String toString() {
    return 'AlbumEntity{appId: $appId, postId: $postId, description: $description, conditions: $conditions}';
  }

  static AlbumEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var conditionsFromMap;
    conditionsFromMap = map['conditions'];
    if (conditionsFromMap != null)
      conditionsFromMap = ConditionsSimpleEntity.fromMap(conditionsFromMap);

    return AlbumEntity(
      appId: map['appId'], 
      postId: map['postId'], 
      description: map['description'], 
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
    if (postId != null) theDocument["postId"] = postId;
      else theDocument["postId"] = null;
    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    if (conditions != null) theDocument["conditions"] = conditionsMap;
      else theDocument["conditions"] = null;
    return theDocument;
  }

  static AlbumEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

