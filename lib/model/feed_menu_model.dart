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
  MenuDefModel? menuCurrentMember;
  MenuDefModel? menuOtherMember;
  RgbModel? itemColor;
  RgbModel? selectedItemColor;
  ConditionsSimpleModel? conditions;

  FeedMenuModel({this.documentID, this.appId, this.description, this.menuCurrentMember, this.menuOtherMember, this.itemColor, this.selectedItemColor, this.conditions, })  {
    assert(documentID != null);
  }

  FeedMenuModel copyWith({String? documentID, String? appId, String? description, MenuDefModel? menuCurrentMember, MenuDefModel? menuOtherMember, RgbModel? itemColor, RgbModel? selectedItemColor, ConditionsSimpleModel? conditions, }) {
    return FeedMenuModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, menuCurrentMember: menuCurrentMember ?? this.menuCurrentMember, menuOtherMember: menuOtherMember ?? this.menuOtherMember, itemColor: itemColor ?? this.itemColor, selectedItemColor: selectedItemColor ?? this.selectedItemColor, conditions: conditions ?? this.conditions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode ^ menuCurrentMember.hashCode ^ menuOtherMember.hashCode ^ itemColor.hashCode ^ selectedItemColor.hashCode ^ conditions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is FeedMenuModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description &&
          menuCurrentMember == other.menuCurrentMember &&
          menuOtherMember == other.menuOtherMember &&
          itemColor == other.itemColor &&
          selectedItemColor == other.selectedItemColor &&
          conditions == other.conditions;

  @override
  String toString() {
    return 'FeedMenuModel{documentID: $documentID, appId: $appId, description: $description, menuCurrentMember: $menuCurrentMember, menuOtherMember: $menuOtherMember, itemColor: $itemColor, selectedItemColor: $selectedItemColor, conditions: $conditions}';
  }

  FeedMenuEntity toEntity({String? appId}) {
    return FeedMenuEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          menuCurrentMemberId: (menuCurrentMember != null) ? menuCurrentMember!.documentID : null, 
          menuOtherMemberId: (menuOtherMember != null) ? menuOtherMember!.documentID : null, 
          itemColor: (itemColor != null) ? itemColor!.toEntity(appId: appId) : null, 
          selectedItemColor: (selectedItemColor != null) ? selectedItemColor!.toEntity(appId: appId) : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
    );
  }

  static FeedMenuModel? fromEntity(String documentID, FeedMenuEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return FeedMenuModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          itemColor: 
            RgbModel.fromEntity(entity.itemColor), 
          selectedItemColor: 
            RgbModel.fromEntity(entity.selectedItemColor), 
          conditions: 
            ConditionsSimpleModel.fromEntity(entity.conditions), 
    );
  }

  static Future<FeedMenuModel?> fromEntityPlus(String documentID, FeedMenuEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    MenuDefModel? menuCurrentMemberHolder;
    if (entity.menuCurrentMemberId != null) {
      try {
          menuCurrentMemberHolder = await menuDefRepository(appId: appId)!.get(entity.menuCurrentMemberId);
      } on Exception catch(e) {
        print('Error whilst trying to initialise menuCurrentMember');
        print('Error whilst retrieving menuDef with id ${entity.menuCurrentMemberId}');
        print('Exception: $e');
      }
    }

    MenuDefModel? menuOtherMemberHolder;
    if (entity.menuOtherMemberId != null) {
      try {
          menuOtherMemberHolder = await menuDefRepository(appId: appId)!.get(entity.menuOtherMemberId);
      } on Exception catch(e) {
        print('Error whilst trying to initialise menuOtherMember');
        print('Error whilst retrieving menuDef with id ${entity.menuOtherMemberId}');
        print('Exception: $e');
      }
    }

    var counter = 0;
    return FeedMenuModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          menuCurrentMember: menuCurrentMemberHolder, 
          menuOtherMember: menuOtherMemberHolder, 
          itemColor: 
            await RgbModel.fromEntityPlus(entity.itemColor, appId: appId), 
          selectedItemColor: 
            await RgbModel.fromEntityPlus(entity.selectedItemColor, appId: appId), 
          conditions: 
            await ConditionsSimpleModel.fromEntityPlus(entity.conditions, appId: appId), 
    );
  }

}

