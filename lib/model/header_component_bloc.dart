/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_feed/model/header_model.dart';
import 'package:eliud_pkg_feed/model/header_component_event.dart';
import 'package:eliud_pkg_feed/model/header_component_state.dart';
import 'package:eliud_pkg_feed/model/header_repository.dart';
import 'package:flutter/services.dart';


class HeaderComponentBloc extends Bloc<HeaderComponentEvent, HeaderComponentState> {
  final HeaderRepository? headerRepository;

  HeaderComponentBloc({ this.headerRepository }): super(HeaderComponentUninitialized());
  @override
  Stream<HeaderComponentState> mapEventToState(HeaderComponentEvent event) async* {
    final currentState = state;
    if (event is FetchHeaderComponent) {
      try {
        if (currentState is HeaderComponentUninitialized) {
          bool permissionDenied = false;
          final model = await headerRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield HeaderComponentPermissionDenied();
          } else {
            if (model != null) {
              yield HeaderComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield HeaderComponentError(
                  message: "Header with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield HeaderComponentError(message: "Unknown error whilst retrieving Header");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

