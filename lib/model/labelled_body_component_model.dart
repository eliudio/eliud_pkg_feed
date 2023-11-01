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

import 'package:eliud_core/core/base/model_base.dart';

import 'package:eliud_pkg_feed/model/entity_export.dart';


import 'package:eliud_pkg_feed/model/labelled_body_component_entity.dart';




class LabelledBodyComponentModel implements ModelBase {
  static const String packageName = 'eliud_pkg_feed';
  static const String id = 'labelledBodyComponents';

  String documentID;

  // The label of the component
  String? label;

  // The component name, such as 'carousel' which is required on this body
  String? componentName;

  // For that specific component, e.g. 'carousel', which Component ID, i.e. which carousel to include in the page
  String? componentId;

  LabelledBodyComponentModel({required this.documentID, this.label, this.componentName, this.componentId, });

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
  String toString() {
    return 'LabelledBodyComponentModel{documentID: $documentID, label: $label, componentName: $componentName, componentId: $componentId}';
  }

  Future<List<ModelReference>> collectReferences({String? appId}) async {
    List<ModelReference> referencesCollector = [];
    return referencesCollector;
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

