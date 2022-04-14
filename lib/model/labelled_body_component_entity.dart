/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 labelled_body_component_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_core/tools/common_tools.dart';
class LabelledBodyComponentEntity {
  final String? label;
  final String? componentName;
  final String? componentId;

  LabelledBodyComponentEntity({this.label, this.componentName, this.componentId, });


  List<Object?> get props => [label, componentName, componentId, ];

  @override
  String toString() {
    return 'LabelledBodyComponentEntity{label: $label, componentName: $componentName, componentId: $componentId}';
  }

  static LabelledBodyComponentEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return LabelledBodyComponentEntity(
      label: map['label'], 
      componentName: map['componentName'], 
      componentId: map['componentId'], 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (label != null) theDocument["label"] = label;
      else theDocument["label"] = null;
    if (componentName != null) theDocument["componentName"] = componentName;
      else theDocument["componentName"] = null;
    if (componentId != null) theDocument["componentId"] = componentId;
      else theDocument["componentId"] = null;
    return theDocument;
  }

  static LabelledBodyComponentEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

