/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 profile_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

abstract class ProfileListState extends Equatable {
  const ProfileListState();

  @override
  List<Object?> get props => [];
}

class ProfileListLoading extends ProfileListState {}

class ProfileListLoaded extends ProfileListState {
  final List<ProfileModel?>? values;
  final bool? mightHaveMore;

  const ProfileListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'ProfileListLoaded { values: $values }';
}

class ProfileNotLoaded extends ProfileListState {}

