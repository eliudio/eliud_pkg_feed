/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_front_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';

abstract class FeedFrontComponentState extends Equatable {
  const FeedFrontComponentState();

  @override
  List<Object?> get props => [];
}

class FeedFrontComponentUninitialized extends FeedFrontComponentState {}

class FeedFrontComponentError extends FeedFrontComponentState {
  final String? message;
  FeedFrontComponentError({ this.message });
}

class FeedFrontComponentPermissionDenied extends FeedFrontComponentState {
  FeedFrontComponentPermissionDenied();
}

class FeedFrontComponentLoaded extends FeedFrontComponentState {
  final FeedFrontModel value;

  const FeedFrontComponentLoaded({ required this.value });

  FeedFrontComponentLoaded copyWith({ FeedFrontModel? copyThis }) {
    return FeedFrontComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'FeedFrontComponentLoaded { value: $value }';
}

