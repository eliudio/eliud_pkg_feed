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
  Stream<List<PostModel>> values(String currentMember);
  Stream<List<PostModel>> valuesWithDetails(String currentMember);
  Future<List<PostModel>> valuesList(String currentMember);
  Future<List<PostModel>> valuesListWithDetails(String currentMember);
  StreamSubscription<List<PostModel>> listen(String currentMember, PostModelTrigger trigger, { String orderBy, bool descending });
  StreamSubscription<List<PostModel>> listenWithDetails(String currentMember, PostModelTrigger trigger);
  void flush();

  Future<void> deleteAll();
}


