/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_profile_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

class MemberProfileEntity {
  final String? appId;
  final String? feedId;
  final String? authorId;
  final String? profile;
  final String? profileBackgroundId;
  final String? profileOverride;
  final String? nameOverride;
  final List<String>? readAccess;

  MemberProfileEntity({this.appId, this.feedId, this.authorId, this.profile, this.profileBackgroundId, this.profileOverride, this.nameOverride, this.readAccess, });


  List<Object?> get props => [appId, feedId, authorId, profile, profileBackgroundId, profileOverride, nameOverride, readAccess, ];

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'MemberProfileEntity{appId: $appId, feedId: $feedId, authorId: $authorId, profile: $profile, profileBackgroundId: $profileBackgroundId, profileOverride: $profileOverride, nameOverride: $nameOverride, readAccess: String[] { $readAccessCsv }}';
  }

  static MemberProfileEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return MemberProfileEntity(
      appId: map['appId'], 
      feedId: map['feedId'], 
      authorId: map['authorId'], 
      profile: map['profile'], 
      profileBackgroundId: map['profileBackgroundId'], 
      profileOverride: map['profileOverride'], 
      nameOverride: map['nameOverride'], 
      readAccess: map['readAccess'] == null ? null : List.from(map['readAccess']), 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (feedId != null) theDocument["feedId"] = feedId;
      else theDocument["feedId"] = null;
    if (authorId != null) theDocument["authorId"] = authorId;
      else theDocument["authorId"] = null;
    if (profile != null) theDocument["profile"] = profile;
      else theDocument["profile"] = null;
    if (profileBackgroundId != null) theDocument["profileBackgroundId"] = profileBackgroundId;
      else theDocument["profileBackgroundId"] = null;
    if (profileOverride != null) theDocument["profileOverride"] = profileOverride;
      else theDocument["profileOverride"] = null;
    if (nameOverride != null) theDocument["nameOverride"] = nameOverride;
      else theDocument["nameOverride"] = null;
    if (readAccess != null) theDocument["readAccess"] = readAccess!.toList();
      else theDocument["readAccess"] = null;
    return theDocument;
  }

  static MemberProfileEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

