/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_entity.dart
                       
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
class FeedMenuEntity {
  final String? appId;
  final String? description;
  final String? menuCurrentMemberId;
  final String? menuOtherMemberId;
  final RgbEntity? itemColor;
  final RgbEntity? selectedItemColor;
  final String? feedId;
  final ConditionsSimpleEntity? conditions;

  FeedMenuEntity({this.appId, this.description, this.menuCurrentMemberId, this.menuOtherMemberId, this.itemColor, this.selectedItemColor, this.feedId, this.conditions, });


  List<Object?> get props => [appId, description, menuCurrentMemberId, menuOtherMemberId, itemColor, selectedItemColor, feedId, conditions, ];

  @override
  String toString() {
    return 'FeedMenuEntity{appId: $appId, description: $description, menuCurrentMemberId: $menuCurrentMemberId, menuOtherMemberId: $menuOtherMemberId, itemColor: $itemColor, selectedItemColor: $selectedItemColor, feedId: $feedId, conditions: $conditions}';
  }

  static FeedMenuEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var itemColorFromMap;
    itemColorFromMap = map['itemColor'];
    if (itemColorFromMap != null)
      itemColorFromMap = RgbEntity.fromMap(itemColorFromMap);
    var selectedItemColorFromMap;
    selectedItemColorFromMap = map['selectedItemColor'];
    if (selectedItemColorFromMap != null)
      selectedItemColorFromMap = RgbEntity.fromMap(selectedItemColorFromMap);
    var conditionsFromMap;
    conditionsFromMap = map['conditions'];
    if (conditionsFromMap != null)
      conditionsFromMap = ConditionsSimpleEntity.fromMap(conditionsFromMap);

    return FeedMenuEntity(
      appId: map['appId'], 
      description: map['description'], 
      menuCurrentMemberId: map['menuCurrentMemberId'], 
      menuOtherMemberId: map['menuOtherMemberId'], 
      itemColor: itemColorFromMap, 
      selectedItemColor: selectedItemColorFromMap, 
      feedId: map['feedId'], 
      conditions: conditionsFromMap, 
    );
  }

  Map<String, Object?> toDocument() {
    final Map<String, dynamic>? itemColorMap = itemColor != null 
        ? itemColor!.toDocument()
        : null;
    final Map<String, dynamic>? selectedItemColorMap = selectedItemColor != null 
        ? selectedItemColor!.toDocument()
        : null;
    final Map<String, dynamic>? conditionsMap = conditions != null 
        ? conditions!.toDocument()
        : null;

    Map<String, Object?> theDocument = HashMap();
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    if (menuCurrentMemberId != null) theDocument["menuCurrentMemberId"] = menuCurrentMemberId;
      else theDocument["menuCurrentMemberId"] = null;
    if (menuOtherMemberId != null) theDocument["menuOtherMemberId"] = menuOtherMemberId;
      else theDocument["menuOtherMemberId"] = null;
    if (itemColor != null) theDocument["itemColor"] = itemColorMap;
      else theDocument["itemColor"] = null;
    if (selectedItemColor != null) theDocument["selectedItemColor"] = selectedItemColorMap;
      else theDocument["selectedItemColor"] = null;
    if (feedId != null) theDocument["feedId"] = feedId;
      else theDocument["feedId"] = null;
    if (conditions != null) theDocument["conditions"] = conditionsMap;
      else theDocument["conditions"] = null;
    return theDocument;
  }

  static FeedMenuEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

