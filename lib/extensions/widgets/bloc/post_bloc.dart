import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/widgets/bloc/post_event.dart';
import 'package:eliud_pkg_feed/extensions/widgets/bloc/post_state.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/tools/post_helper.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  static Map<LikeType, String> likeToFieldName = {
    LikeType.Like: 'likes',
    LikeType.Dislike: 'dislikes',
  };

  PostBloc(PostModel postModel, String memberId)
      : super(PostLoaded(postModel: postModel, memberId: memberId)) {
    add(LoadCommentsEvent(postModel, memberId));
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (state is PostLoaded) {
      var theState = state as PostLoaded;
      if (event is LoadCommentsEvent) {
        yield await _loadComments(event.postModel, event.memberId);

      // Post comments events
      } else if (event is LikePostEvent) {
        yield await _updateEmotion(theState, event.likeType);
      } else if (event is AddCommentEvent) {
        yield await _comment(theState, event.comment);
      } else if (event is DeleteCommentEvent) {
        yield await _deleteComment(theState, event.deleteThis);
      } else if (event is UpdateCommentEvent) {
        yield await _updateComment(theState, event.updateThis, event.newValue);
      }
    }
  }

  Future<CommentsLoaded> _comment(PostLoaded theState, String comment) async {
    var postComment = await postCommentRepository(appId: theState.postModel.appId).add(PostCommentModel(
      documentID: newRandomKey(),
      postId: theState.postModel.documentID,
      memberId: theState.memberId,
      appId: theState.postModel.appId,
      comment: comment
    ));

   return  _loadComments(theState.postModel, theState.memberId);
  }

  Future<CommentsLoaded> _deleteComment(PostLoaded theState, PostCommentModel deleteThis) async {
    await postCommentRepository(appId: theState.postModel.appId).delete(deleteThis);
    return  _loadComments(theState.postModel, theState.memberId);
  }

  Future<CommentsLoaded> _updateComment(PostLoaded theState, PostCommentModel updateThis, String newValue) async {
    await postCommentRepository(appId: theState.postModel.appId).update(updateThis.copyWith(comment: newValue));
    return  _loadComments(theState.postModel, theState.memberId);
  }

  Future<CommentsLoaded> _updateEmotion(
      PostLoaded theState, LikeType likePressed) async {
    // the like ID = postId - memberId
    var likeKey = PostHelper.getLikeKey(
        theState.postModel.documentID, theState.memberId);
    var like =
        await postLikeRepository(appId: theState.postModel.appId).get(likeKey);
    if (like == null) {
      await postLikeRepository(appId: theState.postModel.appId).add(
          PostLikeModel(
              documentID: likeKey,
              postId: theState.postModel.documentID,
              memberId: theState.memberId,
              appId: theState.postModel.appId,
              likeType: likePressed));
/*
      await postRepository(appId: theState.postModel.appId).changeValue(
          theState.postModel.documentID, likeToFieldName[likePressed], 1);
*/
    } else {
      if (like.likeType == likePressed) {
        // nothing to do, already this likeType
      } else {
/*
        String toIncrease = likeToFieldName[likePressed];
        String toDecrease = likeToFieldName[like.likeType];
*/
        // disliked before, now liking
        await postLikeRepository(appId: theState.postModel.appId)
            .update(like.copyWith(likeType: likePressed));
/*
        await postRepository(appId: theState.postModel.appId)
            .changeValue(theState.postModel.documentID, toIncrease, 1);
        await postRepository(appId: theState.postModel.appId)
            .changeValue(theState.postModel.documentID, toDecrease, -1);
*/
      }
    }
    var updatedPostmodel = await postRepository(appId: theState.postModel.appId)
        .get(theState.postModel.documentID);
    if (theState is CommentsLoaded) {
      return CommentsLoaded(
          postModel: updatedPostmodel,
          memberId: theState.memberId,
          comments: theState.comments,
          thisMembersLikeType: likePressed);
    } else {
      return _loadComments(updatedPostmodel, theState.memberId);
    }
  }

  Future<CommentsLoaded> _loadComments(
      PostModel postModel, String memberId) async {
    var likeKey =
        PostHelper.getLikeKey(postModel.documentID, memberId);
    var like = await postLikeRepository(appId: postModel.appId).get(likeKey);

    List<PostCommentModel> sourceComments = await postCommentRepository(appId: postModel.appId)
        .valuesList(
            orderBy: 'timestamp',
            descending: true,
            eliudQuery: EliudQuery().withCondition(EliudQueryCondition('postId',
                isEqualTo: postModel.documentID)));
    List<PostCommentContainer> comments = await Future.wait(sourceComments.map((comment) async =>
      PostCommentContainer(
        postComment: comment,
        dateTime: comment.timestamp,
        member: await memberPublicInfoRepository(appId: postModel.appId).get(comment.memberId),
        comment: comment.comment
      )
    ).toList());
    return CommentsLoaded(
        postModel: postModel,
        memberId: memberId,
        comments: comments,
        thisMembersLikeType: like == null ? null : like.likeType);
  }
}
