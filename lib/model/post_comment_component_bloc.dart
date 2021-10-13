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
  StreamSubscription? _postCommentSubscription;

  Stream<PostCommentComponentState> _mapLoadPostCommentComponentUpdateToState(String documentId) async* {
    _postCommentSubscription?.cancel();
    _postCommentSubscription = postCommentRepository!.listenTo(documentId, (value) {
      if (value != null) add(PostCommentComponentUpdated(value: value!));
    });
  }

  PostCommentComponentBloc({ this.postCommentRepository }): super(PostCommentComponentUninitialized());

  @override
  Stream<PostCommentComponentState> mapEventToState(PostCommentComponentEvent event) async* {
    final currentState = state;
    if (event is FetchPostCommentComponent) {
      yield* _mapLoadPostCommentComponentUpdateToState(event.id!);
    } else if (event is PostCommentComponentUpdated) {
      yield PostCommentComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _postCommentSubscription?.cancel();
    return super.close();
  }

}

