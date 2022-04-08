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



class FeedMenuModel {
  String? documentID;

  // This is the identifier of the app to which this feed belongs
  String? appId;
  String? description;
  List<String>? bodyComponentsCurrentMemberLabels;
  List<BodyComponentModel>? bodyComponentsCurrentMember;
  List<String>? bodyComponentsOtherMemberLabels;
  List<BodyComponentModel>? bodyComponentsOtherMember;
  RgbModel? itemColor;
  RgbModel? selectedItemColor;
  FeedFrontModel? feedFront;
  StorageConditionsModel? conditions;

  FeedMenuModel({this.documentID, this.appId, this.description, this.bodyComponentsCurrentMemberLabels, this.bodyComponentsCurrentMember, this.bodyComponentsOtherMemberLabels, this.bodyComponentsOtherMember, this.itemColor, this.selectedItemColor, this.feedFront, this.conditions, })  {
    assert(documentID != null);
  }

  FeedMenuModel copyWith({String? documentID, String? appId, String? description, List<String>? bodyComponentsCurrentMemberLabels, List<BodyComponentModel>? bodyComponentsCurrentMember, List<String>? bodyComponentsOtherMemberLabels, List<BodyComponentModel>? bodyComponentsOtherMember, RgbModel? itemColor, RgbModel? selectedItemColor, FeedFrontModel? feedFront, StorageConditionsModel? conditions, }) {
    return FeedMenuModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, bodyComponentsCurrentMemberLabels: bodyComponentsCurrentMemberLabels ?? this.bodyComponentsCurrentMemberLabels, bodyComponentsCurrentMember: bodyComponentsCurrentMember ?? this.bodyComponentsCurrentMember, bodyComponentsOtherMemberLabels: bodyComponentsOtherMemberLabels ?? this.bodyComponentsOtherMemberLabels, bodyComponentsOtherMember: bodyComponentsOtherMember ?? this.bodyComponentsOtherMember, itemColor: itemColor ?? this.itemColor, selectedItemColor: selectedItemColor ?? this.selectedItemColor, feedFront: feedFront ?? this.feedFront, conditions: conditions ?? this.conditions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode ^ bodyComponentsCurrentMemberLabels.hashCode ^ bodyComponentsCurrentMember.hashCode ^ bodyComponentsOtherMemberLabels.hashCode ^ bodyComponentsOtherMember.hashCode ^ itemColor.hashCode ^ selectedItemColor.hashCode ^ feedFront.hashCode ^ conditions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is FeedMenuModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description &&
          ListEquality().equals(bodyComponentsCurrentMemberLabels, other.bodyComponentsCurrentMemberLabels) &&
          ListEquality().equals(bodyComponentsCurrentMember, other.bodyComponentsCurrentMember) &&
          ListEquality().equals(bodyComponentsOtherMemberLabels, other.bodyComponentsOtherMemberLabels) &&
          ListEquality().equals(bodyComponentsOtherMember, other.bodyComponentsOtherMember) &&
          itemColor == other.itemColor &&
          selectedItemColor == other.selectedItemColor &&
          feedFront == other.feedFront &&
          conditions == other.conditions;

  @override
  String toString() {
    String bodyComponentsCurrentMemberLabelsCsv = (bodyComponentsCurrentMemberLabels == null) ? '' : bodyComponentsCurrentMemberLabels!.join(', ');
    String bodyComponentsCurrentMemberCsv = (bodyComponentsCurrentMember == null) ? '' : bodyComponentsCurrentMember!.join(', ');
    String bodyComponentsOtherMemberLabelsCsv = (bodyComponentsOtherMemberLabels == null) ? '' : bodyComponentsOtherMemberLabels!.join(', ');
    String bodyComponentsOtherMemberCsv = (bodyComponentsOtherMember == null) ? '' : bodyComponentsOtherMember!.join(', ');

    return 'FeedMenuModel{documentID: $documentID, appId: $appId, description: $description, bodyComponentsCurrentMemberLabels: String[] { $bodyComponentsCurrentMemberLabelsCsv }, bodyComponentsCurrentMember: BodyComponent[] { $bodyComponentsCurrentMemberCsv }, bodyComponentsOtherMemberLabels: String[] { $bodyComponentsOtherMemberLabelsCsv }, bodyComponentsOtherMember: BodyComponent[] { $bodyComponentsOtherMemberCsv }, itemColor: $itemColor, selectedItemColor: $selectedItemColor, feedFront: $feedFront, conditions: $conditions}';
  }

  FeedMenuEntity toEntity({String? appId}) {
    return FeedMenuEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          bodyComponentsCurrentMemberLabels: (bodyComponentsCurrentMemberLabels != null) ? bodyComponentsCurrentMemberLabels : null, 
          bodyComponentsCurrentMember: (bodyComponentsCurrentMember != null) ? bodyComponentsCurrentMember
            !.map((item) => item.toEntity(appId: appId))
            .toList() : null, 
          bodyComponentsOtherMemberLabels: (bodyComponentsOtherMemberLabels != null) ? bodyComponentsOtherMemberLabels : null, 
          bodyComponentsOtherMember: (bodyComponentsOtherMember != null) ? bodyComponentsOtherMember
            !.map((item) => item.toEntity(appId: appId))
            .toList() : null, 
          itemColor: (itemColor != null) ? itemColor!.toEntity(appId: appId) : null, 
          selectedItemColor: (selectedItemColor != null) ? selectedItemColor!.toEntity(appId: appId) : null, 
          feedFrontId: (feedFront != null) ? feedFront!.documentID : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
    );
  }

