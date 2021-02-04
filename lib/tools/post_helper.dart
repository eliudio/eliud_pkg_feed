import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_follow/model/abstract_repository_singleton.dart';
import 'package:flutter/cupertino.dart';

class PostHelper {
  static String getLikeKey(String postId, String postCommentId, String memberId) {
    if (postCommentId == null) {
      return postId + '-' + memberId;
    } else {
      return postId + '-' + postCommentId + '-' + memberId;
    }
  }
}
