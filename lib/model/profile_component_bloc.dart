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
  StreamSubscription? _profileSubscription;

  Stream<ProfileComponentState> _mapLoadProfileComponentUpdateToState(String documentId) async* {
    _profileSubscription?.cancel();
    _profileSubscription = profileRepository!.listenTo(documentId, (value) {
      if (value != null) add(ProfileComponentUpdated(value: value));
    });
  }

  ProfileComponentBloc({ this.profileRepository }): super(ProfileComponentUninitialized());

  @override
  Stream<ProfileComponentState> mapEventToState(ProfileComponentEvent event) async* {
    final currentState = state;
    if (event is FetchProfileComponent) {
      yield* _mapLoadProfileComponentUpdateToState(event.id!);
    } else if (event is ProfileComponentUpdated) {
      yield ProfileComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _profileSubscription?.cancel();
    return super.close();
  }

}

