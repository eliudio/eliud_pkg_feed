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
import '../model/album_firestore.dart';
import '../model/album_repository.dart';
import '../model/album_cache.dart';
import '../model/post_firestore.dart';
import '../model/post_repository.dart';
import '../model/post_cache.dart';
import '../model/post_comment_firestore.dart';
import '../model/post_comment_repository.dart';
import '../model/post_comment_cache.dart';
import '../model/post_like_firestore.dart';
import '../model/post_like_repository.dart';
import '../model/post_like_cache.dart';
import '../model/post_medium_repository.dart';
import '../model/post_medium_cache.dart';

import '../model/album_model.dart';
import '../model/post_model.dart';
import '../model/post_medium_model.dart';

class RepositorySingleton extends AbstractRepositorySingleton {
    var _feedRepository = HashMap<String, FeedRepository>();
    var _albumRepository = HashMap<String, AlbumRepository>();
    var _postRepository = HashMap<String, PostRepository>();
    var _postCommentRepository = HashMap<String, PostCommentRepository>();
    var _postLikeRepository = HashMap<String, PostLikeRepository>();

    FeedRepository? feedRepository(String? appId) {
      if ((appId != null) && (_feedRepository[appId] == null)) _feedRepository[appId] = FeedCache(FeedFirestore(appRepository()!.getSubCollection(appId, 'feed'), appId));
      return _feedRepository[appId];
    }
    AlbumRepository? albumRepository(String? appId) {
      if ((appId != null) && (_albumRepository[appId] == null)) _albumRepository[appId] = AlbumCache(AlbumFirestore(appRepository()!.getSubCollection(appId, 'album'), appId));
      return _albumRepository[appId];
    }
    PostRepository? postRepository(String? appId) {
      if ((appId != null) && (_postRepository[appId] == null)) _postRepository[appId] = PostCache(PostFirestore(appRepository()!.getSubCollection(appId, 'post'), appId));
      return _postRepository[appId];
    }
    PostCommentRepository? postCommentRepository(String? appId) {
      if ((appId != null) && (_postCommentRepository[appId] == null)) _postCommentRepository[appId] = PostCommentCache(PostCommentFirestore(appRepository()!.getSubCollection(appId, 'postcomment'), appId));
      return _postCommentRepository[appId];
    }
    PostLikeRepository? postLikeRepository(String? appId) {
      if ((appId != null) && (_postLikeRepository[appId] == null)) _postLikeRepository[appId] = PostLikeCache(PostLikeFirestore(appRepository()!.getSubCollection(appId, 'postlike'), appId));
      return _postLikeRepository[appId];
    }

}
