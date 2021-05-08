import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';


abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class UndeterminedPostState extends PostState {
  UndeterminedPostState();
}

class ErrorPostState extends PostState {
  final String message;

  ErrorPostState(this.message);

  @override
  List<Object?> get props => [message];
}

class PostLoaded extends PostState {
  final PostModel? postModel;
  final String? memberId;

  PostLoaded({this.memberId, this.postModel});

  @override
  List<Object?> get props => [memberId, postModel];
}

class PostCommentContainer extends Equatable {
  final PostCommentModel ?postComment;
  final String ?dateTime;
  final MemberPublicInfoModel ?member;
  final String ?comment;
  final bool ?thisMemberLikesThisComment;

  // comments on this comment
  final List<PostCommentContainer?>? postCommentContainer;

  PostCommentContainer({this.postComment, this.dateTime, this.member, this.comment, this.thisMemberLikesThisComment, this.postCommentContainer});

  @override
  List<Object?> get props => [postComment, dateTime, member, comment, thisMemberLikesThisComment, postCommentContainer];

  PostCommentContainer copyWith({PostCommentModel? postComment, String? dateTime, MemberPublicInfoModel? member, String? comment, bool? thisMemberLikesThisComment, List<PostCommentContainer>? postCommentContainer}) {
    return PostCommentContainer(postComment: postComment ?? this.postComment, dateTime: dateTime ?? this.dateTime, member: member ?? this.member, comment : comment ?? this.comment, thisMemberLikesThisComment: thisMemberLikesThisComment ?? this.thisMemberLikesThisComment, postCommentContainer: postCommentContainer ?? this.postCommentContainer);
  }

}

// Eventually this should also be loaded paged, rather than all in 1 go.
// We'll do this when the app becomes successful and this is actually a real requirement
class CommentsLoaded extends PostLoaded {
  final List<PostCommentContainer?>? comments;
  final LikeType? thisMembersLikeType;

  CommentsLoaded({PostModel? postModel, String? memberId, this.comments, this.thisMembersLikeType}): super(memberId: memberId, postModel: postModel);

  @override
  List<Object?> get props => [memberId, postModel, comments];

  CommentsLoaded copyWith({PostModel? postModel, String? memberId, List<PostCommentContainer>? comments, LikeType? thisMembersLikeType}) {
    return CommentsLoaded(postModel: postModel ?? this.postModel, memberId: memberId ?? this. memberId, comments: comments ?? this.comments, thisMembersLikeType: thisMembersLikeType ?? this.thisMembersLikeType);
  }


}
