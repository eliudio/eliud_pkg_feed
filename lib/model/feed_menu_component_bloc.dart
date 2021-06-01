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

  FeedMenuComponentBloc({ this.feedMenuRepository }): super(FeedMenuComponentUninitialized());
  @override
  Stream<FeedMenuComponentState> mapEventToState(FeedMenuComponentEvent event) async* {
    final currentState = state;
    if (event is FetchFeedMenuComponent) {
      try {
        if (currentState is FeedMenuComponentUninitialized) {
          bool permissionDenied = false;
          final model = await feedMenuRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield FeedMenuComponentPermissionDenied();
          } else {
            if (model != null) {
              yield FeedMenuComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield FeedMenuComponentError(
                  message: "FeedMenu with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield FeedMenuComponentError(message: "Unknown error whilst retrieving FeedMenu");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

