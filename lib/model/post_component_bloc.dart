/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/model/post_component_event.dart';
import 'package:eliud_pkg_feed/model/post_component_state.dart';
import 'package:eliud_pkg_feed/model/post_repository.dart';
import 'package:flutter/services.dart';

class PostComponentBloc extends Bloc<PostComponentEvent, PostComponentState> {
  final PostRepository? postRepository;
  StreamSubscription? _postSubscription;

  Stream<PostComponentState> _mapLoadPostComponentUpdateToState(String documentId) async* {
    _postSubscription?.cancel();
    _postSubscription = postRepository!.listenTo(documentId, (value) {
      if (value != null) add(PostComponentUpdated(value: value));
    });
  }

  PostComponentBloc({ this.postRepository }): super(PostComponentUninitialized());

  @override
  Stream<PostComponentState> mapEventToState(PostComponentEvent event) async* {
    final currentState = state;
    if (event is FetchPostComponent) {
      yield* _mapLoadPostComponentUpdateToState(event.id!);
    } else if (event is PostComponentUpdated) {
      yield PostComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _postSubscription?.cancel();
    return super.close();
  }

}

