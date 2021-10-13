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
  StreamSubscription? _headerSubscription;

  Stream<HeaderComponentState> _mapLoadHeaderComponentUpdateToState(String documentId) async* {
    _headerSubscription?.cancel();
    _headerSubscription = headerRepository!.listenTo(documentId, (value) {
      if (value != null) add(HeaderComponentUpdated(value: value));
    });
  }

  HeaderComponentBloc({ this.headerRepository }): super(HeaderComponentUninitialized());

  @override
  Stream<HeaderComponentState> mapEventToState(HeaderComponentEvent event) async* {
    final currentState = state;
    if (event is FetchHeaderComponent) {
      yield* _mapLoadHeaderComponentUpdateToState(event.id!);
    } else if (event is HeaderComponentUpdated) {
      yield HeaderComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _headerSubscription?.cancel();
    return super.close();
  }

}

