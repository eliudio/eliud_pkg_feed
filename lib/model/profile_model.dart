/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 profile_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/common_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/model_base.dart';

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


import 'package:eliud_pkg_feed/model/profile_entity.dart';

import 'package:eliud_core/tools/random.dart';



class ProfileModel implements ModelBase, WithAppId {
  String documentID;

  // This is the identifier of the app to which this feed belongs
  String appId;
  String? description;
  FeedModel? feed;
  BackgroundModel? backgroundOverride;
  StorageConditionsModel? conditions;

  ProfileModel({required this.documentID, required this.appId, this.description, this.feed, this.backgroundOverride, this.conditions, })  {
    assert(documentID != null);
  }

  ProfileModel copyWith({String? documentID, String? appId, String? description, FeedModel? feed, BackgroundModel? backgroundOverride, StorageConditionsModel? conditions, }) {
    return ProfileModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, feed: feed ?? this.feed, backgroundOverride: backgroundOverride ?? this.backgroundOverride, conditions: conditions ?? this.conditions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode ^ feed.hashCode ^ backgroundOverride.hashCode ^ conditions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is ProfileModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description &&
          feed == other.feed &&
          backgroundOverride == other.backgroundOverride &&
          conditions == other.conditions;

  String toJsonString({String? appId}) {
    return toEntity(appId: appId).toJsonString();
  }

  @override
  String toString() {
    return 'ProfileModel{documentID: $documentID, appId: $appId, description: $description, feed: $feed, backgroundOverride: $backgroundOverride, conditions: $conditions}';
  }

  ProfileEntity toEntity({String? appId}) {
    return ProfileEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          feedId: (feed != null) ? feed!.documentID : null, 
          backgroundOverride: (backgroundOverride != null) ? backgroundOverride!.toEntity(appId: appId) : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
    );
  }

  static Future<ProfileModel?> fromEntity(String documentID, ProfileEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return ProfileModel(
          documentID: documentID, 
          appId: entity.appId ?? '', 
          description: entity.description, 
          backgroundOverride: 
            await BackgroundModel.fromEntity(entity.backgroundOverride), 
          conditions: 
            await StorageConditionsModel.fromEntity(entity.conditions), 
    );
  }

  static Future<ProfileModel?> fromEntityPlus(String documentID, ProfileEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    FeedModel? feedHolder;
    if (entity.feedId != null) {
      try {
          feedHolder = await feedRepository(appId: appId)!.get(entity.feedId);
      } on Exception catch(e) {
        print('Error whilst trying to initialise feed');
        print('Error whilst retrieving feed with id ${entity.feedId}');
        print('Exception: $e');
      }
    }

    var counter = 0;
    return ProfileModel(
          documentID: documentID, 
          appId: entity.appId ?? '', 
          description: entity.description, 
          feed: feedHolder, 
          backgroundOverride: 
            await BackgroundModel.fromEntityPlus(entity.backgroundOverride, appId: appId), 
          conditions: 
            await StorageConditionsModel.fromEntityPlus(entity.conditions, appId: appId), 
    );
  }

}

