/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_medium_form_bloc.dart
                       
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

import 'package:eliud_pkg_feed/model/post_medium_form_event.dart';
import 'package:eliud_pkg_feed/model/post_medium_form_state.dart';
import 'package:eliud_pkg_feed/model/post_medium_repository.dart';

class PostMediumFormBloc extends Bloc<PostMediumFormEvent, PostMediumFormState> {
  final String? appId;

  PostMediumFormBloc(this.appId, ): super(PostMediumFormUninitialized());
  @override
  Stream<PostMediumFormState> mapEventToState(PostMediumFormEvent event) async* {
    final currentState = state;
    if (currentState is PostMediumFormUninitialized) {
      if (event is InitialiseNewPostMediumFormEvent) {
        PostMediumFormLoaded loaded = PostMediumFormLoaded(value: PostMediumModel(
                                               documentID: "IDENTIFIER", 

        ));
        yield loaded;
        return;

      }


      if (event is InitialisePostMediumFormEvent) {
        PostMediumFormLoaded loaded = PostMediumFormLoaded(value: event.value);
        yield loaded;
        return;
      } else if (event is InitialisePostMediumFormNoLoadEvent) {
        PostMediumFormLoaded loaded = PostMediumFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is PostMediumFormInitialized) {
      PostMediumModel? newValue = null;
      if (event is ChangedPostMediumMemberMedium) {
        if (event.value != null)
          newValue = currentState.value!.copyWith(memberMedium: await memberMediumRepository(appId: appId)!.get(event.value));
        else
          newValue = new PostMediumModel(
                                 documentID: currentState.value!.documentID,
                                 memberMedium: null,
          );
        yield SubmittablePostMediumForm(value: newValue);

        return;
      }
    }
  }


}

