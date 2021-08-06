/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_form_bloc.dart
                       
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

import 'package:eliud_pkg_feed/model/feed_menu_form_event.dart';
import 'package:eliud_pkg_feed/model/feed_menu_form_state.dart';
import 'package:eliud_pkg_feed/model/feed_menu_repository.dart';

class FeedMenuFormBloc extends Bloc<FeedMenuFormEvent, FeedMenuFormState> {
  final FormAction? formAction;
  final String? appId;

  FeedMenuFormBloc(this.appId, { this.formAction }): super(FeedMenuFormUninitialized());
  @override
  Stream<FeedMenuFormState> mapEventToState(FeedMenuFormEvent event) async* {
    final currentState = state;
    if (currentState is FeedMenuFormUninitialized) {
      if (event is InitialiseNewFeedMenuFormEvent) {
        FeedMenuFormLoaded loaded = FeedMenuFormLoaded(value: FeedMenuModel(
                                               documentID: "",
                                 appId: "",
                                 description: "",
                                 itemColor: RgbModel(r: 255, g: 255, b: 255, opacity: 1.00), 
                                 selectedItemColor: RgbModel(r: 255, g: 255, b: 255, opacity: 1.00), 

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseFeedMenuFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        FeedMenuFormLoaded loaded = FeedMenuFormLoaded(value: await feedMenuRepository(appId: appId)!.get(event.value!.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseFeedMenuFormNoLoadEvent) {
        FeedMenuFormLoaded loaded = FeedMenuFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is FeedMenuFormInitialized) {
      FeedMenuModel? newValue = null;
      if (event is ChangedFeedMenuDocumentID) {
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittableFeedMenuForm(value: newValue);
        }

        return;
      }
      if (event is ChangedFeedMenuAppId) {
        newValue = currentState.value!.copyWith(appId: event.value);
        yield SubmittableFeedMenuForm(value: newValue);

        return;
      }
      if (event is ChangedFeedMenuDescription) {
        newValue = currentState.value!.copyWith(description: event.value);
        yield SubmittableFeedMenuForm(value: newValue);

        return;
      }
      if (event is ChangedFeedMenuMenu) {
        if (event.value != null)
          newValue = currentState.value!.copyWith(menu: await menuDefRepository(appId: appId)!.get(event.value));
        else
          newValue = new FeedMenuModel(
                                 documentID: currentState.value!.documentID,
                                 appId: currentState.value!.appId,
                                 description: currentState.value!.description,
                                 menu: null,
                                 itemColor: currentState.value!.itemColor,
                                 selectedItemColor: currentState.value!.selectedItemColor,
                                 conditions: currentState.value!.conditions,
          );
        yield SubmittableFeedMenuForm(value: newValue);

        return;
      }
      if (event is ChangedFeedMenuItemColor) {
        newValue = currentState.value!.copyWith(itemColor: event.value);
        yield SubmittableFeedMenuForm(value: newValue);

        return;
      }
      if (event is ChangedFeedMenuSelectedItemColor) {
        newValue = currentState.value!.copyWith(selectedItemColor: event.value);
        yield SubmittableFeedMenuForm(value: newValue);

        return;
      }
      if (event is ChangedFeedMenuConditions) {
        newValue = currentState.value!.copyWith(conditions: event.value);
        yield SubmittableFeedMenuForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDFeedMenuFormError error(String message, FeedMenuModel newValue) => DocumentIDFeedMenuFormError(message: message, value: newValue);

  Future<FeedMenuFormState> _isDocumentIDValid(String? value, FeedMenuModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<FeedMenuModel?> findDocument = feedMenuRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableFeedMenuForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

