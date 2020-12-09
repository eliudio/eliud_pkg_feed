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
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
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


class FeedJsFirestore implements FeedRepository {
  Future<FeedModel> add(FeedModel value) {
    return feedCollection.doc(value.documentID)
        .set(value.toEntity(appId: appId).toDocument())
        .then((_) => value);
  }

  Future<void> delete(FeedModel value) {
    return feedCollection.doc(value.documentID).delete();
  }

  Future<FeedModel> update(FeedModel value) {
    return feedCollection.doc(value.documentID)
        .update(data: value.toEntity(appId: appId).toDocument())
        .then((_) => value);
  }

  FeedModel _populateDoc(DocumentSnapshot value) {
    return FeedModel.fromEntity(value.id, FeedEntity.fromMap(value.data()));
  }

  Future<FeedModel> _populateDocPlus(DocumentSnapshot value) async {
    return FeedModel.fromEntityPlus(value.id, FeedEntity.fromMap(value.data()), appId: appId);
  }

  Future<FeedModel> get(String id) {
    return feedCollection.doc(id).get().then((data) {
      if (data.data() != null) {
        return _populateDocPlus(data);
      } else {
        return null;
      }
    });
  }

  @override
  StreamSubscription<List<FeedModel>> listen(FeedModelTrigger trigger, {String orderBy, bool descending }) {
    var stream;
    if (orderBy == null) {
      stream = getCollection().onSnapshot
          .map((data) {
        Iterable<FeedModel> feeds  = data.docs.map((doc) {
          FeedModel value = _populateDoc(doc);
          return value;
        }).toList();
        return feeds;
      });
    } else {
      stream = (orderBy == null ?  getCollection() : getCollection().orderBy(orderBy, descending ? 'desc': 'asc')).onSnapshot
          .map((data) {
        Iterable<FeedModel> feeds  = data.docs.map((doc) {
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

  StreamSubscription<List<FeedModel>> listenWithDetails(FeedModelTrigger trigger) {
    // If we use feedCollection here, then the second subscription fails
    Stream<List<FeedModel>> stream = getCollection().onSnapshot
        .asyncMap((data) async {
      return await Future.wait(data.docs.map((doc) =>  _populateDocPlus(doc)).toList());
    });

    return stream.listen((listOfFeedModels) {
      trigger(listOfFeedModels);
    });
  }

  Stream<List<FeedModel>> values() {
    return feedCollection.onSnapshot
        .map((data) => data.docs.map((doc) => _populateDoc(doc)).toList());
  }

  Stream<List<FeedModel>> valuesWithDetails() {
    return feedCollection.onSnapshot
        .asyncMap((data) => Future.wait(data.docs.map((doc) => _populateDocPlus(doc)).toList()));
  }

  @override
  Future<List<FeedModel>> valuesList() {
    return feedCollection.get().then((value) {
      var list = value.docs;
      return list.map((doc) => _populateDoc(doc)).toList();
    });
  }

  @override
  Future<List<FeedModel>> valuesListWithDetails() {
    return feedCollection.get().then((value) {
      var list = value.docs;
      return Future.wait(list.map((doc) =>  _populateDocPlus(doc)).toList());
    });
  }

  void flush() {
  }
  
  Future<void> deleteAll() {
    return feedCollection.get().then((snapshot) => snapshot.docs
        .forEach((element) => feedCollection.doc(element.id).delete()));
  }
  CollectionReference getCollection() => firestore().collection('Feed-$appId');

  final String appId;
  
  FeedJsFirestore(this.appId) : feedCollection = firestore().collection('Feed-$appId');

  final CollectionReference feedCollection;
}
