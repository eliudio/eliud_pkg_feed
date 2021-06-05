import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'post_event.dart';
import 'post_state.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/tools/post_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final String memberId;

  static Map<LikeType, String> likeToFieldName = {
    LikeType.Like: 'likes',
    LikeType.Dislike: 'dislikes',
  };

  PostBloc(PostModel postModel, this.memberId)
      : super(PostLoaded()) {
    add(LoadCommentsEvent(postModel, memberId));
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (state is PostLoaded) {
      var theState = state as PostLoaded;
      // Load
      if (event is LoadCommentsEvent) {
        var loadState = await _loadComments(event.postModel.documentID!, event.postModel.appId!, );
        if (loadState == null)
          yield ErrorPostState("Couldn'lt load comments");
        else
          yield loadState;
        // Likes
      } else if (event is LikePostEvent) {
        var updateEmotionState =
            await _updateEmotion(theState, null, event.likeType, event.postModel, event.postModel.appId!);
        if (updateEmotionState == null)
          yield ErrorPostState("Couldn't update emotion state");
        else
          yield updateEmotionState;
      } else if (event is LikeCommentPostEvent) {
        var updateEmotionState = await _updateEmotion(
            theState, event.postCommentContainer, event.likeType, event.postModel, event.postModel.appId!);
        if (updateEmotionState == null)
          yield ErrorPostState("Couldn't update emotion state (like)");
        else
          yield updateEmotionState;
      } else if (event is AddCommentEvent) {
        var commentState = await _comment(theState, event.comment, event.postModel.documentID!, event.postModel.appId!);
        if (commentState == null)
          yield ErrorPostState("Couldn't add comment");
        else
          yield commentState;
      } else if (event is AddCommentCommentEvent) {
        var addCommentCommentState = await _commentComment(
            theState, event.postCommentContainer, event.comment, event.postModel.documentID!, event.postModel.appId!);
        if (addCommentCommentState == null)
          yield ErrorPostState("Couldn't comment on comment");
        else
          yield addCommentCommentState;
      } else if (event is DeleteCommentEvent) {
        var deleteState = await _deleteComment(theState, event.deleteThis, event.postModel.documentID!, event.postModel.appId!);
        if (deleteState == null)
          yield ErrorPostState("Couldn't delete comment");
        else
          yield deleteState;
      } else if (event is UpdateCommentEvent) {
        var commentState =
            await _updateComment(theState, event.updateThis, event.newValue, event.postModel.documentID!, event.postModel.appId!);
        if (commentState == null)
          yield ErrorPostState("Couldn't update comment");
        else
          yield commentState;
      }
    }
  }

  /* As a general rule, when updating data, be it adding a like, dislike, comment, ... we update the data in memory
     and allow the repository update happen in the background. As a matter of fact, there are firebase functions
     doing the counting of the likes async in the background anyway, so this is not only a performance optimisation,
     it is even a necessity even for some parts of the data, and hence making it a general approach is best.
   */

  // ********************************* create a comment ****************************
  Future<CommentsLoaded?> _comment(PostLoaded theState, String comment, String postId, String appId) async {
    var toAdd = PostCommentModel(
      documentID: newRandomKey(),
      postId: postId,
      memberId: memberId,
      appId: appId,
      comment: comment,
    );
    await postCommentRepository(appId: appId)!.add(toAdd);

    if (theState is CommentsLoaded) {
      PostCommentContainer? container =
          await construct(postId, toAdd, null, false);
      if (container != null) {
        final List<PostCommentContainer> newComments = [];
        newComments.add(container);
        var toCopy = theState.comments;
        if ((toCopy != null) && (toCopy.length > 0)) {
          for (int i = 0; i < toCopy.length; i++) {
            if (toCopy[i] != null) {
              newComments.add(toCopy[i]!.copyWith());
            }
          }
        }
        return theState.copyWith(comments: newComments);
      }
    } else {
      return _loadComments(postId, appId);
    }
  }

