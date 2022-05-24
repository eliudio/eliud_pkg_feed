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

  void _mapLoadPostComponentUpdateToState(String documentId) {
    _postSubscription?.cancel();
    _postSubscription = postRepository!.listenTo(documentId, (value) {
      if (value != null) {
        add(PostComponentUpdated(value: value));
      }
    });
  }

  PostComponentBloc({ this.postRepository }): super(PostComponentUninitialized()) {
    on <FetchPostComponent> ((event, emit) {
      _mapLoadPostComponentUpdateToState(event.id!);
    });
    on <PostComponentUpdated> ((event, emit) {
      emit(PostComponentLoaded(value: event.value));
    });
  }

  @override
  Future<void> close() {
    _postSubscription?.cancel();
    return super.close();
  }

}

