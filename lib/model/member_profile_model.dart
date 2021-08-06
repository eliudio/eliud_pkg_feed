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


import 'package:eliud_pkg_feed/model/member_profile_entity.dart';

import 'package:eliud_core/tools/random.dart';



class MemberProfileModel {
  String? documentID;
  String? appId;

  // This is the identifier of the feed
  String? feedId;
  String? authorId;
  String? profile;
  MemberMediumModel? profileBackground;
  String? profileOverride;
  String? nameOverride;
  List<String>? readAccess;

  MemberProfileModel({this.documentID, this.appId, this.feedId, this.authorId, this.profile, this.profileBackground, this.profileOverride, this.nameOverride, this.readAccess, })  {
    assert(documentID != null);
  }

  MemberProfileModel copyWith({String? documentID, String? appId, String? feedId, String? authorId, String? profile, MemberMediumModel? profileBackground, String? profileOverride, String? nameOverride, List<String>? readAccess, }) {
    return MemberProfileModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, feedId: feedId ?? this.feedId, authorId: authorId ?? this.authorId, profile: profile ?? this.profile, profileBackground: profileBackground ?? this.profileBackground, profileOverride: profileOverride ?? this.profileOverride, nameOverride: nameOverride ?? this.nameOverride, readAccess: readAccess ?? this.readAccess, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ feedId.hashCode ^ authorId.hashCode ^ profile.hashCode ^ profileBackground.hashCode ^ profileOverride.hashCode ^ nameOverride.hashCode ^ readAccess.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is MemberProfileModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          feedId == other.feedId &&
          authorId == other.authorId &&
          profile == other.profile &&
          profileBackground == other.profileBackground &&
          profileOverride == other.profileOverride &&
          nameOverride == other.nameOverride &&
          ListEquality().equals(readAccess, other.readAccess);

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'MemberProfileModel{documentID: $documentID, appId: $appId, feedId: $feedId, authorId: $authorId, profile: $profile, profileBackground: $profileBackground, profileOverride: $profileOverride, nameOverride: $nameOverride, readAccess: String[] { $readAccessCsv }}';
  }

  MemberProfileEntity toEntity({String? appId}) {
    return MemberProfileEntity(
          appId: (appId != null) ? appId : null, 
          feedId: (feedId != null) ? feedId : null, 
          authorId: (authorId != null) ? authorId : null, 
          profile: (profile != null) ? profile : null, 
          profileBackgroundId: (profileBackground != null) ? profileBackground!.documentID : null, 
          profileOverride: (profileOverride != null) ? profileOverride : null, 
          nameOverride: (nameOverride != null) ? nameOverride : null, 
          readAccess: (readAccess != null) ? readAccess : null, 
    );
  }

  static MemberProfileModel? fromEntity(String documentID, MemberProfileEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return MemberProfileModel(
          documentID: documentID, 
          appId: entity.appId, 
          feedId: entity.feedId, 
          authorId: entity.authorId, 
          profile: entity.profile, 
          profileOverride: entity.profileOverride, 
          nameOverride: entity.nameOverride, 
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

    var counter = 0;
    return MemberProfileModel(
          documentID: documentID, 
          appId: entity.appId, 
          feedId: entity.feedId, 
          authorId: entity.authorId, 
          profile: entity.profile, 
          profileBackground: profileBackgroundHolder, 
          profileOverride: entity.profileOverride, 
          nameOverride: entity.nameOverride, 
          readAccess: entity.readAccess, 
    );
  }

}

