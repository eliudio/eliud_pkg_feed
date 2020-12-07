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

import 'package:eliud_pkg_feed/model/feed_form_event.dart';
import 'package:eliud_pkg_feed/model/feed_form_state.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';

class FeedFormBloc extends Bloc<FeedFormEvent, FeedFormState> {
  final FormAction formAction;
  final String appId;

  FeedFormBloc(this.appId, { this.formAction }): super(FeedFormUninitialized());
  @override
  Stream<FeedFormState> mapEventToState(FeedFormEvent event) async* {
    final currentState = state;
    if (currentState is FeedFormUninitialized) {
      if (event is InitialiseNewFeedFormEvent) {
        FeedFormLoaded loaded = FeedFormLoaded(value: FeedModel(
                                               documentID: "",
                                 appId: "",
                                 description: "",

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseFeedFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        FeedFormLoaded loaded = FeedFormLoaded(value: await feedRepository(appId: appId).get(event.value.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseFeedFormNoLoadEvent) {
        FeedFormLoaded loaded = FeedFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is FeedFormInitialized) {
      FeedModel newValue = null;
      if (event is ChangedFeedDocumentID) {
        newValue = currentState.value.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittableFeedForm(value: newValue);
        }

        return;
      }
      if (event is ChangedFeedAppId) {
        newValue = currentState.value.copyWith(appId: event.value);
        yield SubmittableFeedForm(value: newValue);

        return;
      }
      if (event is ChangedFeedDescription) {
        newValue = currentState.value.copyWith(description: event.value);
        yield SubmittableFeedForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDFeedFormError error(String message, FeedModel newValue) => DocumentIDFeedFormError(message: message, value: newValue);

  Future<FeedFormState> _isDocumentIDValid(String value, FeedModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<FeedModel> findDocument = feedRepository(appId: appId).get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableFeedForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

