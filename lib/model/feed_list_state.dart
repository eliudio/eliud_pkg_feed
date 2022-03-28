/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';

abstract class FeedListState extends Equatable {
  const FeedListState();

  @override
  List<Object?> get props => [];
}

class FeedListLoading extends FeedListState {}

class FeedListLoaded extends FeedListState {
  final List<FeedModel?>? values;
  final bool? mightHaveMore;

  const FeedListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'FeedListLoaded { values: $values }';

  @override
  bool operator ==(Object other) => 
          other is FeedListLoaded &&
              runtimeType == other.runtimeType &&
              ListEquality().equals(values, other.values) &&
              mightHaveMore == other.mightHaveMore;
}

class FeedNotLoaded extends FeedListState {}

