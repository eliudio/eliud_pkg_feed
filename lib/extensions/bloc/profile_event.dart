import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_container_model.dart';
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
  final AppModel app;
  final String feedId;
  final AccessDetermined accessDetermined;
  final ModalRoute modalRoute;

  InitialiseProfileEvent(this.app, this.feedId, this.accessDetermined, this.modalRoute);
}

class ProfileChangedProfileEvent extends ProfileEvent {
  final String? html;
  final List<MemberMediumContainerModel> memberMedia;

  ProfileChangedProfileEvent(this.html, this.memberMedia);

  @override
  List<Object?> get props => [ html, memberMedia ];

  @override
  String toString() => 'ChangedProfileEventProfile{ value: $html, memberMedia: $memberMedia }';
}

class ProfilePhotoChangedProfileEvent extends ProfileEvent {
  final MemberMediumModel value;

  ProfilePhotoChangedProfileEvent(this.value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ProfilePhotoChangedProfileEvent{ value: $value }';
}

class UploadingProfilePhotoEvent extends ProfileEvent {
  final double? progress;

  UploadingProfilePhotoEvent(this.progress);

  @override
  List<Object?> get props => [ progress ];

  @override
  String toString() => 'UploadingProfilePhotoEvent{ value: $progress }';
}

class ProfileBGPhotoChangedProfileEvent extends ProfileEvent {
  final MemberMediumModel value;

  ProfileBGPhotoChangedProfileEvent(this.value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ProfileBGPhotoChangedProfileEvent{ value: $value }';
}

class UploadingBGPhotoEvent extends ProfileEvent {
  final double? progress;

  UploadingBGPhotoEvent(this.progress);

  @override
  List<Object?> get props => [ progress ];

  @override
  String toString() => 'UploadingProfilePhotoEvent{ value: $progress }';
}

