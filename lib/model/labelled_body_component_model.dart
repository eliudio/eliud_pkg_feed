/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 labelled_body_component_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/common_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/model_base.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


import 'package:eliud_pkg_feed/model/labelled_body_component_entity.dart';

import 'package:eliud_core/tools/random.dart';



class LabelledBodyComponentModel implements ModelBase {
  String documentID;

  // The label of the component
  String? label;

  // The component name, such as 'carousel' which is required on this body
  String? componentName;

  // For that specific component, e.g. 'carousel', which Component ID, i.e. which carousel to include in the page
  String? componentId;

  LabelledBodyComponentModel({required this.documentID, this.label, this.componentName, this.componentId, })  {
    assert(documentID != null);
  }

  LabelledBodyComponentModel copyWith({String? documentID, String? label, String? componentName, String? componentId, }) {
    return LabelledBodyComponentModel(documentID: documentID ?? this.documentID, label: label ?? this.label, componentName: componentName ?? this.componentName, componentId: componentId ?? this.componentId, );
  }

  @override
  int get hashCode => documentID.hashCode ^ label.hashCode ^ componentName.hashCode ^ componentId.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is LabelledBodyComponentModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          label == other.label &&
          componentName == other.componentName &&
          componentId == other.componentId;

  @override
  Future<String> toRichJsonString({String? appId}) async {
    var document = toEntity(appId: appId).toDocument();
    document['documentID'] = documentID;
    return jsonEncode(document);
  }

  @override
  String toString() {
    return 'LabelledBodyComponentModel{documentID: $documentID, label: $label, componentName: $componentName, componentId: $componentId}';
  }

  LabelledBodyComponentEntity toEntity({String? appId}) {
    return LabelledBodyComponentEntity(
          label: (label != null) ? label : null, 
          componentName: (componentName != null) ? componentName : null, 
          componentId: (componentId != null) ? componentId : null, 
    );
  }

  static Future<LabelledBodyComponentModel?> fromEntity(String documentID, LabelledBodyComponentEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return LabelledBodyComponentModel(
          documentID: documentID, 
          label: entity.label, 
          componentName: entity.componentName, 
          componentId: entity.componentId, 
    );
  }

  static Future<LabelledBodyComponentModel?> fromEntityPlus(String documentID, LabelledBodyComponentEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return LabelledBodyComponentModel(
          documentID: documentID, 
          label: entity.label, 
          componentName: entity.componentName, 
          componentId: entity.componentId, 
    );
  }

}

