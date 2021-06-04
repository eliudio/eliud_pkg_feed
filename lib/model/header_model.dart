/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/global_data.dart';
import 'package:eliud_core/tools/common_tools.dart';

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


import 'package:eliud_pkg_feed/model/header_entity.dart';

import 'package:eliud_core/tools/random.dart';



class HeaderModel {
  String? documentID;

  // This is the identifier of the app to which this feed belongs
  String? appId;
  String? description;
  FeedModel? feed;
  ConditionsSimpleModel? conditions;

  HeaderModel({this.documentID, this.appId, this.description, this.feed, this.conditions, })  {
    assert(documentID != null);
  }

  HeaderModel copyWith({String? documentID, String? appId, String? description, FeedModel? feed, ConditionsSimpleModel? conditions, }) {
    return HeaderModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, feed: feed ?? this.feed, conditions: conditions ?? this.conditions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode ^ feed.hashCode ^ conditions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is HeaderModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description &&
          feed == other.feed &&
          conditions == other.conditions;

  @override
  String toString() {
    return 'HeaderModel{documentID: $documentID, appId: $appId, description: $description, feed: $feed, conditions: $conditions}';
  }

  HeaderEntity toEntity({String? appId}) {
    return HeaderEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          feedId: (feed != null) ? feed!.documentID : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
    );
  }

  static HeaderModel? fromEntity(String documentID, HeaderEntity? entity) {
    if (entity == null) return null;
    return HeaderModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          conditions: 
            ConditionsSimpleModel.fromEntity(entity.conditions), 
    );
  }

  static Future<HeaderModel?> fromEntityPlus(String documentID, HeaderEntity? entity, { String? appId}) async {
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

    return HeaderModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          feed: feedHolder, 
          conditions: 
            await ConditionsSimpleModel.fromEntityPlus(entity.conditions, appId: appId), 
    );
  }

}

