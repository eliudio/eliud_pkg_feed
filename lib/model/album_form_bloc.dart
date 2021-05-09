/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_form_bloc.dart
                       
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

import 'package:eliud_pkg_feed/model/album_form_event.dart';
import 'package:eliud_pkg_feed/model/album_form_state.dart';
import 'package:eliud_pkg_feed/model/album_repository.dart';

class AlbumFormBloc extends Bloc<AlbumFormEvent, AlbumFormState> {
  final FormAction? formAction;
  final String? appId;

  AlbumFormBloc(this.appId, { this.formAction }): super(AlbumFormUninitialized());
  @override
  Stream<AlbumFormState> mapEventToState(AlbumFormEvent event) async* {
    final currentState = state;
    if (currentState is AlbumFormUninitialized) {
      if (event is InitialiseNewAlbumFormEvent) {
        AlbumFormLoaded loaded = AlbumFormLoaded(value: AlbumModel(
                                               documentID: "",
                                 appId: "",
                                 description: "",

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseAlbumFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        AlbumFormLoaded loaded = AlbumFormLoaded(value: await albumRepository(appId: appId)!.get(event.value!.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseAlbumFormNoLoadEvent) {
        AlbumFormLoaded loaded = AlbumFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is AlbumFormInitialized) {
      AlbumModel? newValue = null;
      if (event is ChangedAlbumDocumentID) {
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittableAlbumForm(value: newValue);
        }

        return;
      }
      if (event is ChangedAlbumAppId) {
        newValue = currentState.value!.copyWith(appId: event.value);
        yield SubmittableAlbumForm(value: newValue);

        return;
      }
      if (event is ChangedAlbumPost) {
        if (event.value != null)
          newValue = currentState.value!.copyWith(post: await postRepository(appId: appId)!.get(event.value));
        else
          newValue = new AlbumModel(
                                 documentID: currentState.value!.documentID,
                                 appId: currentState.value!.appId,
                                 post: null,
                                 description: currentState.value!.description,
                                 conditions: currentState.value!.conditions,
          );
        yield SubmittableAlbumForm(value: newValue);

        return;
      }
      if (event is ChangedAlbumDescription) {
        newValue = currentState.value!.copyWith(description: event.value);
        yield SubmittableAlbumForm(value: newValue);

        return;
      }
      if (event is ChangedAlbumConditions) {
        newValue = currentState.value!.copyWith(conditions: event.value);
        yield SubmittableAlbumForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDAlbumFormError error(String message, AlbumModel newValue) => DocumentIDAlbumFormError(message: message, value: newValue);

  Future<AlbumFormState> _isDocumentIDValid(String? value, AlbumModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<AlbumModel?> findDocument = albumRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableAlbumForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}
