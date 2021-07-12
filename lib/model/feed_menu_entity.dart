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
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

class FeedMenuEntity {
  final String? appId;
  final String? description;
  final String? menuId;
  final RgbEntity? itemColor;
  final RgbEntity? selectedItemColor;
  final ConditionsSimpleEntity? conditions;

  FeedMenuEntity({this.appId, this.description, this.menuId, this.itemColor, this.selectedItemColor, this.conditions, });


  List<Object?> get props => [appId, description, menuId, itemColor, selectedItemColor, conditions, ];

  @override
  String toString() {
    return 'FeedMenuEntity{appId: $appId, description: $description, menuId: $menuId, itemColor: $itemColor, selectedItemColor: $selectedItemColor, conditions: $conditions}';
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
      menuId: map['menuId'], 
      itemColor: itemColorFromMap, 
      selectedItemColor: selectedItemColorFromMap, 
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
    if (menuId != null) theDocument["menuId"] = menuId;
      else theDocument["menuId"] = null;
    if (itemColor != null) theDocument["itemColor"] = itemColorMap;
      else theDocument["itemColor"] = null;
    if (selectedItemColor != null) theDocument["selectedItemColor"] = selectedItemColorMap;
      else theDocument["selectedItemColor"] = null;
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

