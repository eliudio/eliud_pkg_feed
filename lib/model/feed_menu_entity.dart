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
  final List<LabelledBodyComponentEntity>? bodyComponentsCurrentMember;
  final List<LabelledBodyComponentEntity>? bodyComponentsOtherMember;
  final RgbEntity? itemColor;
  final RgbEntity? selectedItemColor;
  final BackgroundEntity? backgroundOverride;
  final String? feedFrontId;
  final StorageConditionsEntity? conditions;

  FeedMenuEntity({required this.appId, this.description, this.bodyComponentsCurrentMember, this.bodyComponentsOtherMember, this.itemColor, this.selectedItemColor, this.backgroundOverride, this.feedFrontId, this.conditions, });


  List<Object?> get props => [appId, description, bodyComponentsCurrentMember, bodyComponentsOtherMember, itemColor, selectedItemColor, backgroundOverride, feedFrontId, conditions, ];

  @override
  String toString() {
    String bodyComponentsCurrentMemberCsv = (bodyComponentsCurrentMember == null) ? '' : bodyComponentsCurrentMember!.join(', ');
    String bodyComponentsOtherMemberCsv = (bodyComponentsOtherMember == null) ? '' : bodyComponentsOtherMember!.join(', ');

    return 'FeedMenuEntity{appId: $appId, description: $description, bodyComponentsCurrentMember: LabelledBodyComponent[] { $bodyComponentsCurrentMemberCsv }, bodyComponentsOtherMember: LabelledBodyComponent[] { $bodyComponentsOtherMemberCsv }, itemColor: $itemColor, selectedItemColor: $selectedItemColor, backgroundOverride: $backgroundOverride, feedFrontId: $feedFrontId, conditions: $conditions}';
  }

  static FeedMenuEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var bodyComponentsCurrentMemberFromMap;
    bodyComponentsCurrentMemberFromMap = map['bodyComponentsCurrentMember'];
    var bodyComponentsCurrentMemberList;
    if (bodyComponentsCurrentMemberFromMap != null)
      bodyComponentsCurrentMemberList = (map['bodyComponentsCurrentMember'] as List<dynamic>)
        .map((dynamic item) =>
        LabelledBodyComponentEntity.fromMap(item as Map)!)
        .toList();
    var bodyComponentsOtherMemberFromMap;
    bodyComponentsOtherMemberFromMap = map['bodyComponentsOtherMember'];
    var bodyComponentsOtherMemberList;
    if (bodyComponentsOtherMemberFromMap != null)
      bodyComponentsOtherMemberList = (map['bodyComponentsOtherMember'] as List<dynamic>)
        .map((dynamic item) =>
        LabelledBodyComponentEntity.fromMap(item as Map)!)
        .toList();
    var itemColorFromMap;
    itemColorFromMap = map['itemColor'];
    if (itemColorFromMap != null)
      itemColorFromMap = RgbEntity.fromMap(itemColorFromMap);
    var selectedItemColorFromMap;
    selectedItemColorFromMap = map['selectedItemColor'];
    if (selectedItemColorFromMap != null)
      selectedItemColorFromMap = RgbEntity.fromMap(selectedItemColorFromMap);
    var backgroundOverrideFromMap;
    backgroundOverrideFromMap = map['backgroundOverride'];
    if (backgroundOverrideFromMap != null)
      backgroundOverrideFromMap = BackgroundEntity.fromMap(backgroundOverrideFromMap);
    var conditionsFromMap;
    conditionsFromMap = map['conditions'];
    if (conditionsFromMap != null)
      conditionsFromMap = StorageConditionsEntity.fromMap(conditionsFromMap);

    return FeedMenuEntity(
      appId: map['appId'], 
      description: map['description'], 
      bodyComponentsCurrentMember: bodyComponentsCurrentMemberList, 
      bodyComponentsOtherMember: bodyComponentsOtherMemberList, 
      itemColor: itemColorFromMap, 
      selectedItemColor: selectedItemColorFromMap, 
      backgroundOverride: backgroundOverrideFromMap, 
      feedFrontId: map['feedFrontId'], 
      conditions: conditionsFromMap, 
    );
  }

  Map<String, Object?> toDocument() {
    final List<Map<String?, dynamic>>? bodyComponentsCurrentMemberListMap = bodyComponentsCurrentMember != null 
        ? bodyComponentsCurrentMember!.map((item) => item.toDocument()).toList()
        : null;
    final List<Map<String?, dynamic>>? bodyComponentsOtherMemberListMap = bodyComponentsOtherMember != null 
        ? bodyComponentsOtherMember!.map((item) => item.toDocument()).toList()
        : null;
    final Map<String, dynamic>? itemColorMap = itemColor != null 
        ? itemColor!.toDocument()
        : null;
    final Map<String, dynamic>? selectedItemColorMap = selectedItemColor != null 
        ? selectedItemColor!.toDocument()
        : null;
    final Map<String, dynamic>? backgroundOverrideMap = backgroundOverride != null 
        ? backgroundOverride!.toDocument()
        : null;
    final Map<String, dynamic>? conditionsMap = conditions != null 
        ? conditions!.toDocument()
        : null;

    Map<String, Object?> theDocument = HashMap();
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    if (bodyComponentsCurrentMember != null) theDocument["bodyComponentsCurrentMember"] = bodyComponentsCurrentMemberListMap;
      else theDocument["bodyComponentsCurrentMember"] = null;
    if (bodyComponentsOtherMember != null) theDocument["bodyComponentsOtherMember"] = bodyComponentsOtherMemberListMap;
      else theDocument["bodyComponentsOtherMember"] = null;
    if (itemColor != null) theDocument["itemColor"] = itemColorMap;
      else theDocument["itemColor"] = null;
    if (selectedItemColor != null) theDocument["selectedItemColor"] = selectedItemColorMap;
      else theDocument["selectedItemColor"] = null;
    if (backgroundOverride != null) theDocument["backgroundOverride"] = backgroundOverrideMap;
      else theDocument["backgroundOverride"] = null;
    if (feedFrontId != null) theDocument["feedFrontId"] = feedFrontId;
      else theDocument["feedFrontId"] = null;
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

