/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_storage/model/repository_export.dart';
import 'package:eliud_pkg_storage/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import 'package:eliud_pkg_storage/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import 'package:eliud_pkg_storage/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


@immutable
abstract class PostCommentFormEvent extends Equatable {
  const PostCommentFormEvent();

  @override
  List<Object> get props => [];
}

class InitialiseNewPostCommentFormEvent extends PostCommentFormEvent {
}


class InitialisePostCommentFormEvent extends PostCommentFormEvent {
  final PostCommentModel value;

  @override
  List<Object> get props => [ value ];

  InitialisePostCommentFormEvent({this.value});
}

class InitialisePostCommentFormNoLoadEvent extends PostCommentFormEvent {
  final PostCommentModel value;

  @override
  List<Object> get props => [ value ];

  InitialisePostCommentFormNoLoadEvent({this.value});
}

class ChangedPostCommentDocumentID extends PostCommentFormEvent {
  final String value;

  ChangedPostCommentDocumentID({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostCommentDocumentID{ value: $value }';
}

class ChangedPostCommentPostId extends PostCommentFormEvent {
  final String value;

  ChangedPostCommentPostId({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostCommentPostId{ value: $value }';
}

class ChangedPostCommentPostCommentId extends PostCommentFormEvent {
  final String value;

  ChangedPostCommentPostCommentId({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostCommentPostCommentId{ value: $value }';
}

class ChangedPostCommentMemberId extends PostCommentFormEvent {
  final String value;

  ChangedPostCommentMemberId({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostCommentMemberId{ value: $value }';
}

class ChangedPostCommentTimestamp extends PostCommentFormEvent {
  final String value;

  ChangedPostCommentTimestamp({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostCommentTimestamp{ value: $value }';
}

class ChangedPostCommentAppId extends PostCommentFormEvent {
  final String value;

  ChangedPostCommentAppId({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostCommentAppId{ value: $value }';
}

class ChangedPostCommentComment extends PostCommentFormEvent {
  final String value;

  ChangedPostCommentComment({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostCommentComment{ value: $value }';
}

class ChangedPostCommentLikes extends PostCommentFormEvent {
  final String value;

  ChangedPostCommentLikes({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostCommentLikes{ value: $value }';
}

class ChangedPostCommentDislikes extends PostCommentFormEvent {
  final String value;

  ChangedPostCommentDislikes({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostCommentDislikes{ value: $value }';
}

class ChangedPostCommentMemberImages extends PostCommentFormEvent {
  final List<MemberImageModel> value;

  ChangedPostCommentMemberImages({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostCommentMemberImages{ value: $value }';
}

