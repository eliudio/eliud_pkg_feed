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
import 'package:eliud_core/tools/types.dart';

import 'package:eliud_core/model/rgb_model.dart';

import 'package:eliud_core/tools/string_validator.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_core/tools/action_entity.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/post_form_event.dart';
import 'package:eliud_pkg_feed/model/post_form_state.dart';
import 'package:eliud_pkg_feed/model/post_repository.dart';

class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  final String appId;

  PostFormBloc(this.appId, ): super(PostFormUninitialized());
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
                                 readAccess: [],

        ));
        yield loaded;
        return;

      }


      if (event is InitialisePostFormEvent) {
        PostFormLoaded loaded = PostFormLoaded(value: event.value);
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
        yield SubmittablePostForm(value: newValue);

        return;
      }
      if (event is ChangedPostAuthor) {
        if (event.value != null)
          newValue = currentState.value.copyWith(author: await memberRepository(appId: appId).get(event.value));
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
                                 readAccess: currentState.value.readAccess,
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
    }
  }


}