// ********************************* create a comment on comment ****************************
  Future<CommentsLoaded?> _commentComment(PostLoaded theState,
      PostCommentContainer postCommentContainer, String comment, String postId, String appId) async {
    var addThis = PostCommentModel(
      documentID: newRandomKey(),
      postId: postId,
      postCommentId: postCommentContainer.postComment!.documentID,
      memberId: memberId,
      appId: appId,
      comment: comment,
    );

    await postCommentRepository(appId: appId)!.add(addThis);

    if (theState is CommentsLoaded) {
      return theState.copyWith(
          comments:
              await _copyCommentCommentsAndAddOne(theState.comments, addThis));
    } else {
      return _loadComments(postId, appId);
    }
  }

  Future<List<PostCommentContainer>?> _copyCommentCommentsAndAddOne(
    List<PostCommentContainer?>? toCopy,
    PostCommentModel toAdd,
  ) async {
    if (toCopy == null) return Future.value(null);
    if (toCopy.length == 0) return [];

    final List<PostCommentContainer> newComments = [];
    for (int i = 0; i < toCopy.length; i++) {
      /*if ((toCopy[i] != null) &&
          (toCopy[i]!.postComment != null) &&
          (toCopy[i]!.postCommentContainer != null)) {
      */
        var theCopy = await _copyCommentCommentsAndAddOne(
            toCopy[i]!.postCommentContainer, toAdd);
        if (toCopy[i]!.postComment!.documentID == toAdd.postCommentId) {
          // is this the comment the parent of the item to be added then add it at the front
          PostCommentContainer? container =
              await construct(toAdd.appId, toAdd, null, false);
          if (container != null) {
            if (theCopy != null) {
              theCopy.insert(0, container);
            } else {
              theCopy = [container];
            }
          }
        }
        newComments.add(toCopy[i]!.copyWith(postCommentContainer: theCopy));
/*
      }
*/
    }
    return newComments;
  }

// ********************************* delete a comment ****************************
  Future<CommentsLoaded?> _deleteComment(
      PostLoaded theState, PostCommentModel deleteThis, String postId, String appId) async {
    postCommentRepository(appId: appId)!.delete(deleteThis);
    if (theState is CommentsLoaded) {
      return theState.copyWith(
          comments: _copyCommentsAndDeleteOne(
              theState.comments, deleteThis.documentID));
    } else {
      return _loadComments(postId, appId, );
    }
  }

  List<PostCommentContainer>? _copyCommentsAndDeleteOne(
    List<PostCommentContainer?>? toCopy,
    String? postCommentDocumentID,
  ) {
    if (toCopy == null) return null;
    if (toCopy.length == 0) return [];

    final List<PostCommentContainer> newComments = [];
    for (int i = 0; i < toCopy.length; i++) {
      if (toCopy[i] != null) {
        if (toCopy[i]!.postComment != null) {
          if (toCopy[i]!.postComment!.documentID != postCommentDocumentID) {
            newComments.add(toCopy[i]!.copyWith(
                postCommentContainer: _copyCommentsAndDeleteOne(
                    toCopy[i]!.postCommentContainer, postCommentDocumentID)));
          }
        }
      }
    }
    return newComments;
  }

// ********************************* update a comment ****************************
  Future<CommentsLoaded?> _updateComment(PostLoaded theState,
      PostCommentModel updateThis, String? newValue, String postId, String appId) async {
    postCommentRepository(appId: appId)!
        .update(updateThis.copyWith(comment: newValue));

    if (theState is CommentsLoaded) {
      return theState.copyWith(
          comments: _copyCommentsAndUpdateComment(
              theState.comments, updateThis.documentID, newValue));
    } else {
      return _loadComments(postId, appId, );
    }
  }

  List<PostCommentContainer>? _copyCommentsAndUpdateComment(
      List<PostCommentContainer?>? toCopy,
      String? postCommentDocumentID,
      String? comment) {
    if (toCopy == null) return null;
    if (toCopy.length == 0) return [];

    final List<PostCommentContainer> newComments = [];
    for (int i = 0; i < toCopy.length; i++) {
      var newValue;
/*
      if ((toCopy[i] != null) &&
          (toCopy[i]!.postCommentContainer != null) &&
          (toCopy[i]!.postComment != null)) {
*/
        if (toCopy[i]!.postComment!.documentID == postCommentDocumentID) {
          newValue = toCopy[i]!.copyWith(
              comment: comment,
              postCommentContainer: _copyCommentsAndUpdateComment(
                  toCopy[i]!.postCommentContainer,
                  postCommentDocumentID,
                  comment));
        } else {
          newValue = toCopy[i]!.copyWith(
              postCommentContainer: _copyCommentsAndUpdateComment(
                  toCopy[i]!.postCommentContainer,
                  postCommentDocumentID,
                  comment));
        }
        newComments.add(newValue);
/*
      }
*/
    }
    return newComments;
  }

