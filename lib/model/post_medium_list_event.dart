/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_medium_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';

abstract class PostMediumListEvent extends Equatable {
  const PostMediumListEvent();
  @override
  List<Object?> get props => [];
}

class LoadPostMediumList extends PostMediumListEvent {}

class NewPage extends PostMediumListEvent {}

class AddPostMediumList extends PostMediumListEvent {
  final PostMediumModel? value;

  const AddPostMediumList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddPostMediumList{ value: $value }';
}

class UpdatePostMediumList extends PostMediumListEvent {
  final PostMediumModel? value;

  const UpdatePostMediumList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'UpdatePostMediumList{ value: $value }';
}

class DeletePostMediumList extends PostMediumListEvent {
  final PostMediumModel? value;

  const DeletePostMediumList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'DeletePostMediumList{ value: $value }';
}

class PostMediumListUpdated extends PostMediumListEvent {
  final List<PostMediumModel?>? value;
  final bool? mightHaveMore;

  const PostMediumListUpdated({ this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore ];

  @override
  String toString() => 'PostMediumListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

