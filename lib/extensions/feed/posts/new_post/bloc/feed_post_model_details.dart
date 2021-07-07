import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

class FeedPostModelDetails extends Equatable {
  final String description;
  // final List<MemberMediumModel> memberMedia;
  final List<PostMediumModel> memberMedia;
  final PostPrivilege postPrivilege;
  //final List<String> readAccess;

  FeedPostModelDetails({required this.description, required this.memberMedia, required this.postPrivilege/*, required this.readAccess*/});

  FeedPostModelDetails copyWith({String? description, List<PostMediumModel>? memberMedia, PostPrivilege? postPrivilege/*, List<String>? readAccess*/}) {
    return FeedPostModelDetails(description: description ?? this.description, memberMedia: memberMedia ?? this.memberMedia, postPrivilege: postPrivilege ?? this.postPrivilege/*, readAccess: readAccess ?? this.readAccess*/);
  }

  @override
  List<Object?> get props => [description, memberMedia, postPrivilege];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is FeedPostModelDetails &&
              runtimeType == other.runtimeType &&
              description == other.description &&
              ListEquality().equals(memberMedia, other.memberMedia) &&
              postPrivilege == other.postPrivilege;
}