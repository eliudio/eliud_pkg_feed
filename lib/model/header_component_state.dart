/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';

abstract class HeaderComponentState extends Equatable {
  const HeaderComponentState();

  @override
  List<Object?> get props => [];
}

class HeaderComponentUninitialized extends HeaderComponentState {}

class HeaderComponentError extends HeaderComponentState {
  final String? message;
  HeaderComponentError({ this.message });
}

class HeaderComponentPermissionDenied extends HeaderComponentState {
  HeaderComponentPermissionDenied();
}

class HeaderComponentLoaded extends HeaderComponentState {
  final HeaderModel? value;

  const HeaderComponentLoaded({ this.value });

  HeaderComponentLoaded copyWith({ HeaderModel? copyThis }) {
    return HeaderComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'HeaderComponentLoaded { value: $value }';
}

