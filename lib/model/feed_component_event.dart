/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';

abstract class FeedComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFeedComponent extends FeedComponentEvent {
  final String? id;

  FetchFeedComponent({ this.id });
}

class FeedComponentUpdated extends FeedComponentEvent {
  final FeedModel value;

  FeedComponentUpdated({ required this.value });
}


