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
import 'package:flutter/services.dart';

class FeedComponentBloc extends Bloc<FeedComponentEvent, FeedComponentState> {
  final FeedRepository? feedRepository;
  StreamSubscription? _feedSubscription;

  Stream<FeedComponentState> _mapLoadFeedComponentUpdateToState(String documentId) async* {
    _feedSubscription?.cancel();
    _feedSubscription = feedRepository!.listenTo(documentId, (value) {
      if (value != null) add(FeedComponentUpdated(value: value!));
    });
  }

  FeedComponentBloc({ this.feedRepository }): super(FeedComponentUninitialized());

  @override
  Stream<FeedComponentState> mapEventToState(FeedComponentEvent event) async* {
    final currentState = state;
    if (event is FetchFeedComponent) {
      yield* _mapLoadFeedComponentUpdateToState(event.id!);
    } else if (event is FeedComponentUpdated) {
      yield FeedComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _feedSubscription?.cancel();
    return super.close();
  }

}

