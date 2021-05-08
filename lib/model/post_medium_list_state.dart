/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_medium_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';

abstract class PostMediumListState extends Equatable {
  const PostMediumListState();

  @override
  List<Object?> get props => [];
}

class PostMediumListLoading extends PostMediumListState {}

class PostMediumListLoaded extends PostMediumListState {
  final List<PostMediumModel?>? values;
  final bool? mightHaveMore;

  const PostMediumListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'PostMediumListLoaded { values: $values }';
}

class PostMediumNotLoaded extends PostMediumListState {}

