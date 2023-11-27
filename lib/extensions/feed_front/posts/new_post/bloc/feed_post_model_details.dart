import 'package:eliud_core_model/model/member_medium_container_model.dart';
import 'package:eliud_pkg_feed_model/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

class FeedPostModelDetails extends Equatable {
  final String description;
  final List<MemberMediumContainerModel> memberMedia;
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<String>? postAccessibleByMembers;

  FeedPostModelDetails(
      {required this.description,
      required this.memberMedia,
      required this.postAccessibleByGroup,
      this.postAccessibleByMembers});

  FeedPostModelDetails copyWith(
      {String? description,
      List<MemberMediumContainerModel>? memberMedia,
      PostAccessibleByGroup? postAccessibleByGroup,
      List<String>? postAccessibleByMembers}) {
    return FeedPostModelDetails(
        description: description ?? this.description,
        memberMedia: memberMedia ?? this.memberMedia,
        postAccessibleByGroup:
            postAccessibleByGroup ?? this.postAccessibleByGroup,
        postAccessibleByMembers: postAccessibleByMembers == null
            ? this.postAccessibleByMembers
            : postAccessibleByMembers.isNotEmpty
                ? postAccessibleByMembers
                : null);
  }

  @override
  List<Object?> get props => [
        description,
        memberMedia,
        postAccessibleByGroup,
        postAccessibleByMembers,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedPostModelDetails &&
          runtimeType == other.runtimeType &&
          description == other.description &&
          ListEquality().equals(memberMedia, other.memberMedia) &&
          postAccessibleByGroup == other.postAccessibleByGroup &&
          ListEquality()
              .equals(postAccessibleByMembers, other.postAccessibleByMembers);

  @override
  int get hashCode =>
      description.hashCode ^
      memberMedia.hashCode ^
      postAccessibleByGroup.hashCode ^
      postAccessibleByMembers.hashCode;
}
