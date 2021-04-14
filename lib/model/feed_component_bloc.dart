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

  FeedComponentBloc({ this.feedRepository }): super(FeedComponentUninitialized());
  @override
  Stream<FeedComponentState> mapEventToState(FeedComponentEvent event) async* {
    final currentState = state;
    if (event is FetchFeedComponent) {
      try {
        if (currentState is FeedComponentUninitialized) {
          bool permissionDenied = false;
          final model = await feedRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield FeedComponentPermissionDenied();
          } else {
            if (model != null) {
              yield FeedComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield FeedComponentError(
                  message: "Feed with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield FeedComponentError(message: "Unknown error whilst retrieving Feed");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

