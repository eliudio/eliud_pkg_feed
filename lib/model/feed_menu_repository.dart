/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/



import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


import 'dart:async';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/core/base/repository_base.dart';

typedef FeedMenuModelTrigger(List<FeedMenuModel?> list);
typedef FeedMenuChanged(FeedMenuModel? value);
typedef FeedMenuErrorHandler(o, e);

abstract class FeedMenuRepository extends RepositoryBase<FeedMenuModel, FeedMenuEntity> {
  Future<FeedMenuEntity> addEntity(String documentID, FeedMenuEntity value);
  Future<FeedMenuEntity> updateEntity(String documentID, FeedMenuEntity value);
  Future<FeedMenuModel> add(FeedMenuModel value);
  Future<void> delete(FeedMenuModel value);
  Future<FeedMenuModel?> get(String? id, { Function(Exception)? onError });
  Future<FeedMenuModel> update(FeedMenuModel value);

  Stream<List<FeedMenuModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Stream<List<FeedMenuModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Future<List<FeedMenuModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Future<List<FeedMenuModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });

  StreamSubscription<List<FeedMenuModel?>> listen(FeedMenuModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  StreamSubscription<List<FeedMenuModel?>> listenWithDetails(FeedMenuModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  StreamSubscription<FeedMenuModel?> listenTo(String documentId, FeedMenuChanged changed, {FeedMenuErrorHandler? errorHandler});
  void flush();
  
  String? timeStampToString(dynamic timeStamp);

  dynamic getSubCollection(String documentId, String name);
  Future<FeedMenuModel?> changeValue(String documentId, String fieldName, num changeByThisValue);

  Future<void> deleteAll();
}


