/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:eliud_pkg_feed/model/post_model.dart';

typedef PostModelTrigger(List<PostModel> list);

abstract class PostRepository {
  Future<PostModel> add(PostModel value);
  Future<void> delete(PostModel value);
  Future<PostModel> get(String id);
  Future<PostModel> update(PostModel value);
  Stream<List<PostModel>> values();
  Stream<List<PostModel>> valuesWithDetails();
  StreamSubscription<List<PostModel>> listen(PostModelTrigger trigger);
StreamSubscription<List<PostModel>> listenWithDetails(PostModelTrigger trigger);
  void flush();
  Future<List<PostModel>> valuesList();
  Future<List<PostModel>> valuesListWithDetails();

  Future<void> deleteAll();
}


