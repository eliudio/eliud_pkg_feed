/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 profile_form_bloc.dart
                       
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

import 'package:eliud_pkg_feed/model/profile_form_event.dart';
import 'package:eliud_pkg_feed/model/profile_form_state.dart';
import 'package:eliud_pkg_feed/model/profile_repository.dart';

class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  final FormAction? formAction;
  final String? appId;

  ProfileFormBloc(this.appId, { this.formAction }): super(ProfileFormUninitialized()) {
      on <InitialiseNewProfileFormEvent> ((event, emit) {
        ProfileFormLoaded loaded = ProfileFormLoaded(value: ProfileModel(
                                               documentID: "",
                                 appId: "",
                                 description: "",

        ));
        emit(loaded);
      });


      on <InitialiseProfileFormEvent> ((event, emit) async {
        // Need to re-retrieve the document from the repository so that I get all associated types
        ProfileFormLoaded loaded = ProfileFormLoaded(value: await profileRepository(appId: appId)!.get(event.value!.documentID));
        emit(loaded);
      });
      on <InitialiseProfileFormNoLoadEvent> ((event, emit) async {
        ProfileFormLoaded loaded = ProfileFormLoaded(value: event.value);
        emit(loaded);
      });
      ProfileModel? newValue = null;
      on <ChangedProfileDocumentID> ((event, emit) async {
      if (state is ProfileFormInitialized) {
        final currentState = state as ProfileFormInitialized;
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittableProfileForm(value: newValue));
        }

      }
      });
      on <ChangedProfileAppId> ((event, emit) async {
      if (state is ProfileFormInitialized) {
        final currentState = state as ProfileFormInitialized;
        newValue = currentState.value!.copyWith(appId: event.value);
        emit(SubmittableProfileForm(value: newValue));

      }
      });
      on <ChangedProfileDescription> ((event, emit) async {
      if (state is ProfileFormInitialized) {
        final currentState = state as ProfileFormInitialized;
        newValue = currentState.value!.copyWith(description: event.value);
        emit(SubmittableProfileForm(value: newValue));

      }
      });
      on <ChangedProfileFeed> ((event, emit) async {
      if (state is ProfileFormInitialized) {
        final currentState = state as ProfileFormInitialized;
        if (event.value != null)
          newValue = currentState.value!.copyWith(feed: await feedRepository(appId: appId)!.get(event.value));
        emit(SubmittableProfileForm(value: newValue));

      }
      });
      on <ChangedProfileBackgroundOverride> ((event, emit) async {
      if (state is ProfileFormInitialized) {
        final currentState = state as ProfileFormInitialized;
        newValue = currentState.value!.copyWith(backgroundOverride: event.value);
        emit(SubmittableProfileForm(value: newValue));

      }
      });
      on <ChangedProfileConditions> ((event, emit) async {
      if (state is ProfileFormInitialized) {
        final currentState = state as ProfileFormInitialized;
        newValue = currentState.value!.copyWith(conditions: event.value);
        emit(SubmittableProfileForm(value: newValue));

      }
      });
  }


  DocumentIDProfileFormError error(String message, ProfileModel newValue) => DocumentIDProfileFormError(message: message, value: newValue);

  Future<ProfileFormState> _isDocumentIDValid(String? value, ProfileModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<ProfileModel?> findDocument = profileRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableProfileForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

