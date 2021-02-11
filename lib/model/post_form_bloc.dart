/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form_bloc.dart
                       
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

import 'package:eliud_pkg_feed/model/post_form_event.dart';
import 'package:eliud_pkg_feed/model/post_form_state.dart';
import 'package:eliud_pkg_feed/model/post_repository.dart';

class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  final FormAction formAction;
  final String appId;

  PostFormBloc(this.appId, { this.formAction }): super(PostFormUninitialized());
  @override
  Stream<PostFormState> mapEventToState(PostFormEvent event) async* {
    final currentState = state;
    if (currentState is PostFormUninitialized) {
      if (event is InitialiseNewPostFormEvent) {
        PostFormLoaded loaded = PostFormLoaded(value: PostModel(
                                               documentID: "",
                                 appId: "",
                                 postAppId: "",
                                 postPageId: "",
                                 description: "",
                                 likes: 0,
                                 dislikes: 0,
                                 readAccess: [],
                                 archived: PostArchiveStatus.Active, 
                                 memberMedia: [],

        ));
        yield loaded;
        return;

      }


      if (event is InitialisePostFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        PostFormLoaded loaded = PostFormLoaded(value: await postRepository(appId: appId).get(event.value.documentID));
        yield loaded;
        return;
      } else if (event is InitialisePostFormNoLoadEvent) {
        PostFormLoaded loaded = PostFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is PostFormInitialized) {
      PostModel newValue = null;
      if (event is ChangedPostDocumentID) {
        newValue = currentState.value.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittablePostForm(value: newValue);
        }

        return;
      }
      if (event is ChangedPostAuthor) {
        if (event.value != null)
          newValue = currentState.value.copyWith(author: await memberPublicInfoRepository(appId: appId).get(event.value));
        else
          newValue = new PostModel(
                                 documentID: currentState.value.documentID,
                                 author: null,
                                 timestamp: currentState.value.timestamp,
                                 appId: currentState.value.appId,
                                 postAppId: currentState.value.postAppId,
                                 postPageId: currentState.value.postPageId,
                                 pageParameters: currentState.value.pageParameters,
                                 description: currentState.value.description,
                                 likes: currentState.value.likes,
                                 dislikes: currentState.value.dislikes,
                                 readAccess: currentState.value.readAccess,
                                 archived: currentState.value.archived,
                                 memberMedia: currentState.value.memberMedia,
          );
        yield SubmittablePostForm(value: newValue);

        return;
      }
      if (event is ChangedPostTimestamp) {
        newValue = currentState.value.copyWith(timestamp: event.value);
        yield SubmittablePostForm(value: newValue);

        return;
      }
      if (event is ChangedPostAppId) {
        newValue = currentState.value.copyWith(appId: event.value);
        yield SubmittablePostForm(value: newValue);

        return;
      }
      if (event is ChangedPostPostAppId) {
        newValue = currentState.value.copyWith(postAppId: event.value);
        yield SubmittablePostForm(value: newValue);

        return;
      }
      if (event is ChangedPostPostPageId) {
        newValue = currentState.value.copyWith(postPageId: event.value);
        yield SubmittablePostForm(value: newValue);

        return;
      }
      if (event is ChangedPostPageParameters) {
        newValue = currentState.value.copyWith(pageParameters: event.value);
        yield SubmittablePostForm(value: newValue);

        return;
      }
      if (event is ChangedPostDescription) {
        newValue = currentState.value.copyWith(description: event.value);
        yield SubmittablePostForm(value: newValue);

        return;
      }
      if (event is ChangedPostLikes) {
        if (isInt(event.value)) {
          newValue = currentState.value.copyWith(likes: int.parse(event.value));
          yield SubmittablePostForm(value: newValue);

        } else {
          newValue = currentState.value.copyWith(likes: 0);
          yield LikesPostFormError(message: "Value should be a number", value: newValue);
        }
        return;
      }
      if (event is ChangedPostDislikes) {
        if (isInt(event.value)) {
          newValue = currentState.value.copyWith(dislikes: int.parse(event.value));
          yield SubmittablePostForm(value: newValue);

        } else {
          newValue = currentState.value.copyWith(dislikes: 0);
          yield DislikesPostFormError(message: "Value should be a number", value: newValue);
        }
        return;
      }
      if (event is ChangedPostArchived) {
        newValue = currentState.value.copyWith(archived: event.value);
        yield SubmittablePostForm(value: newValue);

        return;
      }
      if (event is ChangedPostMemberMedia) {
        newValue = currentState.value.copyWith(memberMedia: event.value);
        yield SubmittablePostForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDPostFormError error(String message, PostModel newValue) => DocumentIDPostFormError(message: message, value: newValue);

  Future<PostFormState> _isDocumentIDValid(String value, PostModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<PostModel> findDocument = postRepository(appId: appId).get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittablePostForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

