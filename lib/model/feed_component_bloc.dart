/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/feed_component_event.dart';
import 'package:eliud_pkg_feed/model/feed_component_state.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';
class FeedComponentBloc extends Bloc<FeedComponentEvent, FeedComponentState> {
  final FeedRepository feedRepository;

  FeedComponentBloc({ this.feedRepository }): super(FeedComponentUninitialized());
  @override
  Stream<FeedComponentState> mapEventToState(FeedComponentEvent event) async* {
    final currentState = state;
    if (event is FetchFeedComponent) {
      try {
        if (currentState is FeedComponentUninitialized) {
          final FeedModel model = await _fetchFeed(event.id);

          if (model != null) {
            yield FeedComponentLoaded(value: model);
          } else {
            String id = event.id;
            yield FeedComponentError(message: "Feed with id = '$id' not found");
          }
          return;
        }
      } catch (_) {
        yield FeedComponentError(message: "Unknown error whilst retrieving Feed");
      }
    }
  }

  Future<FeedModel> _fetchFeed(String id) async {
    return feedRepository.get(id);
  }

  @override
  Future<void> close() {
    return super.close();
  }

}


