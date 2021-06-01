/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';

abstract class FeedMenuComponentState extends Equatable {
  const FeedMenuComponentState();

  @override
  List<Object?> get props => [];
}

class FeedMenuComponentUninitialized extends FeedMenuComponentState {}

class FeedMenuComponentError extends FeedMenuComponentState {
  final String? message;
  FeedMenuComponentError({ this.message });
}

class FeedMenuComponentPermissionDenied extends FeedMenuComponentState {
  FeedMenuComponentPermissionDenied();
}

class FeedMenuComponentLoaded extends FeedMenuComponentState {
  final FeedMenuModel? value;

  const FeedMenuComponentLoaded({ this.value });

  FeedMenuComponentLoaded copyWith({ FeedMenuModel? copyThis }) {
    return FeedMenuComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'FeedMenuComponentLoaded { value: $value }';
}

