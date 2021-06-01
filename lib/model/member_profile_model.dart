/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_profile_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:collection/collection.dart';
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


import 'package:eliud_pkg_feed/model/member_profile_entity.dart';

import 'package:eliud_core/tools/random.dart';



class MemberProfileModel {
  String? documentID;
  String? appId;
  MemberMediumModel? profileBackground;
  MemberMediumModel? profileOverride;
  List<String>? readAccess;

  MemberProfileModel({this.documentID, this.appId, this.profileBackground, this.profileOverride, this.readAccess, })  {
    assert(documentID != null);
  }

  MemberProfileModel copyWith({String? documentID, String? appId, MemberMediumModel? profileBackground, MemberMediumModel? profileOverride, List<String>? readAccess, }) {
    return MemberProfileModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, profileBackground: profileBackground ?? this.profileBackground, profileOverride: profileOverride ?? this.profileOverride, readAccess: readAccess ?? this.readAccess, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ profileBackground.hashCode ^ profileOverride.hashCode ^ readAccess.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is MemberProfileModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          profileBackground == other.profileBackground &&
          profileOverride == other.profileOverride &&
          ListEquality().equals(readAccess, other.readAccess);

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'MemberProfileModel{documentID: $documentID, appId: $appId, profileBackground: $profileBackground, profileOverride: $profileOverride, readAccess: String[] { $readAccessCsv }}';
  }

  MemberProfileEntity toEntity({String? appId}) {
    return MemberProfileEntity(
          appId: (appId != null) ? appId : null, 
          profileBackgroundId: (profileBackground != null) ? profileBackground!.documentID : null, 
          profileOverrideId: (profileOverride != null) ? profileOverride!.documentID : null, 
          readAccess: (readAccess != null) ? readAccess : null, 
    );
  }

  static MemberProfileModel? fromEntity(String documentID, MemberProfileEntity? entity) {
    if (entity == null) return null;
    return MemberProfileModel(
          documentID: documentID, 
          appId: entity.appId, 
          readAccess: entity.readAccess, 
    );
  }

  static Future<MemberProfileModel?> fromEntityPlus(String documentID, MemberProfileEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    MemberMediumModel? profileBackgroundHolder;
    if (entity.profileBackgroundId != null) {
      try {
          profileBackgroundHolder = await memberMediumRepository(appId: appId)!.get(entity.profileBackgroundId);
      } on Exception catch(e) {
        print('Error whilst trying to initialise profileBackground');
        print('Error whilst retrieving memberMedium with id ${entity.profileBackgroundId}');
        print('Exception: $e');
      }
    }

    MemberMediumModel? profileOverrideHolder;
    if (entity.profileOverrideId != null) {
      try {
          profileOverrideHolder = await memberMediumRepository(appId: appId)!.get(entity.profileOverrideId);
      } on Exception catch(e) {
        print('Error whilst trying to initialise profileOverride');
        print('Error whilst retrieving memberMedium with id ${entity.profileOverrideId}');
        print('Exception: $e');
      }
    }

    return MemberProfileModel(
          documentID: documentID, 
          appId: entity.appId, 
          profileBackground: profileBackgroundHolder, 
          profileOverride: profileOverrideHolder, 
          readAccess: entity.readAccess, 
    );
  }

}

