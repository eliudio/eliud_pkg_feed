/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';

abstract class FeedListEvent extends Equatable {
  const FeedListEvent();
  @override
  List<Object> get props => [];
}

class LoadFeedList extends FeedListEvent {}
class LoadFeedListWithDetails extends FeedListEvent {}

class AddFeedList extends FeedListEvent {
  final FeedModel value;

  const AddFeedList({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'AddFeedList{ value: $value }';
}

class UpdateFeedList extends FeedListEvent {
  final FeedModel value;

  const UpdateFeedList({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'UpdateFeedList{ value: $value }';
}

class DeleteFeedList extends FeedListEvent {
  final FeedModel value;

  const DeleteFeedList({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'DeleteFeedList{ value: $value }';
}

class FeedListUpdated extends FeedListEvent {
  final List<FeedModel> value;

  const FeedListUpdated({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'FeedListUpdated{ value: $value }';
}

