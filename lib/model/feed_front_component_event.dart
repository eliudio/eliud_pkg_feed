/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_front_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';

abstract class FeedFrontComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFeedFrontComponent extends FeedFrontComponentEvent {
  final String? id;

  FetchFeedFrontComponent({this.id});
}

class FeedFrontComponentUpdated extends FeedFrontComponentEvent {
  final FeedFrontModel value;

  FeedFrontComponentUpdated({required this.value});
}
