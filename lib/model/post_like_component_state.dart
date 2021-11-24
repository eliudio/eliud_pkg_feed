/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';

abstract class PostLikeComponentState extends Equatable {
  const PostLikeComponentState();

  @override
  List<Object?> get props => [];
}

class PostLikeComponentUninitialized extends PostLikeComponentState {}

class PostLikeComponentError extends PostLikeComponentState {
  final String? message;
  PostLikeComponentError({ this.message });
}

class PostLikeComponentPermissionDenied extends PostLikeComponentState {
  PostLikeComponentPermissionDenied();
}

class PostLikeComponentLoaded extends PostLikeComponentState {
  final PostLikeModel value;

  const PostLikeComponentLoaded({ required this.value });

  PostLikeComponentLoaded copyWith({ PostLikeModel? copyThis }) {
    return PostLikeComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'PostLikeComponentLoaded { value: $value }';
}

