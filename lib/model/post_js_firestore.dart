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

import 'dart:async';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:eliud_pkg_feed/model/post_repository.dart';


import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_core/tools/action_entity.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


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
  StreamSubscription<List<PostModel>> listen(String currentMember, PostModelTrigger trigger, {String orderBy, bool descending }) {
    var stream;
    if (orderBy == null) {
      stream = getCollection().where("readAccess", 'array-contains-any', [currentMember, 'PUBLIC']).onSnapshot
          .map((data) {
        Iterable<PostModel> posts  = data.docs.map((doc) {
          PostModel value = _populateDoc(doc);
          return value;
        }).toList();
        return posts;
      });
    } else {
      stream = getCollection().orderBy(orderBy, descending ? 'desc': 'asc').where("readAccess", 'array-contains-any', [currentMember, 'PUBLIC']).onSnapshot
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

  StreamSubscription<List<PostModel>> listenWithDetails(String currentMember, PostModelTrigger trigger) {
    // If we use postCollection here, then the second subscription fails
    Stream<List<PostModel>> stream = getCollection().onSnapshot
        .asyncMap((data) async {
      return await Future.wait(data.docs.map((doc) =>  _populateDocPlus(doc)).toList());
    });

    return stream.listen((listOfPostModels) {
      trigger(listOfPostModels);
    });
  }

  Stream<List<PostModel>> values(String currentMember, ) {
    return postCollection.onSnapshot
        .map((data) => data.docs.map((doc) => _populateDoc(doc)).toList());
  }

  Stream<List<PostModel>> valuesWithDetails(String currentMember, ) {
    return postCollection.onSnapshot
        .asyncMap((data) => Future.wait(data.docs.map((doc) => _populateDocPlus(doc)).toList()));
  }

  @override
  Future<List<PostModel>> valuesList(String currentMember, ) {
    return postCollection.get().then((value) {
      var list = value.docs;
      return list.map((doc) => _populateDoc(doc)).toList();
    });
  }

  @override
  Future<List<PostModel>> valuesListWithDetails(String currentMember, ) {
    return postCollection.get().then((value) {
      var list = value.docs;
      return Future.wait(list.map((doc) =>  _populateDocPlus(doc)).toList());
    });
  }

  void flush() {
  }
  
  Future<void> deleteAll() {
    return postCollection.get().then((snapshot) => snapshot.docs
        .forEach((element) => postCollection.doc(element.id).delete()));
  }
  CollectionReference getCollection() => firestore().collection('Post-$appId');

  final String appId;
  
  PostJsFirestore(this.appId) : postCollection = firestore().collection('Post-$appId');

  final CollectionReference postCollection;
}