/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_medium_model.dart
                       
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


import 'package:eliud_pkg_feed/model/post_medium_entity.dart';

import 'package:eliud_core/tools/random.dart';



class PostMediumModel {
  String? documentID;
  MemberMediumModel? memberMedium;

  PostMediumModel({this.documentID, this.memberMedium, })  {
    assert(documentID != null);
  }

  PostMediumModel copyWith({String? documentID, MemberMediumModel? memberMedium, }) {
    return PostMediumModel(documentID: documentID ?? this.documentID, memberMedium: memberMedium ?? this.memberMedium, );
  }

  @override
  int get hashCode => documentID.hashCode ^ memberMedium.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is PostMediumModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          memberMedium == other.memberMedium;

  @override
  String toString() {
    return 'PostMediumModel{documentID: $documentID, memberMedium: $memberMedium}';
  }

  PostMediumEntity toEntity({String? appId}) {
    return PostMediumEntity(
          memberMediumId: (memberMedium != null) ? memberMedium!.documentID : null, 
    );
  }

  static PostMediumModel? fromEntity(String documentID, PostMediumEntity? entity) {
    if (entity == null) return null;
    return PostMediumModel(
          documentID: documentID, 
    );
  }

  static Future<PostMediumModel?> fromEntityPlus(String documentID, PostMediumEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    MemberMediumModel? memberMediumHolder;
    if (entity.memberMediumId != null) {
      try {
          memberMediumHolder = await memberMediumRepository(appId: appId)!.get(entity.memberMediumId);
      } on Exception catch(e) {
        print('Error whilst trying to initialise memberMedium');
        print('Error whilst retrieving memberMedium with id ${entity.memberMediumId}');
        print('Exception: $e');
      }
    }

    return PostMediumModel(
          documentID: documentID, 
          memberMedium: memberMediumHolder, 
    );
  }

}

