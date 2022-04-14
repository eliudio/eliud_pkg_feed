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
import '../model/feed_front_firestore.dart';
import '../model/feed_front_repository.dart';
import '../model/feed_front_cache.dart';
import '../model/feed_menu_firestore.dart';
import '../model/feed_menu_repository.dart';
import '../model/feed_menu_cache.dart';
import '../model/labelled_body_component_repository.dart';
import '../model/labelled_body_component_cache.dart';
import '../model/member_profile_firestore.dart';
import '../model/member_profile_repository.dart';
import '../model/post_firestore.dart';
import '../model/post_repository.dart';
import '../model/post_cache.dart';
import '../model/post_comment_firestore.dart';
import '../model/post_comment_repository.dart';
import '../model/post_comment_cache.dart';
import '../model/post_like_firestore.dart';
import '../model/post_like_repository.dart';
import '../model/post_like_cache.dart';
import '../model/profile_firestore.dart';
import '../model/profile_repository.dart';
import '../model/profile_cache.dart';

import '../model/feed_front_model.dart';
import '../model/feed_menu_model.dart';
import '../model/member_profile_model.dart';
import '../model/profile_model.dart';

class RepositorySingleton extends AbstractRepositorySingleton {
    var _feedRepository = HashMap<String, FeedRepository>();
    var _feedFrontRepository = HashMap<String, FeedFrontRepository>();
    var _feedMenuRepository = HashMap<String, FeedMenuRepository>();
    var _memberProfileRepository = HashMap<String, MemberProfileRepository>();
    var _postRepository = HashMap<String, PostRepository>();
    var _postCommentRepository = HashMap<String, PostCommentRepository>();
    var _postLikeRepository = HashMap<String, PostLikeRepository>();
    var _profileRepository = HashMap<String, ProfileRepository>();

    FeedRepository? feedRepository(String? appId) {
      if ((appId != null) && (_feedRepository[appId] == null)) _feedRepository[appId] = FeedCache(FeedFirestore(() => appRepository()!.getSubCollection(appId, 'feed'), appId));
      return _feedRepository[appId];
    }
    FeedFrontRepository? feedFrontRepository(String? appId) {
      if ((appId != null) && (_feedFrontRepository[appId] == null)) _feedFrontRepository[appId] = FeedFrontCache(FeedFrontFirestore(() => appRepository()!.getSubCollection(appId, 'feedfront'), appId));
      return _feedFrontRepository[appId];
    }
    FeedMenuRepository? feedMenuRepository(String? appId) {
      if ((appId != null) && (_feedMenuRepository[appId] == null)) _feedMenuRepository[appId] = FeedMenuCache(FeedMenuFirestore(() => appRepository()!.getSubCollection(appId, 'feedmenu'), appId));
      return _feedMenuRepository[appId];
    }
    MemberProfileRepository? memberProfileRepository(String? appId) {
      if ((appId != null) && (_memberProfileRepository[appId] == null)) _memberProfileRepository[appId] = MemberProfileFirestore(() => appRepository()!.getSubCollection(appId, 'memberprofile'), appId);
      return _memberProfileRepository[appId];
    }
    PostRepository? postRepository(String? appId) {
      if ((appId != null) && (_postRepository[appId] == null)) _postRepository[appId] = PostCache(PostFirestore(() => appRepository()!.getSubCollection(appId, 'post'), appId));
      return _postRepository[appId];
    }
    PostCommentRepository? postCommentRepository(String? appId) {
      if ((appId != null) && (_postCommentRepository[appId] == null)) _postCommentRepository[appId] = PostCommentCache(PostCommentFirestore(() => appRepository()!.getSubCollection(appId, 'postcomment'), appId));
      return _postCommentRepository[appId];
    }
    PostLikeRepository? postLikeRepository(String? appId) {
      if ((appId != null) && (_postLikeRepository[appId] == null)) _postLikeRepository[appId] = PostLikeCache(PostLikeFirestore(() => appRepository()!.getSubCollection(appId, 'postlike'), appId));
      return _postLikeRepository[appId];
    }
    ProfileRepository? profileRepository(String? appId) {
      if ((appId != null) && (_profileRepository[appId] == null)) _profileRepository[appId] = ProfileCache(ProfileFirestore(() => appRepository()!.getSubCollection(appId, 'profile'), appId));
      return _profileRepository[appId];
    }

}
