/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_firestore.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_feed/model/post_repository.dart';


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



import 'dart:async';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:eliud_core/tools/js_firestore_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';

class PostJsFirestore implements PostRepository {
  Future<PostModel> add(PostModel value) {
    return postCollection.doc(value.documentID)
        .set(value.toEntity(appId: appId).copyWith(timestamp : FieldValue.serverTimestamp(), ).toDocument())
        .then((_) => value).then((v) => get(value.documentID));
  }

  Future<void> delete(PostModel value) {
    return postCollection.doc(value.documentID).delete();
  }

  Future<PostModel> update(PostModel value) {
    return postCollection.doc(value.documentID)
        .update(data: value.toEntity(appId: appId).copyWith(timestamp : FieldValue.serverTimestamp(), ).toDocument())
        .then((_) => value).then((v) => get(value.documentID));
  }

  PostModel _populateDoc(DocumentSnapshot value) {
    return PostModel.fromEntity(value.id, PostEntity.fromMap(value.data()));
  }

  Future<PostModel> _populateDocPlus(DocumentSnapshot value) async {
    return PostModel.fromEntityPlus(value.id, PostEntity.fromMap(value.data()), appId: appId);
  }

  Future<PostModel> get(String id) {
    return postCollection.doc(id).get().then((data) {
      if (data.data() != null) {
        return _populateDocPlus(data);
      } else {
        return null;
      }
    });
  }

  @override
  StreamSubscription<List<PostModel>> listen(PostModelTrigger trigger, {String currentMember, String orderBy, bool descending, Object startAfter, int limit, SetLastDoc setLastDoc, int privilegeLevel }) {
    var stream;
    if (orderBy == null) {
      stream = getCollection().where('readAccess', 'array-contains-any', ((currentMember == null) || (currentMember == "")) ? ['PUBLIC'] : [currentMember, 'PUBLIC']).onSnapshot
          .map((data) {
        Iterable<PostModel> posts  = data.docs.map((doc) {
          PostModel value = _populateDoc(doc);
          return value;
        }).toList();
        return posts;
      });
    } else {
      stream = getCollection().orderBy(orderBy, descending ? 'desc': 'asc').where('readAccess', 'array-contains-any', ((currentMember == null) || (currentMember == "")) ? ['PUBLIC'] : [currentMember, 'PUBLIC']).onSnapshot
          .map((data) {
        Iterable<PostModel> posts  = data.docs.map((doc) {
          PostModel value = _populateDoc(doc);
          return value;
        }).toList();
        return posts;
      });
    }
    return stream.listen((listOfPostModels) {
      trigger(listOfPostModels);
    });
  }

  StreamSubscription<List<PostModel>> listenWithDetails(PostModelTrigger trigger, {String currentMember, String orderBy, bool descending, Object startAfter, int limit, SetLastDoc setLastDoc, int privilegeLevel }) {
    var stream;
    if (orderBy == null) {
      // If we use postCollection here, then the second subscription fails
      stream = getCollection().where('readAccess', 'array-contains-any', ((currentMember == null) || (currentMember == "")) ? ['PUBLIC'] : [currentMember, 'PUBLIC']).onSnapshot
          .asyncMap((data) async {
        return await Future.wait(data.docs.map((doc) =>  _populateDocPlus(doc)).toList());
      });
    } else {
      // If we use postCollection here, then the second subscription fails
      stream = getCollection().orderBy(orderBy, descending ? 'desc': 'asc').where('readAccess', 'array-contains-any', ((currentMember == null) || (currentMember == "")) ? ['PUBLIC'] : [currentMember, 'PUBLIC']).onSnapshot
          .asyncMap((data) async {
        return await Future.wait(data.docs.map((doc) =>  _populateDocPlus(doc)).toList());
      });
    }
    return stream.listen((listOfPostModels) {
      trigger(listOfPostModels);
    });
  }

  Stream<List<PostModel>> values({String currentMember, String orderBy, bool descending, Object startAfter, int limit, SetLastDoc setLastDoc, int privilegeLevel }) {
    DocumentSnapshot lastDoc;
    Stream<List<PostModel>> _values = getQuery(postCollection, currentMember: currentMember, orderBy: orderBy,  descending: descending,  startAfter: startAfter,  limit: limit, privilegeLevel: privilegeLevel, appId: appId)
      .onSnapshot
      .map((data) { 
        return data.docs.map((doc) {
          lastDoc = doc;
        return _populateDoc(doc);
      }).toList();});
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  Stream<List<PostModel>> valuesWithDetails({String currentMember, String orderBy, bool descending, Object startAfter, int limit, SetLastDoc setLastDoc, int privilegeLevel }) {
    DocumentSnapshot lastDoc;
    Stream<List<PostModel>> _values = getQuery(postCollection, currentMember: currentMember, orderBy: orderBy,  descending: descending,  startAfter: startAfter,  limit: limit, privilegeLevel: privilegeLevel, appId: appId)
      .onSnapshot
      .asyncMap((data) {
        return Future.wait(data.docs.map((doc) { 
          lastDoc = doc;
          return _populateDocPlus(doc);
        }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  @override
  Future<List<PostModel>> valuesList({String currentMember, String orderBy, bool descending, Object startAfter, int limit, SetLastDoc setLastDoc, int privilegeLevel }) async {
    DocumentSnapshot lastDoc;
    List<PostModel> _values = await getQuery(postCollection, currentMember: currentMember, orderBy: orderBy,  descending: descending,  startAfter: startAfter,  limit: limit, privilegeLevel: privilegeLevel, appId: appId).get().then((value) {
      var list = value.docs;
      return list.map((doc) { 
        lastDoc = doc;
        return _populateDoc(doc);
      }).toList();
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  @override
  Future<List<PostModel>> valuesListWithDetails({String currentMember, String orderBy, bool descending, Object startAfter, int limit, SetLastDoc setLastDoc, int privilegeLevel }) async {
    DocumentSnapshot lastDoc;
    List<PostModel> _values = await getQuery(postCollection, currentMember: currentMember, orderBy: orderBy,  descending: descending,  startAfter: startAfter,  limit: limit, privilegeLevel: privilegeLevel, appId: appId).get().then((value) {
      var list = value.docs;
      return Future.wait(list.map((doc) {  
        lastDoc = doc;
        return _populateDocPlus(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  void flush() {
  }
  
  Future<void> deleteAll() {
    return postCollection.get().then((snapshot) => snapshot.docs
        .forEach((element) => postCollection.doc(element.id).delete()));
  }
  
  dynamic getSubCollection(String documentId, String name) {
    return postCollection.doc(documentId).collection(name);
  }

  String timeStampToString(dynamic timeStamp) {
    return firestoreTimeStampToString(timeStamp);
  } 
  final String appId;
  PostJsFirestore(this.postCollection, this.appId);

  // In flutterweb, it seems we require to re-retrieve the collection. If not then subscribing / listening to it a second time fails.
  // CollectionReference getCollection() => postCollection;
  CollectionReference getCollection() => appRepository().getSubCollection(appId, 'post');
  final CollectionReference postCollection;
}

