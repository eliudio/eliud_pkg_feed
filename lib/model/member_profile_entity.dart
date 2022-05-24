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
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_core/tools/common_tools.dart';
class MemberProfileEntity {
  final String? appId;
  final String? feedId;
  final String? authorId;
  final String? profile;
  final String? profileBackgroundId;
  final String? profileOverride;
  final String? nameOverride;
  final int? accessibleByGroup;
  final List<String>? accessibleByMembers;
  final List<String>? readAccess;
  final List<MemberMediumContainerEntity>? memberMedia;

  MemberProfileEntity({required this.appId, this.feedId, this.authorId, this.profile, this.profileBackgroundId, this.profileOverride, this.nameOverride, this.accessibleByGroup, this.accessibleByMembers, this.readAccess, this.memberMedia, });


  List<Object?> get props => [appId, feedId, authorId, profile, profileBackgroundId, profileOverride, nameOverride, accessibleByGroup, accessibleByMembers, readAccess, memberMedia, ];

  @override
  String toString() {
    String accessibleByMembersCsv = (accessibleByMembers == null) ? '' : accessibleByMembers!.join(', ');
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');
    String memberMediaCsv = (memberMedia == null) ? '' : memberMedia!.join(', ');

    return 'MemberProfileEntity{appId: $appId, feedId: $feedId, authorId: $authorId, profile: $profile, profileBackgroundId: $profileBackgroundId, profileOverride: $profileOverride, nameOverride: $nameOverride, accessibleByGroup: $accessibleByGroup, accessibleByMembers: String[] { $accessibleByMembersCsv }, readAccess: String[] { $readAccessCsv }, memberMedia: MemberMediumContainer[] { $memberMediaCsv }}';
  }

  static MemberProfileEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var memberMediaFromMap;
    memberMediaFromMap = map['memberMedia'];
    var memberMediaList;
    if (memberMediaFromMap != null)
      memberMediaList = (map['memberMedia'] as List<dynamic>)
        .map((dynamic item) =>
        MemberMediumContainerEntity.fromMap(item as Map)!)
        .toList();

    return MemberProfileEntity(
      appId: map['appId'], 
      feedId: map['feedId'], 
      authorId: map['authorId'], 
      profile: map['profile'], 
      profileBackgroundId: map['profileBackgroundId'], 
      profileOverride: map['profileOverride'], 
      nameOverride: map['nameOverride'], 
      accessibleByGroup: map['accessibleByGroup'], 
      accessibleByMembers: map['accessibleByMembers'] == null ? null : List.from(map['accessibleByMembers']), 
      readAccess: map['readAccess'] == null ? null : List.from(map['readAccess']), 
      memberMedia: memberMediaList, 
    );
  }

  Map<String, Object?> toDocument() {
    final List<Map<String?, dynamic>>? memberMediaListMap = memberMedia != null 
        ? memberMedia!.map((item) => item.toDocument()).toList()
        : null;

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
    if (accessibleByGroup != null) theDocument["accessibleByGroup"] = accessibleByGroup;
      else theDocument["accessibleByGroup"] = null;
    if (accessibleByMembers != null) theDocument["accessibleByMembers"] = accessibleByMembers!.toList();
      else theDocument["accessibleByMembers"] = null;
    if (readAccess != null) theDocument["readAccess"] = readAccess!.toList();
      else theDocument["readAccess"] = null;
    if (memberMedia != null) theDocument["memberMedia"] = memberMediaListMap;
      else theDocument["memberMedia"] = null;
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

