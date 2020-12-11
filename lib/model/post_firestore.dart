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
import 'package:cloud_firestore/cloud_firestore.dart';
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


class PostFirestore implements PostRepository {
  Future<PostModel> add(PostModel value) {
    return PostCollection.document(value.documentID).setData(value.toEntity(appId: appId).copyWith(timestamp : FieldValue.serverTimestamp(), ).toDocument()).then((_) => value).then((v) => get(value.documentID));
  }

  Future<void> delete(PostModel value) {
    return PostCollection.document(value.documentID).delete();
  }

  Future<PostModel> update(PostModel value) {
    return PostCollection.document(value.documentID).updateData(value.toEntity(appId: appId).copyWith(timestamp : FieldValue.serverTimestamp(), ).toDocument()).then((_) => value).then((v) => get(value.documentID));
  }

  PostModel _populateDoc(DocumentSnapshot value) {
    return PostModel.fromEntity(value.documentID, PostEntity.fromMap(value.data));
  }

  Future<PostModel> _populateDocPlus(DocumentSnapshot value) async {
    return PostModel.fromEntityPlus(value.documentID, PostEntity.fromMap(value.data), appId: appId);  }

  Future<PostModel> get(String id) {
    return PostCollection.document(id).get().then((doc) {
      if (doc.data != null)
        return _populateDocPlus(doc);
      else
        return null;
    });
  }

  StreamSubscription<List<PostModel>> listen(String currentMember, PostModelTrigger trigger, { String orderBy, bool descending }) {
    Stream<List<PostModel>> stream;
    if (orderBy == null) {
       stream = PostCollection.where('readAccess', arrayContainsAny: ((currentMember == null) || (currentMember == "")) ? ['PUBLIC'] : [currentMember, 'PUBLIC']).snapshots().map((data) {
        Iterable<PostModel> posts  = data.documents.map((doc) {
          PostModel value = _populateDoc(doc);
          return value;
        }).toList();
        return posts;
      });
    } else {
      stream = PostCollection.orderBy(orderBy, descending: descending).where('readAccess', arrayContainsAny: ((currentMember == null) || (currentMember == "")) ? ['PUBLIC'] : [currentMember, 'PUBLIC']).snapshots().map((data) {
        Iterable<PostModel> posts  = data.documents.map((doc) {
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
    Stream<List<PostModel>> stream = PostCollection.snapshots()
        .asyncMap((data) async {
      return await Future.wait(data.documents.map((doc) =>  _populateDocPlus(doc)).toList());
    });

    return stream.listen((listOfPostModels) {
      trigger(listOfPostModels);
    });
  }


  Stream<List<PostModel>> values(String currentMember, ) {
    return PostCollection.where('readAccess', arrayContainsAny: [currentMember, 'PUBLIC']).snapshots().map((snapshot) {
      return snapshot.documents
            .map((doc) => _populateDoc(doc)).toList();
    });
  }

  Stream<List<PostModel>> valuesWithDetails(String currentMember, ) {
    return PostCollection.where('readAccess', arrayContainsAny: [currentMember, 'PUBLIC']).snapshots().asyncMap((snapshot) {
      return Future.wait(snapshot.documents
          .map((doc) => _populateDocPlus(doc)).toList());
    });
  }

  Future<List<PostModel>> valuesList(String currentMember, ) async {
    return await PostCollection.where('readAccess', arrayContainsAny: [currentMember, 'PUBLIC']).getDocuments().then((value) {
      var list = value.documents;
      return list.map((doc) => _populateDoc(doc)).toList();
    });
  }

  Future<List<PostModel>> valuesListWithDetails(String currentMember, ) async {
    return await PostCollection.where('readAccess', arrayContainsAny: [currentMember, 'PUBLIC']).getDocuments().then((value) {
      var list = value.documents;
      return Future.wait(list.map((doc) =>  _populateDocPlus(doc)).toList());
    });
  }

  void flush() {}

  Future<void> deleteAll() {
    return PostCollection.getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }});
  }


  final String appId;
  final CollectionReference PostCollection;

  PostFirestore(this.appId) : PostCollection = Firestore.instance.collection('Post-${appId}');
}

