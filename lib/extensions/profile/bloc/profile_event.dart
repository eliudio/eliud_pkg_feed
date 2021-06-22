import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
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

class ProfileChangedProfileEvent extends ProfileEvent {
  final String? value;

  ProfileChangedProfileEvent(this.value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedProfileEventProfile{ value: $value }';
}

class ProfilePhotoChangedProfileEvent extends ProfileEvent {
  final MemberMediumModel value;

  ProfilePhotoChangedProfileEvent(this.value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ProfilePhotoChangedProfileEvent{ value: $value }';
}

class ProfileBGPhotoChangedProfileEvent extends ProfileEvent {
  final MemberMediumModel value;

  ProfileBGPhotoChangedProfileEvent(this.value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ProfileBGPhotoChangedProfileEvent{ value: $value }';
}