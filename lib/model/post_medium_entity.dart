/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_medium_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

class PostMediumEntity {
  final String? memberMediumId;

  PostMediumEntity({this.memberMediumId, });


  List<Object?> get props => [memberMediumId, ];

  @override
  String toString() {
    return 'PostMediumEntity{memberMediumId: $memberMediumId}';
  }

  static PostMediumEntity? fromMap(Map? map) {
    if (map == null) return null;

    return PostMediumEntity(
      memberMediumId: map['memberMediumId'], 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (memberMediumId != null) theDocument["memberMediumId"] = memberMediumId;
      else theDocument["memberMediumId"] = null;
    return theDocument;
  }

  static PostMediumEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

