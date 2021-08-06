/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_form_bloc.dart
                       
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

import 'package:eliud_pkg_feed/model/header_form_event.dart';
import 'package:eliud_pkg_feed/model/header_form_state.dart';
import 'package:eliud_pkg_feed/model/header_repository.dart';

class HeaderFormBloc extends Bloc<HeaderFormEvent, HeaderFormState> {
  final FormAction? formAction;
  final String? appId;

  HeaderFormBloc(this.appId, { this.formAction }): super(HeaderFormUninitialized());
  @override
  Stream<HeaderFormState> mapEventToState(HeaderFormEvent event) async* {
    final currentState = state;
    if (currentState is HeaderFormUninitialized) {
      if (event is InitialiseNewHeaderFormEvent) {
        HeaderFormLoaded loaded = HeaderFormLoaded(value: HeaderModel(
                                               documentID: "",
                                 appId: "",
                                 description: "",

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseHeaderFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        HeaderFormLoaded loaded = HeaderFormLoaded(value: await headerRepository(appId: appId)!.get(event.value!.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseHeaderFormNoLoadEvent) {
        HeaderFormLoaded loaded = HeaderFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is HeaderFormInitialized) {
      HeaderModel? newValue = null;
      if (event is ChangedHeaderDocumentID) {
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittableHeaderForm(value: newValue);
        }

        return;
      }
      if (event is ChangedHeaderAppId) {
        newValue = currentState.value!.copyWith(appId: event.value);
        yield SubmittableHeaderForm(value: newValue);

        return;
      }
      if (event is ChangedHeaderDescription) {
        newValue = currentState.value!.copyWith(description: event.value);
        yield SubmittableHeaderForm(value: newValue);

        return;
      }
      if (event is ChangedHeaderFeed) {
        if (event.value != null)
          newValue = currentState.value!.copyWith(feed: await feedRepository(appId: appId)!.get(event.value));
        else
          newValue = new HeaderModel(
                                 documentID: currentState.value!.documentID,
                                 appId: currentState.value!.appId,
                                 description: currentState.value!.description,
                                 feed: null,
                                 conditions: currentState.value!.conditions,
          );
        yield SubmittableHeaderForm(value: newValue);

        return;
      }
      if (event is ChangedHeaderConditions) {
        newValue = currentState.value!.copyWith(conditions: event.value);
        yield SubmittableHeaderForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDHeaderFormError error(String message, HeaderModel newValue) => DocumentIDHeaderFormError(message: message, value: newValue);

  Future<HeaderFormState> _isDocumentIDValid(String? value, HeaderModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<HeaderModel?> findDocument = headerRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableHeaderForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

