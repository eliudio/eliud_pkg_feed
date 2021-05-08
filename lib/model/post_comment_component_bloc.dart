/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_comment_component_event.dart';
import 'package:eliud_pkg_feed/model/post_comment_component_state.dart';
import 'package:eliud_pkg_feed/model/post_comment_repository.dart';
import 'package:flutter/services.dart';

class PostCommentComponentBloc extends Bloc<PostCommentComponentEvent, PostCommentComponentState> {
  final PostCommentRepository? postCommentRepository;

  PostCommentComponentBloc({ this.postCommentRepository }): super(PostCommentComponentUninitialized());
  @override
  Stream<PostCommentComponentState> mapEventToState(PostCommentComponentEvent event) async* {
    final currentState = state;
    if (event is FetchPostCommentComponent) {
      try {
        if (currentState is PostCommentComponentUninitialized) {
          bool permissionDenied = false;
          final model = await postCommentRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield PostCommentComponentPermissionDenied();
          } else {
            if (model != null) {
              yield PostCommentComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield PostCommentComponentError(
                  message: "PostComment with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield PostCommentComponentError(message: "Unknown error whilst retrieving PostComment");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

