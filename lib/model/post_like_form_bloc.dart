/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_form_bloc.dart
                       
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
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/post_like_form_event.dart';
import 'package:eliud_pkg_feed/model/post_like_form_state.dart';
import 'package:eliud_pkg_feed/model/post_like_repository.dart';

class PostLikeFormBloc extends Bloc<PostLikeFormEvent, PostLikeFormState> {
  final FormAction formAction;
  final String appId;

  PostLikeFormBloc(this.appId, { this.formAction }): super(PostLikeFormUninitialized());
  @override
  Stream<PostLikeFormState> mapEventToState(PostLikeFormEvent event) async* {
    final currentState = state;
    if (currentState is PostLikeFormUninitialized) {
      if (event is InitialiseNewPostLikeFormEvent) {
        PostLikeFormLoaded loaded = PostLikeFormLoaded(value: PostLikeModel(
                                               documentID: "",
                                 postId: "",
                                 postCommentId: "",
                                 memberId: "",
                                 appId: "",

        ));
        yield loaded;
        return;

      }


      if (event is InitialisePostLikeFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        PostLikeFormLoaded loaded = PostLikeFormLoaded(value: await postLikeRepository(appId: appId).get(event.value.documentID));
        yield loaded;
        return;
      } else if (event is InitialisePostLikeFormNoLoadEvent) {
        PostLikeFormLoaded loaded = PostLikeFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is PostLikeFormInitialized) {
      PostLikeModel newValue = null;
      if (event is ChangedPostLikeDocumentID) {
        newValue = currentState.value.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittablePostLikeForm(value: newValue);
        }

        return;
      }
      if (event is ChangedPostLikePostId) {
        newValue = currentState.value.copyWith(postId: event.value);
        yield SubmittablePostLikeForm(value: newValue);

        return;
      }
      if (event is ChangedPostLikePostCommentId) {
        newValue = currentState.value.copyWith(postCommentId: event.value);
        yield SubmittablePostLikeForm(value: newValue);

        return;
      }
      if (event is ChangedPostLikeMemberId) {
        newValue = currentState.value.copyWith(memberId: event.value);
        yield SubmittablePostLikeForm(value: newValue);

        return;
      }
      if (event is ChangedPostLikeTimestamp) {
        newValue = currentState.value.copyWith(timestamp: event.value);
        yield SubmittablePostLikeForm(value: newValue);

        return;
      }
      if (event is ChangedPostLikeAppId) {
        newValue = currentState.value.copyWith(appId: event.value);
        yield SubmittablePostLikeForm(value: newValue);

        return;
      }
      if (event is ChangedPostLikeLikeType) {
        newValue = currentState.value.copyWith(likeType: event.value);
        yield SubmittablePostLikeForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDPostLikeFormError error(String message, PostLikeModel newValue) => DocumentIDPostLikeFormError(message: message, value: newValue);

  Future<PostLikeFormState> _isDocumentIDValid(String value, PostLikeModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<PostLikeModel> findDocument = postLikeRepository(appId: appId).get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittablePostLikeForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

