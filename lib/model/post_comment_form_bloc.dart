/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_form_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_core/model/rgb_model.dart';

import 'package:eliud_core/tools/string_validator.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_storage/model/repository_export.dart';
import 'package:eliud_pkg_storage/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import 'package:eliud_pkg_storage/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import 'package:eliud_pkg_storage/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/post_comment_form_event.dart';
import 'package:eliud_pkg_feed/model/post_comment_form_state.dart';
import 'package:eliud_pkg_feed/model/post_comment_repository.dart';

class PostCommentFormBloc extends Bloc<PostCommentFormEvent, PostCommentFormState> {
  final FormAction formAction;
  final String appId;

  PostCommentFormBloc(this.appId, { this.formAction }): super(PostCommentFormUninitialized());
  @override
  Stream<PostCommentFormState> mapEventToState(PostCommentFormEvent event) async* {
    final currentState = state;
    if (currentState is PostCommentFormUninitialized) {
      if (event is InitialiseNewPostCommentFormEvent) {
        PostCommentFormLoaded loaded = PostCommentFormLoaded(value: PostCommentModel(
                                               documentID: "",
                                 postId: "",
                                 postCommentId: "",
                                 memberId: "",
                                 appId: "",
                                 comment: "",
                                 likes: 0,
                                 dislikes: 0,
                                 memberImages: [],

        ));
        yield loaded;
        return;

      }


      if (event is InitialisePostCommentFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        PostCommentFormLoaded loaded = PostCommentFormLoaded(value: await postCommentRepository(appId: appId).get(event.value.documentID));
        yield loaded;
        return;
      } else if (event is InitialisePostCommentFormNoLoadEvent) {
        PostCommentFormLoaded loaded = PostCommentFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is PostCommentFormInitialized) {
      PostCommentModel newValue = null;
      if (event is ChangedPostCommentDocumentID) {
        newValue = currentState.value.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittablePostCommentForm(value: newValue);
        }

        return;
      }
      if (event is ChangedPostCommentPostId) {
        newValue = currentState.value.copyWith(postId: event.value);
        yield SubmittablePostCommentForm(value: newValue);

        return;
      }
      if (event is ChangedPostCommentPostCommentId) {
        newValue = currentState.value.copyWith(postCommentId: event.value);
        yield SubmittablePostCommentForm(value: newValue);

        return;
      }
      if (event is ChangedPostCommentMemberId) {
        newValue = currentState.value.copyWith(memberId: event.value);
        yield SubmittablePostCommentForm(value: newValue);

        return;
      }
      if (event is ChangedPostCommentTimestamp) {
        newValue = currentState.value.copyWith(timestamp: event.value);
        yield SubmittablePostCommentForm(value: newValue);

        return;
      }
      if (event is ChangedPostCommentAppId) {
        newValue = currentState.value.copyWith(appId: event.value);
        yield SubmittablePostCommentForm(value: newValue);

        return;
      }
      if (event is ChangedPostCommentComment) {
        newValue = currentState.value.copyWith(comment: event.value);
        yield SubmittablePostCommentForm(value: newValue);

        return;
      }
      if (event is ChangedPostCommentLikes) {
        if (isInt(event.value)) {
          newValue = currentState.value.copyWith(likes: int.parse(event.value));
          yield SubmittablePostCommentForm(value: newValue);

        } else {
          newValue = currentState.value.copyWith(likes: 0);
          yield LikesPostCommentFormError(message: "Value should be a number", value: newValue);
        }
        return;
      }
      if (event is ChangedPostCommentDislikes) {
        if (isInt(event.value)) {
          newValue = currentState.value.copyWith(dislikes: int.parse(event.value));
          yield SubmittablePostCommentForm(value: newValue);

        } else {
          newValue = currentState.value.copyWith(dislikes: 0);
          yield DislikesPostCommentFormError(message: "Value should be a number", value: newValue);
        }
        return;
      }
      if (event is ChangedPostCommentMemberImages) {
        newValue = currentState.value.copyWith(memberImages: event.value);
        yield SubmittablePostCommentForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDPostCommentFormError error(String message, PostCommentModel newValue) => DocumentIDPostCommentFormError(message: message, value: newValue);

  Future<PostCommentFormState> _isDocumentIDValid(String value, PostCommentModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<PostCommentModel> findDocument = postCommentRepository(appId: appId).get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittablePostCommentForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

