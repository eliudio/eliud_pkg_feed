import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';
import 'package:equatable/equatable.dart';


abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class UndeterminedPostState extends PostState {
  UndeterminedPostState();
}

class PostLoaded extends PostState {
  final PostModel postModel;
  final String memberId;

  PostLoaded({this.memberId, this.postModel});

  @override
  List<Object> get props => [memberId, postModel];
}

class PostCommentContainer extends Equatable {
  final PostCommentModel postComment;
  final String dateTime;
  final MemberPublicInfoModel member;
  final String comment;

  PostCommentContainer({this.postComment, this.dateTime, this.member, this.comment});

  @override
  List<Object> get props => [postComment, dateTime, member, comment];
}

// Eventually this should also be loaded paged, rather than all in 1 go.
// We'll do this when the app becomes successful and this is actually a real requirement
class CommentsLoaded extends PostLoaded {
  final List<PostCommentContainer> comments;
  final LikeType thisMembersLikeType;

  CommentsLoaded({PostModel postModel, String memberId, this.comments, this.thisMembersLikeType}): super(memberId: memberId, postModel: postModel);

  @override
  List<Object> get props => [memberId, postModel, comments];
}
