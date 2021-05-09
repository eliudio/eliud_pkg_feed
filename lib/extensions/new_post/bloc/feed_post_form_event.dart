/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';

@immutable
abstract class FeedPostFormEvent extends Equatable {
  const FeedPostFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewFeedPostFormEvent extends FeedPostFormEvent {
}


class InitialiseFeedPostFormEvent extends FeedPostFormEvent {
  final PostModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseFeedPostFormEvent({this.value});
}

class InitialiseFeedPostFormNoLoadEvent extends FeedPostFormEvent {
  final PostModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseFeedPostFormNoLoadEvent({this.value});
}

class ChangedFeedPostDescription extends FeedPostFormEvent {
  final String? value;

  ChangedFeedPostDescription({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedPostDescription{ value: $value }';
}

class ChangedFeedPostLikes extends FeedPostFormEvent {
  final String? value;

  ChangedFeedPostLikes({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedPostLikes{ value: $value }';
}

class ChangedFeedPostMemberMedia extends FeedPostFormEvent {
  final List<PostMediumModel>? value;

  ChangedFeedPostMemberMedia({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedPostMemberMedia{ value: $value }';
}

