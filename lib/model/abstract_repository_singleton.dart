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
import '../model/album_repository.dart';
import '../model/post_repository.dart';
import '../model/post_comment_repository.dart';
import '../model/post_like_repository.dart';
import '../model/post_medium_repository.dart';
import 'package:eliud_core/core/access/bloc/user_repository.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core/package/package.dart';

FeedRepository? feedRepository({ String? appId }) => AbstractRepositorySingleton.singleton.feedRepository(appId);
AlbumRepository? albumRepository({ String? appId }) => AbstractRepositorySingleton.singleton.albumRepository(appId);
PostRepository? postRepository({ String? appId }) => AbstractRepositorySingleton.singleton.postRepository(appId);
PostCommentRepository? postCommentRepository({ String? appId }) => AbstractRepositorySingleton.singleton.postCommentRepository(appId);
PostLikeRepository? postLikeRepository({ String? appId }) => AbstractRepositorySingleton.singleton.postLikeRepository(appId);

abstract class AbstractRepositorySingleton {
  static List<MemberCollectionInfo> collections = [
    MemberCollectionInfo('post', 'authorId'),
    MemberCollectionInfo('postcomment', 'memberId'),
    MemberCollectionInfo('postlike', 'memberId'),
  ];
  static late AbstractRepositorySingleton singleton;

  FeedRepository? feedRepository(String? appId);
  AlbumRepository? albumRepository(String? appId);
  PostRepository? postRepository(String? appId);
  PostCommentRepository? postCommentRepository(String? appId);
  PostLikeRepository? postLikeRepository(String? appId);

  void flush(String? appId) {
  }
}
