import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/tools/post_helper.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PostCommentContainer {
  final String dateTime;
  final MemberPublicInfoModel member;
  final String comment;

  PostCommentContainer({this.dateTime, this.member, this.comment});

  @override
  List<Object> get props => [member.documentID, comment];
}

class PostListModel {
  final PostModel postModel;
  final String memberId;
  final List<PostCommentContainer> comments;
  final LikeType thisMembersLikeType;

  PostListModel(this.postModel, this.memberId, this.comments, this.thisMembersLikeType, );
}
