/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_profile_form_bloc.dart
                       
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
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/member_profile_form_event.dart';
import 'package:eliud_pkg_feed/model/member_profile_form_state.dart';
import 'package:eliud_pkg_feed/model/member_profile_repository.dart';

class MemberProfileFormBloc extends Bloc<MemberProfileFormEvent, MemberProfileFormState> {
  final FormAction? formAction;
  final String? appId;

  MemberProfileFormBloc(this.appId, { this.formAction }): super(MemberProfileFormUninitialized());
  @override
  Stream<MemberProfileFormState> mapEventToState(MemberProfileFormEvent event) async* {
    final currentState = state;
    if (currentState is MemberProfileFormUninitialized) {
      if (event is InitialiseNewMemberProfileFormEvent) {
        MemberProfileFormLoaded loaded = MemberProfileFormLoaded(value: MemberProfileModel(
                                               documentID: "",
                                 appId: "",
                                 feedId: "",
                                 profile: "",
                                 readAccess: [],

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseMemberProfileFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        MemberProfileFormLoaded loaded = MemberProfileFormLoaded(value: await memberProfileRepository(appId: appId)!.get(event.value!.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseMemberProfileFormNoLoadEvent) {
        MemberProfileFormLoaded loaded = MemberProfileFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is MemberProfileFormInitialized) {
      MemberProfileModel? newValue = null;
      if (event is ChangedMemberProfileDocumentID) {
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittableMemberProfileForm(value: newValue);
        }

        return;
      }
      if (event is ChangedMemberProfileFeedId) {
        newValue = currentState.value!.copyWith(feedId: event.value);
        yield SubmittableMemberProfileForm(value: newValue);

        return;
      }
      if (event is ChangedMemberProfileAuthor) {
        if (event.value != null)
          newValue = currentState.value!.copyWith(author: await memberPublicInfoRepository(appId: appId)!.get(event.value));
        else
          newValue = new MemberProfileModel(
                                 documentID: currentState.value!.documentID,
                                 appId: currentState.value!.appId,
                                 feedId: currentState.value!.feedId,
                                 author: null,
                                 profile: currentState.value!.profile,
                                 profileBackground: currentState.value!.profileBackground,
                                 profileOverride: currentState.value!.profileOverride,
                                 readAccess: currentState.value!.readAccess,
          );
        yield SubmittableMemberProfileForm(value: newValue);

        return;
      }
      if (event is ChangedMemberProfileProfile) {
        newValue = currentState.value!.copyWith(profile: event.value);
        yield SubmittableMemberProfileForm(value: newValue);

        return;
      }
      if (event is ChangedMemberProfileProfileBackground) {
        if (event.value != null)
          newValue = currentState.value!.copyWith(profileBackground: await memberMediumRepository(appId: appId)!.get(event.value));
        else
          newValue = new MemberProfileModel(
                                 documentID: currentState.value!.documentID,
                                 appId: currentState.value!.appId,
                                 feedId: currentState.value!.feedId,
                                 author: currentState.value!.author,
                                 profile: currentState.value!.profile,
                                 profileBackground: null,
                                 profileOverride: currentState.value!.profileOverride,
                                 readAccess: currentState.value!.readAccess,
          );
        yield SubmittableMemberProfileForm(value: newValue);

        return;
      }
      if (event is ChangedMemberProfileProfileOverride) {
        if (event.value != null)
          newValue = currentState.value!.copyWith(profileOverride: await memberMediumRepository(appId: appId)!.get(event.value));
        else
          newValue = new MemberProfileModel(
                                 documentID: currentState.value!.documentID,
                                 appId: currentState.value!.appId,
                                 feedId: currentState.value!.feedId,
                                 author: currentState.value!.author,
                                 profile: currentState.value!.profile,
                                 profileBackground: currentState.value!.profileBackground,
                                 profileOverride: null,
                                 readAccess: currentState.value!.readAccess,
          );
        yield SubmittableMemberProfileForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDMemberProfileFormError error(String message, MemberProfileModel newValue) => DocumentIDMemberProfileFormError(message: message, value: newValue);

  Future<MemberProfileFormState> _isDocumentIDValid(String? value, MemberProfileModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<MemberProfileModel?> findDocument = memberProfileRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableMemberProfileForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

