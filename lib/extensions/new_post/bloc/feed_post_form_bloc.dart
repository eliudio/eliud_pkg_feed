/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form_bloc.dart
                       
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
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/post_form_event.dart';
import 'package:eliud_pkg_feed/model/post_form_state.dart';
import 'package:eliud_pkg_feed/model/post_repository.dart';

import 'feed_post_form_event.dart';
import 'feed_post_form_state.dart';

class FeedPostFormBloc extends Bloc<FeedPostFormEvent, FeedPostFormState> {
  final FormAction? formAction;
  final String? appId;

  FeedPostFormBloc(this.appId, { this.formAction }): super(FeedPostFormUninitialized());
  @override
  Stream<FeedPostFormState> mapEventToState(FeedPostFormEvent event) async* {
    final currentState = state;
    if (currentState is FeedPostFormUninitialized) {
      if (event is InitialiseNewPostFormEvent) {
        FeedPostFormLoaded loaded = FeedPostFormLoaded(value: PostModel(
                                               documentID: "",
                                 appId: "",
                                 feedId: "",
                                 postAppId: "",
                                 postPageId: "",
                                 description: "",
                                 likes: 0,
                                 dislikes: 0,
                                 readAccess: [],
                                 archived: PostArchiveStatus.Active, 
                                 externalLink: "",
                                 memberMedia: [],

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseFeedPostFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        FeedPostFormLoaded loaded = FeedPostFormLoaded(value: await postRepository(appId: appId)!.get(event.value!.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseFeedPostFormNoLoadEvent) {
        FeedPostFormLoaded loaded = FeedPostFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is FeedPostFormInitialized) {
      PostModel? newValue = null;

      if (event is ChangedFeedPostDescription) {
        newValue = currentState.value!.copyWith(description: event.value);
        yield SubmittableFeedPostForm(value: newValue);

        return;
      }

      if (event is ChangedFeedPostMemberMedia) {
        newValue = currentState.value!.copyWith(memberMedia: event.value);
        yield SubmittableFeedPostForm(value: newValue);

        return;
      }
    }
  }
}

