/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/global_data.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_core/tools/action_entity.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


import 'package:eliud_pkg_feed/model/feed_entity.dart';

import 'package:eliud_core/tools/random.dart';



class FeedModel {
  String documentID;

  // This is the identifier of the app to which this feed belongs
  String appId;
  String description;

  FeedModel({this.documentID, this.appId, this.description, })  {
    assert(documentID != null);
  }

  FeedModel copyWith({String documentID, String appId, String description, }) {
    return FeedModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is FeedModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description;

  @override
  String toString() {
    return 'FeedModel{documentID: $documentID, appId: $appId, description: $description}';
  }

  FeedEntity toEntity({String appId}) {
    return FeedEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
    );
  }

  static FeedModel fromEntity(String documentID, FeedEntity entity) {
    if (entity == null) return null;
    return FeedModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
    );
  }

  static Future<FeedModel> fromEntityPlus(String documentID, FeedEntity entity, { String appId}) async {
    if (entity == null) return null;

    return FeedModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
    );
  }

}

