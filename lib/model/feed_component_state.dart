/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';

abstract class FeedComponentState extends Equatable {
  const FeedComponentState();

  @override
  List<Object> get props => [];
}

class FeedComponentUninitialized extends FeedComponentState {}

class FeedComponentError extends FeedComponentState {
  final String message;
  FeedComponentError({ this.message });
}

class FeedComponentLoaded extends FeedComponentState {
  final FeedModel value;

  const FeedComponentLoaded({ this.value });

  FeedComponentLoaded copyWith({ FeedModel copyThis }) {
    return FeedComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'FeedComponentLoaded { value: $value }';
}


