/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:collection/collection.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/model_base.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eliud_core/model/app_model.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


import 'package:eliud_pkg_feed/model/feed_menu_entity.dart';

import 'package:eliud_core/tools/random.dart';



class FeedMenuModel implements ModelBase, WithAppId {
  static const String packageName = 'eliud_pkg_feed';
  static const String id = 'feedMenus';

  String documentID;

  // This is the identifier of the app to which this feed belongs
  String appId;
  String? description;
  List<LabelledBodyComponentModel>? bodyComponentsCurrentMember;
  List<LabelledBodyComponentModel>? bodyComponentsOtherMember;
  RgbModel? itemColor;
  RgbModel? selectedItemColor;
  BackgroundModel? backgroundOverride;
  FeedFrontModel? feedFront;
  StorageConditionsModel? conditions;

  FeedMenuModel({required this.documentID, required this.appId, this.description, this.bodyComponentsCurrentMember, this.bodyComponentsOtherMember, this.itemColor, this.selectedItemColor, this.backgroundOverride, this.feedFront, this.conditions, })  {
    assert(documentID != null);
  }

  FeedMenuModel copyWith({String? documentID, String? appId, String? description, List<LabelledBodyComponentModel>? bodyComponentsCurrentMember, List<LabelledBodyComponentModel>? bodyComponentsOtherMember, RgbModel? itemColor, RgbModel? selectedItemColor, BackgroundModel? backgroundOverride, FeedFrontModel? feedFront, StorageConditionsModel? conditions, }) {
    return FeedMenuModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, bodyComponentsCurrentMember: bodyComponentsCurrentMember ?? this.bodyComponentsCurrentMember, bodyComponentsOtherMember: bodyComponentsOtherMember ?? this.bodyComponentsOtherMember, itemColor: itemColor ?? this.itemColor, selectedItemColor: selectedItemColor ?? this.selectedItemColor, backgroundOverride: backgroundOverride ?? this.backgroundOverride, feedFront: feedFront ?? this.feedFront, conditions: conditions ?? this.conditions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode ^ bodyComponentsCurrentMember.hashCode ^ bodyComponentsOtherMember.hashCode ^ itemColor.hashCode ^ selectedItemColor.hashCode ^ backgroundOverride.hashCode ^ feedFront.hashCode ^ conditions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is FeedMenuModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description &&
          ListEquality().equals(bodyComponentsCurrentMember, other.bodyComponentsCurrentMember) &&
          ListEquality().equals(bodyComponentsOtherMember, other.bodyComponentsOtherMember) &&
          itemColor == other.itemColor &&
          selectedItemColor == other.selectedItemColor &&
          backgroundOverride == other.backgroundOverride &&
          feedFront == other.feedFront &&
          conditions == other.conditions;

  @override
  String toString() {
    String bodyComponentsCurrentMemberCsv = (bodyComponentsCurrentMember == null) ? '' : bodyComponentsCurrentMember!.join(', ');
    String bodyComponentsOtherMemberCsv = (bodyComponentsOtherMember == null) ? '' : bodyComponentsOtherMember!.join(', ');

    return 'FeedMenuModel{documentID: $documentID, appId: $appId, description: $description, bodyComponentsCurrentMember: LabelledBodyComponent[] { $bodyComponentsCurrentMemberCsv }, bodyComponentsOtherMember: LabelledBodyComponent[] { $bodyComponentsOtherMemberCsv }, itemColor: $itemColor, selectedItemColor: $selectedItemColor, backgroundOverride: $backgroundOverride, feedFront: $feedFront, conditions: $conditions}';
  }

  FeedMenuEntity toEntity({String? appId, List<ModelReference>? referencesCollector}) {
    if (referencesCollector != null) {
      if (feedFront != null) referencesCollector.add(ModelReference(FeedFrontModel.packageName, FeedFrontModel.id, feedFront!));
    }
    return FeedMenuEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          bodyComponentsCurrentMember: (bodyComponentsCurrentMember != null) ? bodyComponentsCurrentMember
            !.map((item) => item.toEntity(appId: appId, referencesCollector: referencesCollector))
            .toList() : null, 
          bodyComponentsOtherMember: (bodyComponentsOtherMember != null) ? bodyComponentsOtherMember
            !.map((item) => item.toEntity(appId: appId, referencesCollector: referencesCollector))
            .toList() : null, 
          itemColor: (itemColor != null) ? itemColor!.toEntity(appId: appId, referencesCollector: referencesCollector) : null, 
          selectedItemColor: (selectedItemColor != null) ? selectedItemColor!.toEntity(appId: appId, referencesCollector: referencesCollector) : null, 
          backgroundOverride: (backgroundOverride != null) ? backgroundOverride!.toEntity(appId: appId, referencesCollector: referencesCollector) : null, 
          feedFrontId: (feedFront != null) ? feedFront!.documentID : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId, referencesCollector: referencesCollector) : null, 
    );
  }

  static Future<FeedMenuModel?> fromEntity(String documentID, FeedMenuEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return FeedMenuModel(
          documentID: documentID, 
          appId: entity.appId ?? '', 
          description: entity.description, 
          bodyComponentsCurrentMember: 
            entity.bodyComponentsCurrentMember == null ? null : List<LabelledBodyComponentModel>.from(await Future.wait(entity. bodyComponentsCurrentMember
            !.map((item) {
            counter++;
              return LabelledBodyComponentModel.fromEntity(counter.toString(), item);
            })
            .toList())), 
          bodyComponentsOtherMember: 
            entity.bodyComponentsOtherMember == null ? null : List<LabelledBodyComponentModel>.from(await Future.wait(entity. bodyComponentsOtherMember
            !.map((item) {
            counter++;
              return LabelledBodyComponentModel.fromEntity(counter.toString(), item);
            })
            .toList())), 
          itemColor: 
            await RgbModel.fromEntity(entity.itemColor), 
          selectedItemColor: 
            await RgbModel.fromEntity(entity.selectedItemColor), 
          backgroundOverride: 
            await BackgroundModel.fromEntity(entity.backgroundOverride), 
          conditions: 
            await StorageConditionsModel.fromEntity(entity.conditions), 
    );
  }

  static Future<FeedMenuModel?> fromEntityPlus(String documentID, FeedMenuEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    FeedFrontModel? feedFrontHolder;
    if (entity.feedFrontId != null) {
      try {
          feedFrontHolder = await feedFrontRepository(appId: appId)!.get(entity.feedFrontId);
      } on Exception catch(e) {
        print('Error whilst trying to initialise feedFront');
        print('Error whilst retrieving feedFront with id ${entity.feedFrontId}');
        print('Exception: $e');
      }
    }

    var counter = 0;
    return FeedMenuModel(
          documentID: documentID, 
          appId: entity.appId ?? '', 
          description: entity.description, 
          bodyComponentsCurrentMember: 
            entity. bodyComponentsCurrentMember == null ? null : List<LabelledBodyComponentModel>.from(await Future.wait(entity. bodyComponentsCurrentMember
            !.map((item) {
            counter++;
            return LabelledBodyComponentModel.fromEntityPlus(counter.toString(), item, appId: appId);})
            .toList())), 
          bodyComponentsOtherMember: 
            entity. bodyComponentsOtherMember == null ? null : List<LabelledBodyComponentModel>.from(await Future.wait(entity. bodyComponentsOtherMember
            !.map((item) {
            counter++;
            return LabelledBodyComponentModel.fromEntityPlus(counter.toString(), item, appId: appId);})
            .toList())), 
          itemColor: 
            await RgbModel.fromEntityPlus(entity.itemColor, appId: appId), 
          selectedItemColor: 
            await RgbModel.fromEntityPlus(entity.selectedItemColor, appId: appId), 
          backgroundOverride: 
            await BackgroundModel.fromEntityPlus(entity.backgroundOverride, appId: appId), 
          feedFront: feedFrontHolder, 
          conditions: 
            await StorageConditionsModel.fromEntityPlus(entity.conditions, appId: appId), 
    );
  }

}

