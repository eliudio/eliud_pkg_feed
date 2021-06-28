/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

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


import 'package:eliud_pkg_feed/model/album_entity.dart';

import 'package:eliud_core/tools/random.dart';



class AlbumModel {
  String? documentID;

  // This is the identifier of the app to which this feed belongs
  String? appId;

  // This is the identifier of the post for which this album is dedicated
  PostModel? post;
  String? description;
  ConditionsSimpleModel? conditions;

  AlbumModel({this.documentID, this.appId, this.post, this.description, this.conditions, })  {
    assert(documentID != null);
  }

  AlbumModel copyWith({String? documentID, String? appId, PostModel? post, String? description, ConditionsSimpleModel? conditions, }) {
    return AlbumModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, post: post ?? this.post, description: description ?? this.description, conditions: conditions ?? this.conditions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ post.hashCode ^ description.hashCode ^ conditions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is AlbumModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          post == other.post &&
          description == other.description &&
          conditions == other.conditions;

  @override
  String toString() {
    return 'AlbumModel{documentID: $documentID, appId: $appId, post: $post, description: $description, conditions: $conditions}';
  }

  AlbumEntity toEntity({String? appId}) {
    return AlbumEntity(
          appId: (appId != null) ? appId : null, 
          postId: (post != null) ? post!.documentID : null, 
          description: (description != null) ? description : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
    );
  }

  static AlbumModel? fromEntity(String documentID, AlbumEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return AlbumModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          conditions: 
            ConditionsSimpleModel.fromEntity(entity.conditions), 
    );
  }

  static Future<AlbumModel?> fromEntityPlus(String documentID, AlbumEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    PostModel? postHolder;
    if (entity.postId != null) {
      try {
          postHolder = await postRepository(appId: appId)!.get(entity.postId);
      } on Exception catch(e) {
        print('Error whilst trying to initialise post');
        print('Error whilst retrieving post with id ${entity.postId}');
        print('Exception: $e');
      }
    }

    var counter = 0;
    return AlbumModel(
          documentID: documentID, 
          appId: entity.appId, 
          post: postHolder, 
          description: entity.description, 
          conditions: 
            await ConditionsSimpleModel.fromEntityPlus(entity.conditions, appId: appId), 
    );
  }

}