// ********************************* update a like ****************************
  Future<CommentsLoaded?> _updateEmotion(PostLoaded theState,
      PostCommentContainer? postCommentContainer, LikeType? likePressed, PostModel postModel, String appId) async {
    // We have firebase functions to update the post collection. One reason is performance, we shouldn't do this work on the client.
    // Second reason is security: the client, except the owner, can update the post.
    // We allow the firebase function to do it's thing in the background, async. In the meantime we determine the value here
    // as well, although not storing it in the db, just in memory. It's all fast, and correct

    // the like ID = postId - memberId
    var likeKey = PostHelper.getLikeKey(
        postModel.documentID,
        postCommentContainer != null
            ? postCommentContainer.postComment!.documentID
            : null,
        memberId);

    // find a like that might already exist
    var like = await postLikeRepository(appId: postModel.appId)!
        .get(likeKey);

    // keep track of the EXTRA likes / dislikes this like / dislike will cause
    int likesExtra = 0;
    int dislikesExtra = 0;

    // what is this like / dislike
    var thisMembersLikeType;

    // did we like / dislike before?
    if (like == null) {
      // we did not like / disliked before.
      thisMembersLikeType = likePressed;

      // did we press like or dislike and determine the extra like / dislike for in memory update
      if (likePressed == LikeType.Like) {
        likesExtra = 1;
      } else if (likePressed == LikeType.Dislike) {
        dislikesExtra = 1;
      }

      // create the like/dislike
      postLikeRepository(appId: appId)!.add(PostLikeModel(
          documentID: likeKey,
          postId: postModel.documentID,
          memberId: memberId,
          appId: appId,
          postCommentId: postCommentContainer == null
              ? null
              : postCommentContainer.postComment!.documentID,
          likeType: likePressed));
    } else {
      // we already liked / disliked before
      if (like.likeType != likePressed) {
        // we changed from like to dislike or vice versa
        thisMembersLikeType = likePressed;

        // We changed from dislike to like, which means: count down dislikes and count up likes
        if (likePressed == LikeType.Like) {
          // changing a dislike into a like
          likesExtra = 1;
          dislikesExtra = -1;
        // We changed from like to dislike, which means: count down likes and count up dislikes
        } else if (likePressed == LikeType.Dislike) {
          // changing a like into a dislike
          dislikesExtra = 1;
          likesExtra = -1;
        }

        // upate the like / dislike
        postLikeRepository(appId: appId)!
            .update(like.copyWith(likeType: likePressed));
      } else {
        // we undo a like
        if (likePressed == LikeType.Like) {
          likesExtra = -1;
        // we undo a dislike
        } else if (likePressed == LikeType.Dislike) {
          dislikesExtra = -1;
        }

        // and update  but nothing changed in terms of likeType... it must mean we want to unlike
        await postLikeRepository(appId: appId)!.delete(like);
      }
    }
    var newPostModel;
    if (postCommentContainer == null) {
      if (theState is CommentsLoaded) {
        // update the state without having to retrieving it from the db
        return theState.copyWith(
            postModel: postModel.copyWith(
                likes: postModel.likes == null
                    ? likesExtra
                    : postModel.likes! + likesExtra,
                dislikes: postModel!.dislikes == null
                    ? dislikesExtra
                    : postModel.dislikes! + dislikesExtra),
            thisMembersLikeType: thisMembersLikeType);
      }
    } else {
      // just implement for 1 element on top level
      if (theState is CommentsLoaded) {
        // update the state without having to retrieving it from the db
        return theState.copyWith(
            comments: _copyCommentsAndUpdateALike(
                theState.comments,
                postCommentContainer.postComment!.documentID,
                thisMembersLikeType == LikeType.Like,
                likesExtra));
      }
    }
    return _loadComments(postModel.documentID!, appId);
  }

  List<PostCommentContainer>? _copyCommentsAndUpdateALike(
      List<PostCommentContainer?>? toCopy,
      String? postCommentDocumentID,
      bool? thisMemberLikesThisComment,
      int likesExtra) {
    if (toCopy == null) return null;
    if (toCopy.length == 0) return [];

    final List<PostCommentContainer> newComments = [];
    for (int i = 0; i < toCopy.length; i++) {
      var newValue;
      if ((toCopy[i] != null) && (toCopy[i]!.postComment != null)) {
        if (toCopy[i]!.postComment!.documentID == postCommentDocumentID) {
          newValue = toCopy[i]!.copyWith(
              thisMemberLikesThisComment: thisMemberLikesThisComment,
              postComment: toCopy[i]!.postComment!.copyWith(
                    likes: toCopy[i]!.postComment!.likes == null
                        ? likesExtra
                        : toCopy[i]!.postComment!.likes! + likesExtra,
                  ),
              postCommentContainer: _copyCommentsAndUpdateALike(
                  toCopy[i]!.postCommentContainer,
                  postCommentDocumentID,
                  thisMemberLikesThisComment,
                  likesExtra));
        } else {
          newValue = toCopy[i]!.copyWith(
              postCommentContainer: _copyCommentsAndUpdateALike(
                  toCopy[i]!.postCommentContainer,
                  postCommentDocumentID,
                  thisMemberLikesThisComment,
                  likesExtra));
        }
        newComments.add(newValue);
      }
    }
    return newComments;
  }

