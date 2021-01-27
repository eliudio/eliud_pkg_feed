import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';
import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Load Comments
class LoadCommentsEvent extends PostEvent {
  final PostModel postModel;
  final String memberId;

  LoadCommentsEvent(this.postModel, this.memberId);

  @override
  List<Object> get props => [ postModel, memberId ];
}

// Like Post Event
class LikePostEvent extends PostEvent {
  final PostModel postModel;
  final LikeType likeType;

  LikePostEvent(this.postModel, this.likeType);

  @override
  List<Object> get props => [ postModel, likeType ];
}

// Comment Events
// Add comment
class AddCommentEvent extends PostEvent {
  final PostModel postModel;
  final String comment;

  AddCommentEvent(this.postModel, this.comment);

  @override
  List<Object> get props => [ postModel, comment ];
}

// Delete comment
class DeleteCommentEvent extends PostEvent {
  final PostCommentModel deleteThis;

  DeleteCommentEvent(this.deleteThis);

  @override
  List<Object> get props => [ deleteThis ];
}

// Update comment
class UpdateCommentEvent extends PostEvent {
  final PostCommentModel updateThis;
  final String newValue;

  UpdateCommentEvent(this.updateThis, this.newValue);

  @override
  List<Object> get props => [ updateThis, newValue ];
}

