/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/repository_singleton.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'dart:collection';
import '../model/feed_firestore.dart';
import '../model/feed_repository.dart';
import '../model/feed_cache.dart';


class RepositorySingleton extends AbstractRepositorySingleton {
    var _feedRepository = HashMap<String, FeedRepository>();

    FeedRepository? feedRepository(String? appId) {
      if ((appId != null) && (_feedRepository[appId] == null)) _feedRepository[appId] = FeedCache(FeedFirestore(appRepository()!.getSubCollection(appId, 'feed'), appId));
      return _feedRepository[appId];
    }

}
