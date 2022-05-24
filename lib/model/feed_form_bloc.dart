/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_form_bloc.dart
                       
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

import 'package:eliud_pkg_feed/model/feed_form_event.dart';
import 'package:eliud_pkg_feed/model/feed_form_state.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';

class FeedFormBloc extends Bloc<FeedFormEvent, FeedFormState> {
  final FormAction? formAction;
  final String? appId;

  FeedFormBloc(this.appId, { this.formAction }): super(FeedFormUninitialized());
  @override
  Stream<FeedFormState> mapEventToState(FeedFormEvent event) async* {
    final currentState = state;
    if (currentState is FeedFormUninitialized) {
      on <InitialiseNewFeedFormEvent> ((event, emit) {
        FeedFormLoaded loaded = FeedFormLoaded(value: FeedModel(
                                               documentID: "",
                                 appId: "",
                                 description: "",

        ));
        emit(loaded);
      });


      if (event is InitialiseFeedFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        FeedFormLoaded loaded = FeedFormLoaded(value: await feedRepository(appId: appId)!.get(event.value!.documentID));
        emit(loaded);
      } else if (event is InitialiseFeedFormNoLoadEvent) {
        FeedFormLoaded loaded = FeedFormLoaded(value: event.value);
        emit(loaded);
      }
    } else if (currentState is FeedFormInitialized) {
      FeedModel? newValue = null;
      on <ChangedFeedDocumentID> ((event, emit) async {
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittableFeedForm(value: newValue));
        }

      });
      on <ChangedFeedAppId> ((event, emit) async {
        newValue = currentState.value!.copyWith(appId: event.value);
        emit(SubmittableFeedForm(value: newValue));

      });
      on <ChangedFeedDescription> ((event, emit) async {
        newValue = currentState.value!.copyWith(description: event.value);
        emit(SubmittableFeedForm(value: newValue));

      });
      on <ChangedFeedThumbImage> ((event, emit) async {
        newValue = currentState.value!.copyWith(thumbImage: event.value);
        emit(SubmittableFeedForm(value: newValue));

      });
      on <ChangedFeedPhotoPost> ((event, emit) async {
        newValue = currentState.value!.copyWith(photoPost: event.value);
        emit(SubmittableFeedForm(value: newValue));

      });
      on <ChangedFeedVideoPost> ((event, emit) async {
        newValue = currentState.value!.copyWith(videoPost: event.value);
        emit(SubmittableFeedForm(value: newValue));

      });
      on <ChangedFeedMessagePost> ((event, emit) async {
        newValue = currentState.value!.copyWith(messagePost: event.value);
        emit(SubmittableFeedForm(value: newValue));

      });
      on <ChangedFeedAudioPost> ((event, emit) async {
        newValue = currentState.value!.copyWith(audioPost: event.value);
        emit(SubmittableFeedForm(value: newValue));

      });
      on <ChangedFeedAlbumPost> ((event, emit) async {
        newValue = currentState.value!.copyWith(albumPost: event.value);
        emit(SubmittableFeedForm(value: newValue));

      });
      on <ChangedFeedArticlePost> ((event, emit) async {
        newValue = currentState.value!.copyWith(articlePost: event.value);
        emit(SubmittableFeedForm(value: newValue));

      });
    }
  }


  DocumentIDFeedFormError error(String message, FeedModel newValue) => DocumentIDFeedFormError(message: message, value: newValue);

  Future<FeedFormState> _isDocumentIDValid(String? value, FeedModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<FeedModel?> findDocument = feedRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableFeedForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

