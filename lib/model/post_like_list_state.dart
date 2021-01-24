/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';

abstract class PostLikeListState extends Equatable {
  const PostLikeListState();

  @override
  List<Object> get props => [];
}

class PostLikeListLoading extends PostLikeListState {}

class PostLikeListLoaded extends PostLikeListState {
  final List<PostLikeModel> values;
  final bool mightHaveMore;

  const PostLikeListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'PostLikeListLoaded { values: $values }';
}

class PostLikeNotLoaded extends PostLikeListState {}

