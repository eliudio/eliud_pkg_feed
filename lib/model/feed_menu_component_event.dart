/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';

abstract class FeedMenuComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFeedMenuComponent extends FeedMenuComponentEvent {
  final String? id;

  FetchFeedMenuComponent({ this.id });
}

class FeedMenuComponentUpdated extends FeedMenuComponentEvent {
  final FeedMenuModel value;

  FeedMenuComponentUpdated({ required this.value });
}


