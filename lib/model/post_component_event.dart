/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

abstract class PostComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPostComponent extends PostComponentEvent {
  final String? id;

  FetchPostComponent({this.id});
}

class PostComponentUpdated extends PostComponentEvent {
  final PostModel value;

  PostComponentUpdated({required this.value});
}
