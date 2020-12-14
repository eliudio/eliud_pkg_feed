/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:eliud_pkg_feed/model/feed_model.dart';

typedef FeedModelTrigger(List<FeedModel> list);

abstract class FeedRepository {
  Future<FeedModel> add(FeedModel value);
  Future<void> delete(FeedModel value);
  Future<FeedModel> get(String id);
  Future<FeedModel> update(FeedModel value);
  Stream<List<FeedModel>> values({String orderBy, bool descending });
  Stream<List<FeedModel>> valuesWithDetails({String orderBy, bool descending });  Future<List<FeedModel>> valuesList({String orderBy, bool descending });
  Future<List<FeedModel>> valuesListWithDetails({String orderBy, bool descending });
  StreamSubscription<List<FeedModel>> listen(FeedModelTrigger trigger, { String orderBy, bool descending });
  StreamSubscription<List<FeedModel>> listenWithDetails(FeedModelTrigger trigger, { String orderBy, bool descending });
  void flush();

  Future<void> deleteAll();
}


