/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';

abstract class PostLikeComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPostLikeComponent extends PostLikeComponentEvent {
  final String id;

  FetchPostLikeComponent({ this.id });
}