// ********************************* retrieve and map comments ****************************
  Future<PostCommentContainer?> construct(
      String? appId,
      PostCommentModel? comment,
      List<PostCommentContainer?>? commentComments,
      bool? thisMemberLikesThisComment) async {
    if (appId == null) return Future.value(null);
    if (comment == null) return Future.value(null);
    return PostCommentContainer(
      postComment: comment,
      dateTime: comment.timestamp.toString(),
      member:
          await memberPublicInfoRepository(appId: appId)!.get(comment.memberId),
      comment: comment.comment!,
      postCommentContainer: commentComments,
      thisMemberLikesThisComment: thisMemberLikesThisComment,
    );
  }

  Future<List<PostCommentContainer>?> mapComments(
    String postId,
    List<PostCommentModel?>? sourceComments,
    String? appId,
  ) async {
    if (sourceComments == null) return null;
    if (sourceComments.length == 0) return null;
    if (postId == null) return null;

    List<PostCommentContainer> comments = [];
    for (int i = 0; i < sourceComments.length; i++) {
      var comment = sourceComments[i];
      if (comment != null) {
        List<PostCommentModel?>? sourceCommentComments =
            await postCommentRepository(appId: appId)!.valuesList(
                orderBy: 'timestamp',
                descending: true,
                eliudQuery: EliudQuery()
                    .withCondition(EliudQueryCondition('postId',
                        isEqualTo: postId))
                    .withCondition(EliudQueryCondition('postCommentId',
                        isEqualTo: comment.documentID)));
        List<PostCommentContainer>? commentComments = await mapComments(
          postId,
          sourceCommentComments,
          appId,
        );

        var likeKey = PostHelper.getLikeKey(
            postId, comment.documentID, memberId);
        var like = await postLikeRepository(appId: appId)!.get(likeKey);

        var postCommentContainer =
            await construct(appId, comment, commentComments, like != null);
        if (postCommentContainer != null) {
          comments.add(postCommentContainer);
        }
      }
    }

    return comments;
  }
  Future<CommentsLoaded?> _loadComments(String postId, String appId) async {
    if (postId == null) return null;
    var likeKey = PostHelper.getLikeKey(postId, null, memberId);
    var like = await postLikeRepository(appId: appId)!.get(likeKey);

    List<PostCommentModel?>? sourceComments =
        await postCommentRepository(appId: appId)!.valuesList(
            orderBy: 'timestamp',
            descending: true,
            eliudQuery: EliudQuery()
                .withCondition(EliudQueryCondition('postId',
                    isEqualTo: postId))
                .withCondition(EliudQueryCondition(
                  'postCommentId',
                  isNull: true,
                )));
    List<PostCommentContainer?>? comments = await mapComments(
      postId,
      sourceComments,
      appId,
    );
    return CommentsLoaded(
        comments: comments,
        thisMembersLikeType: like == null ? null : like.likeType);
  }
}
