/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_comment_repository.dart';

import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/cache_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

class PostCommentCache implements PostCommentRepository {

  final PostCommentRepository reference;
  final Map<String?, PostCommentModel?> fullCache = Map();

  PostCommentCache(this.reference);

  Future<PostCommentModel> add(PostCommentModel value) {
    return reference.add(value).then((newValue) {
      fullCache[value.documentID] = newValue;
      return newValue;
    });
  }

  Future<PostCommentEntity> addEntity(String documentID, PostCommentEntity value) {
    return reference.addEntity(documentID, value);
  }

  Future<PostCommentEntity> updateEntity(String documentID, PostCommentEntity value) {
    return reference.updateEntity(documentID, value);
  }

  Future<void> delete(PostCommentModel value){
    fullCache.remove(value.documentID);
    reference.delete(value);
    return Future.value();
  }

  Future<PostCommentModel?> get(String? id, {Function(Exception)? onError}) async {
    var value = fullCache[id];
    if (value != null) return refreshRelations(value);
    value = await reference.get(id, onError: onError);
    fullCache[id] = value;
    return value;
  }

  Future<PostCommentModel> update(PostCommentModel value) {
    return reference.update(value).then((newValue) {
      fullCache[value.documentID] = newValue;
      return newValue;
    });
  }

  @override
  Stream<List<PostCommentModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    return reference.values(orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, setLastDoc: setLastDoc, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }

  @override
  Stream<List<PostCommentModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    return reference.valuesWithDetails(orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, setLastDoc: setLastDoc, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }

  @override
  Future<List<PostCommentModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    return await reference.valuesList(orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, setLastDoc: setLastDoc, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }
  
  @override
  Future<List<PostCommentModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    return await reference.valuesListWithDetails(orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, setLastDoc: setLastDoc, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }

  void flush() {
    fullCache.clear();
  }
  
  String? timeStampToString(dynamic timeStamp) {
    return reference.timeStampToString(timeStamp);
  } 

  dynamic getSubCollection(String documentId, String name) {
    return reference.getSubCollection(documentId, name);
  }

  Future<PostCommentModel> changeValue(String documentId, String fieldName, num changeByThisValue) {
    return reference.changeValue(documentId, fieldName, changeByThisValue).then((newValue) {
      fullCache[documentId] = newValue;
      return newValue!;
    });
  }

  @override
  Future<PostCommentEntity?> getEntity(String? id, {Function(Exception p1)? onError}) {
    return reference.getEntity(id, onError: onError);
  }

  @override
  PostCommentEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    return reference.fromMap(o, newDocumentIds: newDocumentIds);
  }

  Future<void> deleteAll() {
    return reference.deleteAll();
  }

  @override
  StreamSubscription<List<PostCommentModel?>> listen(trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    return reference.listen(trigger, orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }

  @override
  StreamSubscription<List<PostCommentModel?>> listenWithDetails(trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    return reference.listenWithDetails(trigger, orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }

  @override
  StreamSubscription<PostCommentModel?> listenTo(String documentId, PostCommentChanged changed, {PostCommentErrorHandler? errorHandler}) {
    return reference.listenTo(documentId, ((value) {
      if (value != null) {
        fullCache[value.documentID] = value;
      }
      changed(value);
    }), errorHandler: errorHandler);
  }

  static Future<PostCommentModel> refreshRelations(PostCommentModel model) async {

    List<MemberMediumModel>? memberMediaHolder;
    if (model.memberMedia != null) {
      memberMediaHolder = List<MemberMediumModel>.from(await Future.wait(model.memberMedia!.map((element) async {
        return await MemberMediumCache.refreshRelations(element);
      }))).toList();
    }

    return model.copyWith(
        memberMedia: memberMediaHolder,


    );
  }

}

