/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 labelled_body_component_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/



import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


import 'dart:async';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/core/base/repository_base.dart';

typedef LabelledBodyComponentModelTrigger(List<LabelledBodyComponentModel?> list);
typedef LabelledBodyComponentChanged(LabelledBodyComponentModel? value);
typedef LabelledBodyComponentErrorHandler(o, e);

abstract class LabelledBodyComponentRepository extends RepositoryBase<LabelledBodyComponentModel, LabelledBodyComponentEntity> {
  Future<LabelledBodyComponentEntity> addEntity(String documentID, LabelledBodyComponentEntity value);
  Future<LabelledBodyComponentEntity> updateEntity(String documentID, LabelledBodyComponentEntity value);
  Future<LabelledBodyComponentModel> add(LabelledBodyComponentModel value);
  Future<void> delete(LabelledBodyComponentModel value);
  Future<LabelledBodyComponentModel?> get(String? id, { Function(Exception)? onError });
  Future<LabelledBodyComponentModel> update(LabelledBodyComponentModel value);

  Stream<List<LabelledBodyComponentModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Stream<List<LabelledBodyComponentModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Future<List<LabelledBodyComponentModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Future<List<LabelledBodyComponentModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });

  StreamSubscription<List<LabelledBodyComponentModel?>> listen(LabelledBodyComponentModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  StreamSubscription<List<LabelledBodyComponentModel?>> listenWithDetails(LabelledBodyComponentModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  StreamSubscription<LabelledBodyComponentModel?> listenTo(String documentId, LabelledBodyComponentChanged changed, {LabelledBodyComponentErrorHandler? errorHandler});
  void flush();
  
  String? timeStampToString(dynamic timeStamp);

  dynamic getSubCollection(String documentId, String name);
  Future<LabelledBodyComponentModel?> changeValue(String documentId, String fieldName, num changeByThisValue);

  Future<void> deleteAll();
}


