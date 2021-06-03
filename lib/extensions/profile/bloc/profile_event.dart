import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseProfileEvent extends ProfileEvent {
  final String feedId;
  final AppLoaded appLoaded;
  final ModalRoute modalRoute;

  InitialiseProfileEvent(this.feedId, this.appLoaded, this.modalRoute);
}

class ChangedProfileEventProfile extends ProfileEvent {
  final String? value;

  ChangedProfileEventProfile(this.value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedProfileEventProfile{ value: $value }';
}
