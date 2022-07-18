/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 labelled_body_component_form_bloc.dart
                       
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

import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/labelled_body_component_form_event.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_form_state.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_repository.dart';

class LabelledBodyComponentFormBloc extends Bloc<LabelledBodyComponentFormEvent, LabelledBodyComponentFormState> {
  final String? appId;

  LabelledBodyComponentFormBloc(this.appId, ): super(LabelledBodyComponentFormUninitialized()) {
      on <InitialiseNewLabelledBodyComponentFormEvent> ((event, emit) {
        LabelledBodyComponentFormLoaded loaded = LabelledBodyComponentFormLoaded(value: LabelledBodyComponentModel(
                                               documentID: "IDENTIFIER", 
                                 label: "",
                                 componentName: "",
                                 componentId: "",

        ));
        emit(loaded);
      });


      on <InitialiseLabelledBodyComponentFormEvent> ((event, emit) async {
        LabelledBodyComponentFormLoaded loaded = LabelledBodyComponentFormLoaded(value: event.value);
        emit(loaded);
      });
      on <InitialiseLabelledBodyComponentFormNoLoadEvent> ((event, emit) async {
        LabelledBodyComponentFormLoaded loaded = LabelledBodyComponentFormLoaded(value: event.value);
        emit(loaded);
      });
      LabelledBodyComponentModel? newValue = null;
      on <ChangedLabelledBodyComponentComponentName> ((event, emit) async {
      if (state is LabelledBodyComponentFormInitialized) {
        final currentState = state as LabelledBodyComponentFormInitialized;
        newValue = currentState.value!.copyWith(componentName: event.value);
        emit(SubmittableLabelledBodyComponentForm(value: newValue));

      }
      });
      on <ChangedLabelledBodyComponentComponentId> ((event, emit) async {
      if (state is LabelledBodyComponentFormInitialized) {
        final currentState = state as LabelledBodyComponentFormInitialized;
        newValue = currentState.value!.copyWith(componentId: event.value);
        emit(SubmittableLabelledBodyComponentForm(value: newValue));

      }
      });
  }


}

