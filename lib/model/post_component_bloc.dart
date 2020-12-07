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

class PostComponentBloc extends Bloc<PostComponentEvent, PostComponentState> {
  final PostRepository postRepository;

  PostComponentBloc({ this.postRepository }): super(PostComponentUninitialized());
  @override
  Stream<PostComponentState> mapEventToState(PostComponentEvent event) async* {
    final currentState = state;
    if (event is FetchPostComponent) {
      try {
        if (currentState is PostComponentUninitialized) {
          final PostModel model = await _fetchPost(event.id);

          if (model != null) {
            yield PostComponentLoaded(value: model);
          } else {
            String id = event.id;
            yield PostComponentError(message: "Post with id = '$id' not found");
          }
          return;
        }
      } catch (_) {
        yield PostComponentError(message: "Unknown error whilst retrieving Post");
      }
    }
  }

  Future<PostModel> _fetchPost(String id) async {
    return postRepository.get(id);
  }

  @override
  Future<void> close() {
    return super.close();
  }

}


