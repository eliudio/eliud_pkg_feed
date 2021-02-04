import 'dart:async';

import 'package:bloc/bloc.dart';
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
      // Load
      if (event is LoadCommentsEvent) {
        yield await _loadComments(event.postModel, event.memberId);

      // Likes
      } else if (event is LikePostEvent) {
        yield await _updateEmotion(theState, null, event.likeType);
      } else if (event is LikeCommentPostEvent) {
        yield await _updateEmotion(theState, event.postCommentModel, event.likeType);
      // Comments
      } else if (event is AddCommentEvent) {
        yield await _comment(theState, event.comment);
      } else if (event is AddCommentCommentEvent) {
        yield await _commentComment(theState, event.postCommentContainer, event.comment);
      } else if (event is DeleteCommentEvent) {
        yield await _deleteComment(theState, event.deleteThis);
      } else if (event is UpdateCommentEvent) {
        yield await _updateComment(theState, event.updateThis, event.newValue);
      }
    }
  }

  Future<CommentsLoaded> _comment(PostLoaded theState, String comment) async {
    await postCommentRepository(appId: theState.postModel.appId)
        .add(PostCommentModel(
      documentID: newRandomKey(),
      postId: theState.postModel.documentID,
      memberId: theState.memberId,
      appId: theState.postModel.appId,
      comment: comment,
    ));

    return _loadComments(theState.postModel, theState.memberId);
  }

  Future<CommentsLoaded> _commentComment(PostLoaded theState,
      PostCommentContainer postCommentContainer, String comment) async {
    await postCommentRepository(appId: theState.postModel.appId)
        .add(PostCommentModel(
      documentID: newRandomKey(),
      postId: theState.postModel.documentID,
      postCommentId: postCommentContainer.postComment.documentID,
      memberId: theState.memberId,
      appId: theState.postModel.appId,
      comment: comment,
    ));

    return _loadComments(theState.postModel, theState.memberId);
  }

  Future<CommentsLoaded> _deleteComment(
      PostLoaded theState, PostCommentModel deleteThis) async {
    await postCommentRepository(appId: theState.postModel.appId)
        .delete(deleteThis);
    return _loadComments(theState.postModel, theState.memberId);
  }

  Future<CommentsLoaded> _updateComment(
      PostLoaded theState, PostCommentModel updateThis, String newValue) async {
    await postCommentRepository(appId: theState.postModel.appId)
        .update(updateThis.copyWith(comment: newValue));
    return _loadComments(theState.postModel, theState.memberId);
  }

  Future<CommentsLoaded> _updateEmotion(
      PostLoaded theState, PostCommentModel postCommentModel, LikeType likePressed) async {
    // We have firebase functions to update the post collection. One reason is performance, we shouldn't do this work on the client.
    // Second reason is security: the client, except the owner, can update the post.
    // We allow the firebase function to do it's thing in the background, async. In the meantime we determine the value here
    // as well, although not storing it in the db, just in memory. It's all fast, and correct

    // the like ID = postId - memberId
    var likeKey =
        PostHelper.getLikeKey(theState.postModel.documentID, postCommentModel != null ? postCommentModel.documentID : null, theState.memberId);
    var like =
        await postLikeRepository(appId: theState.postModel.appId).get(likeKey);
    int likesExtra = 0;
    int dislikesExtra = 0;
    if (like == null) {
      if (likePressed == LikeType.Like) {
        likesExtra = 1;
      } else if (likePressed == LikeType.Dislike) {
        dislikesExtra = 1;
      }
      postLikeRepository(appId: theState.postModel.appId).add(PostLikeModel(
          documentID: likeKey,
          postId: theState.postModel.documentID,
          memberId: theState.memberId,
          appId: theState.postModel.appId,
          postCommentId: postCommentModel == null ? null : postCommentModel.documentID,
          likeType: likePressed));
    } else {
      if (like.likeType != likePressed) {
        if (likePressed == LikeType.Like) {
          // changing a dislike into a like
          likesExtra = 1;
          dislikesExtra = -1;
        } else if (likePressed == LikeType.Dislike) {
          // changing a like into a dislike
          dislikesExtra = 1;
          likesExtra = -1;
        }
        postLikeRepository(appId: theState.postModel.appId)
            .update(like.copyWith(likeType: likePressed));
      } else {
        if (likePressed == LikeType.Like) {
          likesExtra = -1;
        } else if (likePressed == LikeType.Dislike) {
          dislikesExtra = -1;
        }
        // an update, but nothing changed in terms of likeType... it must mean we want to unlike
        postLikeRepository(appId: theState.postModel.appId).delete(like);
      }
    }
    var newPostModel;
    if (postCommentModel == null) {
      newPostModel = theState.postModel.copyWith(
          likes: theState.postModel.likes == null
              ? likesExtra
              : theState.postModel.likes + likesExtra,
          dislikes: theState.postModel.dislikes == null
              ? dislikesExtra
              : theState.postModel.dislikes + dislikesExtra);
    } else {
      newPostModel = theState.postModel;
    }
    if (theState is CommentsLoaded) {
      return CommentsLoaded(
          postModel: newPostModel,
          memberId: theState.memberId,
          comments: theState.comments,
          thisMembersLikeType: likePressed);
    } else {
      return _loadComments(newPostModel, theState.memberId);
    }
  }

  Future<List<PostCommentContainer>> mapComments(
    PostModel postModel,
    List<PostCommentModel> sourceComments,
    String appId,
    String memberId,
  ) async {
    if (sourceComments == null) return null;
    if (sourceComments.length == 0) return null;
    List<PostCommentContainer> comments =
        await Future.wait(sourceComments.map((comment) async {
      List<PostCommentModel> sourceCommentComments =
          await postCommentRepository(appId: appId).valuesList(
              orderBy: 'timestamp',
              descending: true,
              eliudQuery: EliudQuery()
                  .withCondition(EliudQueryCondition('postId',
                      isEqualTo: postModel.documentID))
                  .withCondition(EliudQueryCondition(
                    'postCommentId',
                    isEqualTo: comment.documentID,
                  )));
      List<PostCommentContainer> commentComments = await mapComments(
        postModel,
        sourceCommentComments,
        appId,
        memberId,
      );

      var likeKey = PostHelper.getLikeKey(postModel.documentID, comment.documentID, memberId);
      var like = await postLikeRepository(appId: appId).get(likeKey);

      return PostCommentContainer(
        postComment: comment,
        dateTime: comment.timestamp,
        member: await memberPublicInfoRepository(appId: appId)
            .get(comment.memberId),
        comment: comment.comment,
        postCommentContainer: commentComments,
        thisMemberLikesThisComment: like != null,
      );
    }).toList());
    return comments;
  }

  Future<CommentsLoaded> _loadComments(
      PostModel postModel, String memberId) async {
    var likeKey = PostHelper.getLikeKey(postModel.documentID, null, memberId);
    var like = await postLikeRepository(appId: postModel.appId).get(likeKey);

    List<PostCommentModel> sourceComments =
        await postCommentRepository(appId: postModel.appId).valuesList(
            orderBy: 'timestamp',
            descending: true,
            eliudQuery: EliudQuery()
                .withCondition(EliudQueryCondition('postId',
                    isEqualTo: postModel.documentID))
                .withCondition(EliudQueryCondition(
                  'postCommentId',
                  isNull: true,
                )));
    List<PostCommentContainer> comments = await mapComments(
      postModel,
      sourceComments,
      postModel.appId,
      memberId,
    );
    return CommentsLoaded(
        postModel: postModel,
        memberId: memberId,
        comments: comments,
        thisMembersLikeType: like == null ? null : like.likeType);
  }
}