  static Future<FeedMenuModel?> fromEntity(String documentID, FeedMenuEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return FeedMenuModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          bodyComponentsCurrentMemberLabels: entity.bodyComponentsCurrentMemberLabels, 
          bodyComponentsCurrentMember: 
            entity.bodyComponentsCurrentMember == null ? null : List<BodyComponentModel>.from(await Future.wait(entity. bodyComponentsCurrentMember
            !.map((item) {
            counter++;
              return BodyComponentModel.fromEntity(counter.toString(), item);
            })
            .toList())), 
          bodyComponentsOtherMemberLabels: entity.bodyComponentsOtherMemberLabels, 
          bodyComponentsOtherMember: 
            entity.bodyComponentsOtherMember == null ? null : List<BodyComponentModel>.from(await Future.wait(entity. bodyComponentsOtherMember
            !.map((item) {
            counter++;
              return BodyComponentModel.fromEntity(counter.toString(), item);
            })
            .toList())), 
          itemColor: 
            await RgbModel.fromEntity(entity.itemColor), 
          selectedItemColor: 
            await RgbModel.fromEntity(entity.selectedItemColor), 
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
          appId: entity.appId, 
          description: entity.description, 
          bodyComponentsCurrentMemberLabels: entity.bodyComponentsCurrentMemberLabels, 
          bodyComponentsCurrentMember: 
            entity. bodyComponentsCurrentMember == null ? null : List<BodyComponentModel>.from(await Future.wait(entity. bodyComponentsCurrentMember
            !.map((item) {
            counter++;
            return BodyComponentModel.fromEntityPlus(counter.toString(), item, appId: appId);})
            .toList())), 
          bodyComponentsOtherMemberLabels: entity.bodyComponentsOtherMemberLabels, 
          bodyComponentsOtherMember: 
            entity. bodyComponentsOtherMember == null ? null : List<BodyComponentModel>.from(await Future.wait(entity. bodyComponentsOtherMember
            !.map((item) {
            counter++;
            return BodyComponentModel.fromEntityPlus(counter.toString(), item, appId: appId);})
            .toList())), 
          itemColor: 
            await RgbModel.fromEntityPlus(entity.itemColor, appId: appId), 
          selectedItemColor: 
            await RgbModel.fromEntityPlus(entity.selectedItemColor, appId: appId), 
          feedFront: feedFrontHolder, 
          conditions: 
            await StorageConditionsModel.fromEntityPlus(entity.conditions, appId: appId), 
    );
  }

}

