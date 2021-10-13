/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component_event.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component_state.dart';
import 'package:eliud_pkg_feed/model/feed_menu_repository.dart';
import 'package:flutter/services.dart';


class FeedMenuComponentBloc extends Bloc<FeedMenuComponentEvent, FeedMenuComponentState> {
  final FeedMenuRepository? feedMenuRepository;
  StreamSubscription? _feedMenuSubscription;

  Stream<FeedMenuComponentState> _mapLoadFeedMenuComponentUpdateToState(String documentId) async* {
    _feedMenuSubscription?.cancel();
    _feedMenuSubscription = feedMenuRepository!.listenTo(documentId, (value) {
      if (value != null) add(FeedMenuComponentUpdated(value: value));
    });
  }

  FeedMenuComponentBloc({ this.feedMenuRepository }): super(FeedMenuComponentUninitialized());

  @override
  Stream<FeedMenuComponentState> mapEventToState(FeedMenuComponentEvent event) async* {
    final currentState = state;
    if (event is FetchFeedMenuComponent) {
      yield* _mapLoadFeedMenuComponentUpdateToState(event.id!);
    } else if (event is FeedMenuComponentUpdated) {
      yield FeedMenuComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _feedMenuSubscription?.cancel();
    return super.close();
  }

}

