/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_like_component_event.dart';
import 'package:eliud_pkg_feed/model/post_like_component_state.dart';
import 'package:eliud_pkg_feed/model/post_like_repository.dart';
import 'package:flutter/services.dart';

class PostLikeComponentBloc extends Bloc<PostLikeComponentEvent, PostLikeComponentState> {
  final PostLikeRepository postLikeRepository;

  PostLikeComponentBloc({ this.postLikeRepository }): super(PostLikeComponentUninitialized());
  @override
  Stream<PostLikeComponentState> mapEventToState(PostLikeComponentEvent event) async* {
    final currentState = state;
    if (event is FetchPostLikeComponent) {
      try {
        if (currentState is PostLikeComponentUninitialized) {
          bool permissionDenied = false;
          final model = await postLikeRepository.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield PostLikeComponentPermissionDenied();
          } else {
            if (model != null) {
              yield PostLikeComponentLoaded(value: model);
            } else {
              String id = event.id;
              yield PostLikeComponentError(
                  message: "PostLike with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield PostLikeComponentError(message: "Unknown error whilst retrieving PostLike");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

