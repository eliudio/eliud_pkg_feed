/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 profile_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

abstract class ProfileComponentState extends Equatable {
  const ProfileComponentState();

  @override
  List<Object?> get props => [];
}

class ProfileComponentUninitialized extends ProfileComponentState {}

class ProfileComponentError extends ProfileComponentState {
  final String? message;
  ProfileComponentError({ this.message });
}

class ProfileComponentPermissionDenied extends ProfileComponentState {
  ProfileComponentPermissionDenied();
}

class ProfileComponentLoaded extends ProfileComponentState {
  final ProfileModel value;

  const ProfileComponentLoaded({ required this.value });

  ProfileComponentLoaded copyWith({ ProfileModel? copyThis }) {
    return ProfileComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ProfileComponentLoaded { value: $value }';
}

