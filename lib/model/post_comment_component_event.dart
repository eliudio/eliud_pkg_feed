/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';

abstract class PostCommentComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPostCommentComponent extends PostCommentComponentEvent {
  final String? id;

  FetchPostCommentComponent({ this.id });
}

