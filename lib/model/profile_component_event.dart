/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 profile_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';

abstract class ProfileComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProfileComponent extends ProfileComponentEvent {
  final String? id;

  FetchProfileComponent({this.id});
}

class ProfileComponentUpdated extends ProfileComponentEvent {
  final ProfileModel value;

  ProfileComponentUpdated({required this.value});
}
