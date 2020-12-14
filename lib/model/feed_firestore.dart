/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_firestore.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';

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


class FeedFirestore implements FeedRepository {
  Future<FeedModel> add(FeedModel value) {
    return FeedCollection.document(value.documentID).setData(value.toEntity(appId: appId).toDocument()).then((_) => value);
  }

  Future<void> delete(FeedModel value) {
    return FeedCollection.document(value.documentID).delete();
  }

  Future<FeedModel> update(FeedModel value) {
    return FeedCollection.document(value.documentID).updateData(value.toEntity(appId: appId).toDocument()).then((_) => value);
  }

  FeedModel _populateDoc(DocumentSnapshot value) {
    return FeedModel.fromEntity(value.documentID, FeedEntity.fromMap(value.data));
  }

  Future<FeedModel> _populateDocPlus(DocumentSnapshot value) async {
    return FeedModel.fromEntityPlus(value.documentID, FeedEntity.fromMap(value.data), appId: appId);  }

  Future<FeedModel> get(String id) {
    return FeedCollection.document(id).get().then((doc) {
      if (doc.data != null)
        return _populateDocPlus(doc);
      else
        return null;
    });
  }

  StreamSubscription<List<FeedModel>> listen(FeedModelTrigger trigger, { String orderBy, bool descending }) {
    Stream<List<FeedModel>> stream;
    if (orderBy == null) {
       stream = FeedCollection.snapshots().map((data) {
        Iterable<FeedModel> feeds  = data.documents.map((doc) {
          FeedModel value = _populateDoc(doc);
          return value;
        }).toList();
        return feeds;
      });
    } else {
      stream = FeedCollection.orderBy(orderBy, descending: descending).snapshots().map((data) {
        Iterable<FeedModel> feeds  = data.documents.map((doc) {
          FeedModel value = _populateDoc(doc);
          return value;
        }).toList();
        return feeds;
      });
  
    }
    return stream.listen((listOfFeedModels) {
      trigger(listOfFeedModels);
    });
  }

  StreamSubscription<List<FeedModel>> listenWithDetails(FeedModelTrigger trigger, { String orderBy, bool descending }) {
    Stream<List<FeedModel>> stream;
    if (orderBy == null) {
      stream = FeedCollection.snapshots()
          .asyncMap((data) async {
        return await Future.wait(data.documents.map((doc) =>  _populateDocPlus(doc)).toList());
      });
    } else {
      stream = FeedCollection.orderBy(orderBy, descending: descending).snapshots()
          .asyncMap((data) async {
        return await Future.wait(data.documents.map((doc) =>  _populateDocPlus(doc)).toList());
      });
    }

    return stream.listen((listOfFeedModels) {
      trigger(listOfFeedModels);
    });
  }


  Stream<List<FeedModel>> values({ String orderBy, bool descending }) {
    if (orderBy == null) {
      return FeedCollection.snapshots().map((snapshot) {
        return snapshot.documents
              .map((doc) => _populateDoc(doc)).toList();
      });
    } else {
      return FeedCollection.orderBy(orderBy, descending: descending).snapshots().map((snapshot) {
        return snapshot.documents
              .map((doc) => _populateDoc(doc)).toList();
      });
    }
  }

  Stream<List<FeedModel>> valuesWithDetails({ String orderBy, bool descending }) {
    if (orderBy == null) {
      return FeedCollection.snapshots().asyncMap((snapshot) {
        return Future.wait(snapshot.documents
            .map((doc) => _populateDocPlus(doc)).toList());
      });
    } else {
      return FeedCollection.orderBy(orderBy, descending: descending).snapshots().asyncMap((snapshot) {
        return Future.wait(snapshot.documents
            .map((doc) => _populateDocPlus(doc)).toList());
      });
    }
  }

  Future<List<FeedModel>> valuesList({ String orderBy, bool descending }) async {
    if (orderBy == null) {
      return await FeedCollection.getDocuments().then((value) {
        var list = value.documents;
        return list.map((doc) => _populateDoc(doc)).toList();
      });
    } else {
      return await FeedCollection.orderBy(orderBy, descending: descending).getDocuments().then((value) {
        var list = value.documents;
        return list.map((doc) => _populateDoc(doc)).toList();
      });
    }
  }

  Future<List<FeedModel>> valuesListWithDetails({ String orderBy, bool descending }) async {
    if (orderBy == null) {
      return await FeedCollection.getDocuments().then((value) {
        var list = value.documents;
        return Future.wait(list.map((doc) =>  _populateDocPlus(doc)).toList());
      });
    } else {
      return await FeedCollection.orderBy(orderBy, descending: descending).getDocuments().then((value) {
        var list = value.documents;
        return Future.wait(list.map((doc) =>  _populateDocPlus(doc)).toList());
      });
    }
  }

  void flush() {}

  Future<void> deleteAll() {
    return FeedCollection.getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }});
  }


  final String appId;
  final CollectionReference FeedCollection;

  FeedFirestore(this.appId) : FeedCollection = Firestore.instance.collection('Feed-${appId}');
}

