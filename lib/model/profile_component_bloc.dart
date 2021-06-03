/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 profile_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_feed/model/profile_model.dart';
import 'package:eliud_pkg_feed/model/profile_component_event.dart';
import 'package:eliud_pkg_feed/model/profile_component_state.dart';
import 'package:eliud_pkg_feed/model/profile_repository.dart';
import 'package:flutter/services.dart';


class ProfileComponentBloc extends Bloc<ProfileComponentEvent, ProfileComponentState> {
  final ProfileRepository? profileRepository;

  ProfileComponentBloc({ this.profileRepository }): super(ProfileComponentUninitialized());
  @override
  Stream<ProfileComponentState> mapEventToState(ProfileComponentEvent event) async* {
    final currentState = state;
    if (event is FetchProfileComponent) {
      try {
        if (currentState is ProfileComponentUninitialized) {
          bool permissionDenied = false;
          final model = await profileRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield ProfileComponentPermissionDenied();
          } else {
            if (model != null) {
              yield ProfileComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield ProfileComponentError(
                  message: "Profile with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield ProfileComponentError(message: "Unknown error whilst retrieving Profile");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

