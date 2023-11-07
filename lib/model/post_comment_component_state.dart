/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';

abstract class PostCommentComponentState extends Equatable {
  const PostCommentComponentState();

  @override
  List<Object?> get props => [];
}

class PostCommentComponentUninitialized extends PostCommentComponentState {}

class PostCommentComponentError extends PostCommentComponentState {
  final String? message;
  PostCommentComponentError({this.message});
}

class PostCommentComponentPermissionDenied extends PostCommentComponentState {
  PostCommentComponentPermissionDenied();
}

class PostCommentComponentLoaded extends PostCommentComponentState {
  final PostCommentModel value;

  const PostCommentComponentLoaded({required this.value});

  PostCommentComponentLoaded copyWith({PostCommentModel? copyThis}) {
    return PostCommentComponentLoaded(value: copyThis ?? value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'PostCommentComponentLoaded { value: $value }';
}
