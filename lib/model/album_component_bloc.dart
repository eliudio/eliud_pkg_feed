/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_feed/model/album_model.dart';
import 'package:eliud_pkg_feed/model/album_component_event.dart';
import 'package:eliud_pkg_feed/model/album_component_state.dart';
import 'package:eliud_pkg_feed/model/album_repository.dart';
import 'package:flutter/services.dart';


class AlbumComponentBloc extends Bloc<AlbumComponentEvent, AlbumComponentState> {
  final AlbumRepository? albumRepository;

  AlbumComponentBloc({ this.albumRepository }): super(AlbumComponentUninitialized());
  @override
  Stream<AlbumComponentState> mapEventToState(AlbumComponentEvent event) async* {
    final currentState = state;
    if (event is FetchAlbumComponent) {
      try {
        if (currentState is AlbumComponentUninitialized) {
          bool permissionDenied = false;
          final model = await albumRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield AlbumComponentPermissionDenied();
          } else {
            if (model != null) {
              yield AlbumComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield AlbumComponentError(
                  message: "Album with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield AlbumComponentError(message: "Unknown error whilst retrieving Album");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

