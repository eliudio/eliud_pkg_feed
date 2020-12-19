/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/abstract_repository_singleton.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import '../model/feed_repository.dart';
import '../model/post_repository.dart';
import 'package:eliud_core/core/access/bloc/user_repository.dart';
import 'package:eliud_core/tools/common_tools.dart';

FeedRepository feedRepository({ String appId }) => AbstractRepositorySingleton.singleton.feedRepository(appId);
PostRepository postRepository({ String appId }) => AbstractRepositorySingleton.singleton.postRepository(appId);

abstract class AbstractRepositorySingleton {
  static AbstractRepositorySingleton singleton;

  FeedRepository feedRepository(String appId);
  PostRepository postRepository(String appId);

  void flush(String appId) {
    feedRepository(appId).flush();
    postRepository(appId).flush();
  }
}
