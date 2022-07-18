/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_front_form_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:flutter/cupertino.dart';

import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_core/model/rgb_model.dart';

import 'package:eliud_core/tools/string_validator.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/feed_front_form_event.dart';
import 'package:eliud_pkg_feed/model/feed_front_form_state.dart';
import 'package:eliud_pkg_feed/model/feed_front_repository.dart';

class FeedFrontFormBloc extends Bloc<FeedFrontFormEvent, FeedFrontFormState> {
  final FormAction? formAction;
  final String? appId;

  FeedFrontFormBloc(this.appId, { this.formAction }): super(FeedFrontFormUninitialized()) {
      on <InitialiseNewFeedFrontFormEvent> ((event, emit) {
        FeedFrontFormLoaded loaded = FeedFrontFormLoaded(value: FeedFrontModel(
                                               documentID: "",
                                 appId: "",
                                 description: "",

        ));
        emit(loaded);
      });


      on <InitialiseFeedFrontFormEvent> ((event, emit) async {
        // Need to re-retrieve the document from the repository so that I get all associated types
        FeedFrontFormLoaded loaded = FeedFrontFormLoaded(value: await feedFrontRepository(appId: appId)!.get(event.value!.documentID));
        emit(loaded);
      });
      on <InitialiseFeedFrontFormNoLoadEvent> ((event, emit) async {
        FeedFrontFormLoaded loaded = FeedFrontFormLoaded(value: event.value);
        emit(loaded);
      });
      FeedFrontModel? newValue = null;
      on <ChangedFeedFrontDocumentID> ((event, emit) async {
      if (state is FeedFrontFormInitialized) {
        final currentState = state as FeedFrontFormInitialized;
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittableFeedFrontForm(value: newValue));
        }

      }
      });
      on <ChangedFeedFrontAppId> ((event, emit) async {
      if (state is FeedFrontFormInitialized) {
        final currentState = state as FeedFrontFormInitialized;
        newValue = currentState.value!.copyWith(appId: event.value);
        emit(SubmittableFeedFrontForm(value: newValue));

      }
      });
      on <ChangedFeedFrontDescription> ((event, emit) async {
      if (state is FeedFrontFormInitialized) {
        final currentState = state as FeedFrontFormInitialized;
        newValue = currentState.value!.copyWith(description: event.value);
        emit(SubmittableFeedFrontForm(value: newValue));

      }
      });
      on <ChangedFeedFrontFeed> ((event, emit) async {
      if (state is FeedFrontFormInitialized) {
        final currentState = state as FeedFrontFormInitialized;
        if (event.value != null)
          newValue = currentState.value!.copyWith(feed: await feedRepository(appId: appId)!.get(event.value));
        emit(SubmittableFeedFrontForm(value: newValue));

      }
      });
      on <ChangedFeedFrontBackgroundOverridePosts> ((event, emit) async {
      if (state is FeedFrontFormInitialized) {
        final currentState = state as FeedFrontFormInitialized;
        newValue = currentState.value!.copyWith(backgroundOverridePosts: event.value);
        emit(SubmittableFeedFrontForm(value: newValue));

      }
      });
      on <ChangedFeedFrontBackgroundOverrideProfile> ((event, emit) async {
      if (state is FeedFrontFormInitialized) {
        final currentState = state as FeedFrontFormInitialized;
        newValue = currentState.value!.copyWith(backgroundOverrideProfile: event.value);
        emit(SubmittableFeedFrontForm(value: newValue));

      }
      });
      on <ChangedFeedFrontConditions> ((event, emit) async {
      if (state is FeedFrontFormInitialized) {
        final currentState = state as FeedFrontFormInitialized;
        newValue = currentState.value!.copyWith(conditions: event.value);
        emit(SubmittableFeedFrontForm(value: newValue));

      }
      });
  }


  DocumentIDFeedFrontFormError error(String message, FeedFrontModel newValue) => DocumentIDFeedFrontFormError(message: message, value: newValue);

  Future<FeedFrontFormState> _isDocumentIDValid(String? value, FeedFrontModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<FeedFrontModel?> findDocument = feedFrontRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableFeedFrontForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

