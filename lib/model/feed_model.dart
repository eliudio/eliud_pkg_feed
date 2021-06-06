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


import 'package:eliud_pkg_feed/model/feed_entity.dart';

import 'package:eliud_core/tools/random.dart';

enum ThumbStyle {
  Thumbs, Banana, Unknown
}


ThumbStyle toThumbStyle(int? index) {
  switch (index) {
    case 0: return ThumbStyle.Thumbs;
    case 1: return ThumbStyle.Banana;
  }
  return ThumbStyle.Unknown;
}


class FeedModel {
  String? documentID;

  // This is the identifier of the app to which this feed belongs
  String? appId;
  String? description;
  ThumbStyle? thumbImage;
  ConditionsSimpleModel? conditions;

  FeedModel({this.documentID, this.appId, this.description, this.thumbImage, this.conditions, })  {
    assert(documentID != null);
  }

  FeedModel copyWith({String? documentID, String? appId, String? description, ThumbStyle? thumbImage, ConditionsSimpleModel? conditions, }) {
    return FeedModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, thumbImage: thumbImage ?? this.thumbImage, conditions: conditions ?? this.conditions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode ^ thumbImage.hashCode ^ conditions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is FeedModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description &&
          thumbImage == other.thumbImage &&
          conditions == other.conditions;

  @override
  String toString() {
    return 'FeedModel{documentID: $documentID, appId: $appId, description: $description, thumbImage: $thumbImage, conditions: $conditions}';
  }

  FeedEntity toEntity({String? appId}) {
    return FeedEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          thumbImage: (thumbImage != null) ? thumbImage!.index : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
    );
  }

  static FeedModel? fromEntity(String documentID, FeedEntity? entity) {
    if (entity == null) return null;
    return FeedModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          thumbImage: toThumbStyle(entity.thumbImage), 
          conditions: 
            ConditionsSimpleModel.fromEntity(entity.conditions), 
    );
  }

  static Future<FeedModel?> fromEntityPlus(String documentID, FeedEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    return FeedModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          thumbImage: toThumbStyle(entity.thumbImage), 
          conditions: 
            await ConditionsSimpleModel.fromEntityPlus(entity.conditions, appId: appId), 
    );
  }

}

