/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/js_repository_singleton.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'abstract_repository_singleton.dart';
import 'dart:collection';
import '../model/feed_js_firestore.dart';
import '../model/feed_repository.dart';
import '../model/feed_cache.dart';
import '../model/post_js_firestore.dart';
import '../model/post_repository.dart';
import '../model/post_cache.dart';

import '../model/post_model.dart';

class JsRepositorySingleton extends AbstractRepositorySingleton {
    var _feedRepository = HashMap<String, FeedRepository>();
    var _postRepository = HashMap<String, PostRepository>();

    FeedRepository feedRepository(String appId) {
      if (_feedRepository[appId] == null) _feedRepository[appId] = FeedCache(FeedJsFirestore(appId));
      return _feedRepository[appId];
    }
    PostRepository postRepository(String appId) {
      if (_postRepository[appId] == null) _postRepository[appId] = PostCache(PostJsFirestore(appId));
      return _postRepository[appId];
    }

}
