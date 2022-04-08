/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_front_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'package:eliud_pkg_feed/model/feed_front_component_event.dart';
import 'package:eliud_pkg_feed/model/feed_front_component_state.dart';
import 'package:eliud_pkg_feed/model/feed_front_repository.dart';
import 'package:flutter/services.dart';


class FeedFrontComponentBloc extends Bloc<FeedFrontComponentEvent, FeedFrontComponentState> {
  final FeedFrontRepository? feedFrontRepository;
  StreamSubscription? _feedFrontSubscription;

  Stream<FeedFrontComponentState> _mapLoadFeedFrontComponentUpdateToState(String documentId) async* {
    _feedFrontSubscription?.cancel();
    _feedFrontSubscription = feedFrontRepository!.listenTo(documentId, (value) {
      if (value != null) add(FeedFrontComponentUpdated(value: value));
    });
  }

  FeedFrontComponentBloc({ this.feedFrontRepository }): super(FeedFrontComponentUninitialized());

  @override
  Stream<FeedFrontComponentState> mapEventToState(FeedFrontComponentEvent event) async* {
    final currentState = state;
    if (event is FetchFeedFrontComponent) {
      yield* _mapLoadFeedFrontComponentUpdateToState(event.id!);
    } else if (event is FeedFrontComponentUpdated) {
      yield FeedFrontComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _feedFrontSubscription?.cancel();
    return super.close();
  }

}

