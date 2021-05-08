import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'post_state.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCommentsEvent extends PostEvent {
  final PostModel postModel;
  final String memberId;

  LoadCommentsEvent(this.postModel, this.memberId);

  @override
  List<Object> get props => [ postModel, memberId ];
}

class LikePostEvent extends PostEvent {
  final PostModel postModel;
  final LikeType likeType;

  LikePostEvent(this.postModel, this.likeType);

  @override
  List<Object> get props => [ postModel, likeType ];
}

class LikeCommentPostEvent extends PostEvent {
  final PostModel postModel;
//  final PostCommentModel postCommentModel;
  final PostCommentContainer postCommentContainer;
  final LikeType likeType;

  LikeCommentPostEvent(this.postModel, this.postCommentContainer, this.likeType);

  @override
  List<Object> get props => [ postModel, postCommentContainer, likeType ];
}

class DeletePostEvent extends PostEvent {
  final PostModel postModel;

  DeletePostEvent(this.postModel);

  @override
  List<Object> get props => [ postModel ];
}

class AddCommentEvent extends PostEvent {
  final PostModel postModel;
  final String comment;

  AddCommentEvent(this.postModel, this.comment);

  @override
  List<Object> get props => [ postModel, comment ];
}

class AddCommentCommentEvent extends PostEvent {
  final PostModel postModel;
  final PostCommentContainer postCommentContainer;
  final String comment;

  AddCommentCommentEvent(this.postModel, this.postCommentContainer, this.comment);

  @override
  List<Object> get props => [ postCommentContainer, comment ];
}

class DeleteCommentEvent extends PostEvent {
  final PostModel postModel;
  final PostCommentModel deleteThis;

  DeleteCommentEvent(this.postModel, this.deleteThis);

  @override
  List<Object> get props => [ deleteThis ];
}

class UpdateCommentEvent extends PostEvent {
  final PostModel postModel;
  final PostCommentModel updateThis;
  final String newValue;

  UpdateCommentEvent(this.postModel, this.updateThis, this.newValue);

  @override
  List<Object> get props => [ updateThis, newValue ];
}

class UpdatePostEvent extends PostEvent {
  final PostModel postModel;
  final String comment;

  UpdatePostEvent(this.postModel, this.comment);

  @override
  List<Object> get props => [ postModel, comment ];
}