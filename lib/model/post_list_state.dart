/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

abstract class PostListState extends Equatable {
  const PostListState();

  @override
  List<Object> get props => [];
}

class PostListLoading extends PostListState {}

class PostListLoaded extends PostListState {
  final List<PostModel> values;
  final bool mightHaveMore;

  const PostListLoaded({this.values = const [], this.mightHaveMore});

  @override
  List<Object> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'PostListLoaded { values: $values, mightHaveMore: $mightHaveMore }';
}

class PostNotLoaded extends PostListState {}

