/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

abstract class PostComponentState extends Equatable {
  const PostComponentState();

  @override
  List<Object?> get props => [];
}

class PostComponentUninitialized extends PostComponentState {}

class PostComponentError extends PostComponentState {
  final String? message;
  PostComponentError({ this.message });
}

class PostComponentPermissionDenied extends PostComponentState {
  PostComponentPermissionDenied();
}

class PostComponentLoaded extends PostComponentState {
  final PostModel? value;

  const PostComponentLoaded({ this.value });

  PostComponentLoaded copyWith({ PostModel? copyThis }) {
    return PostComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'PostComponentLoaded { value: $value }';
}

