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
  final PostLikeRepository? postLikeRepository;
  StreamSubscription? _postLikeSubscription;

  Stream<PostLikeComponentState> _mapLoadPostLikeComponentUpdateToState(String documentId) async* {
    _postLikeSubscription?.cancel();
    _postLikeSubscription = postLikeRepository!.listenTo(documentId, (value) {
      if (value != null) add(PostLikeComponentUpdated(value: value!));
    });
  }

  PostLikeComponentBloc({ this.postLikeRepository }): super(PostLikeComponentUninitialized());

  @override
  Stream<PostLikeComponentState> mapEventToState(PostLikeComponentEvent event) async* {
    final currentState = state;
    if (event is FetchPostLikeComponent) {
      yield* _mapLoadPostLikeComponentUpdateToState(event.id!);
    } else if (event is PostLikeComponentUpdated) {
      yield PostLikeComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _postLikeSubscription?.cancel();
    return super.close();
  }

}

