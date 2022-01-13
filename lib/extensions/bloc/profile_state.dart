import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileError &&
          runtimeType == other.runtimeType &&
          message == other.message;
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class ProfileStateUninitialized extends ProfileState {
  @override
  String toString() {
    return '''ProfileStateUninitialized()''';
  }

  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileStateUninitialized && runtimeType == other.runtimeType;
}

abstract class ProfileInitialised extends ProfileState {
  final String feedId;
  final AppModel app;
  final double? uploadingBGProgress;
  final double? uploadingProfilePhotoProgress;

  const ProfileInitialised(this.feedId, this.app, this.uploadingBGProgress,
      this.uploadingProfilePhotoProgress);

  String? memberId();

  bool canEditThisProfile();

  MemberProfileModel? watchingThisProfile();

  String? watchingThisMember();

  String profileUrl();
  String profileHTML();

  ProfileInitialised progressWith(
      {double? uploadingBGProgress, double? uploadingProfilePhotoProgress});
}

abstract class LoggedInProfileInitialized extends ProfileInitialised {
  final MemberProfileModel currentMemberProfileModel;
  final MemberModel currentMember;
  final PostAccessibleByGroup postAccessibleByGroup;
  final List<String>? postAccessibleByMembers;

  LoggedInProfileInitialized(
      String feedId,
      AppModel app,
      this.currentMemberProfileModel,
      this.currentMember,
      this.postAccessibleByGroup,
      this.postAccessibleByMembers,
      double? uploadingBGProgress,
      double? uploadingProfilePhotoProgress)
      : super(feedId, app, uploadingBGProgress, uploadingProfilePhotoProgress);

  @override
  String? memberId() => currentMember.documentID!;
}

class LoggedInWatchingMyProfile extends LoggedInProfileInitialized {
  final bool onlyMyPosts;

  LoggedInWatchingMyProfile({
    required String feedId,
    required AppModel app,
    required MemberProfileModel currentMemberProfileModel,
    required MemberModel currentMember,
    required PostAccessibleByGroup postAccessibleByGroup,
    List<String>? postAccessibleByMembers,
    required this.onlyMyPosts,
    required double? uploadingBGProgress,
    required double? uploadingProfilePhotoProgress,
  }) : super(
            feedId,
            app,
            currentMemberProfileModel,
            currentMember,
            postAccessibleByGroup,
            postAccessibleByMembers,
            uploadingBGProgress,
            uploadingProfilePhotoProgress);

  LoggedInWatchingMyProfile copyWith(
      {required MemberProfileModel newMemberProfileModel,
      double? uploadingBGProgress,
      double? uploadingProfilePhotoProgress}) {
    return LoggedInWatchingMyProfile(
      feedId: this.feedId,
      app: this.app,
      currentMemberProfileModel: newMemberProfileModel,
      currentMember: this.currentMember,
      postAccessibleByGroup: this.postAccessibleByGroup,
      postAccessibleByMembers: this.postAccessibleByMembers,
      onlyMyPosts: this.onlyMyPosts,
      uploadingBGProgress: uploadingBGProgress == null
          ? uploadingBGProgress
          : this.uploadingBGProgress,
      uploadingProfilePhotoProgress: uploadingProfilePhotoProgress == null
          ? uploadingProfilePhotoProgress
          : this.uploadingProfilePhotoProgress,
    );
  }

  LoggedInWatchingMyProfile progressWith(
      {double? uploadingBGProgress, double? uploadingProfilePhotoProgress}) {
    return LoggedInWatchingMyProfile(
      feedId: this.feedId,
      app: this.app,
      currentMemberProfileModel: this.currentMemberProfileModel,
      currentMember: this.currentMember,
      postAccessibleByGroup: this.postAccessibleByGroup,
      postAccessibleByMembers: this.postAccessibleByMembers,
      onlyMyPosts: this.onlyMyPosts,
      uploadingBGProgress: uploadingBGProgress == null
          ? this.uploadingBGProgress
          : uploadingBGProgress,
      uploadingProfilePhotoProgress: uploadingProfilePhotoProgress == null
          ? this.uploadingProfilePhotoProgress
          : uploadingProfilePhotoProgress,
    );
  }

  @override
  bool canEditThisProfile() => true;

  @override
  MemberProfileModel? watchingThisProfile() => currentMemberProfileModel;

  @override
  String profileHTML() {
    if (currentMemberProfileModel.profile != null) {
      return currentMemberProfileModel.profile!;
    } else {
      return '';
    }
  }

  @override
  String profileUrl() {
    if (currentMemberProfileModel.profileOverride != null) {
      return currentMemberProfileModel.profileOverride!;
    } else {
      return currentMember.photoURL!;
    }
  }

  @override
  List<Object?> get props => [
        feedId,
        app,
        currentMemberProfileModel,
        currentMember,
        postAccessibleByGroup,
        postAccessibleByMembers,
        uploadingBGProgress,
        uploadingProfilePhotoProgress
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedInWatchingMyProfile &&
          runtimeType == other.runtimeType &&
          feedId == other.feedId &&
          app == other.app &&
          currentMemberProfileModel == other.currentMemberProfileModel &&
          currentMember == other.currentMember &&
          postAccessibleByGroup == other.postAccessibleByGroup &&
          ListEquality().equals(postAccessibleByMembers, other.postAccessibleByMembers) &&
          uploadingBGProgress == other.uploadingBGProgress &&
          uploadingProfilePhotoProgress == other.uploadingProfilePhotoProgress;

  @override
  String? watchingThisMember() {
    return currentMember.documentID!;
  }
}

class LoggedInAndWatchingOtherProfile extends LoggedInProfileInitialized {
  final bool iFollowThisPerson;
  final MemberProfileModel feedProfileModel;
  final MemberPublicInfoModel feedPublicInfoModel;

  LoggedInAndWatchingOtherProfile(
      {required String feedId,
      required AppModel app,
      required MemberProfileModel currentMemberProfileModel,
      required MemberModel currentMember,
      required PostAccessibleByGroup postAccessibleByGroup,
      List<String>? postAccessibleByMembers,
      required this.feedProfileModel,
      required this.feedPublicInfoModel,
      required this.iFollowThisPerson,
      required double? uploadingBGProgress,
      required double? uploadingProfilePhotoProgress})
      : super(
            feedId,
            app,
            currentMemberProfileModel,
            currentMember,
      postAccessibleByGroup,
      postAccessibleByMembers,
            uploadingBGProgress,
            uploadingProfilePhotoProgress);

  @override
  bool canEditThisProfile() => false;

  @override
  MemberProfileModel? watchingThisProfile() => feedProfileModel;

  @override
  String profileHTML() {
    if (feedProfileModel.profile != null) {
      return feedProfileModel.profile!;
    } else {
      return '';
    }
  }

  @override
  String profileUrl() {
    if (feedProfileModel.profileOverride != null) {
      return feedProfileModel.profileOverride!;
    } else {
      return feedPublicInfoModel.photoURL!;
    }
  }

  @override
  List<Object?> get props => [
        feedId,
        app,
        currentMemberProfileModel,
        currentMember,
    postAccessibleByGroup,
    postAccessibleByMembers,
        iFollowThisPerson,
        feedProfileModel,
        feedPublicInfoModel,
        uploadingBGProgress,
        uploadingProfilePhotoProgress
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedInAndWatchingOtherProfile &&
          runtimeType == other.runtimeType &&
          feedId == other.feedId &&
          app == other.app &&
          currentMemberProfileModel == other.currentMemberProfileModel &&
          currentMember == other.currentMember &&
          postAccessibleByGroup == other.postAccessibleByGroup &&
          ListEquality().equals(postAccessibleByMembers, other.postAccessibleByMembers) &&
          iFollowThisPerson == other.iFollowThisPerson &&
          feedProfileModel == other.feedProfileModel &&
          feedPublicInfoModel == other.feedPublicInfoModel &&
          uploadingBGProgress == other.uploadingBGProgress &&
          uploadingProfilePhotoProgress == other.uploadingProfilePhotoProgress;

  @override
  String? watchingThisMember() {
    return feedPublicInfoModel.documentID!;
  }

  LoggedInAndWatchingOtherProfile progressWith(
      {double? uploadingBGProgress, double? uploadingProfilePhotoProgress}) {
    return LoggedInAndWatchingOtherProfile(
      feedId: this.feedId,
      app: this.app,
      currentMemberProfileModel: this.currentMemberProfileModel,
      currentMember: this.currentMember,
      postAccessibleByGroup: this.postAccessibleByGroup,
      postAccessibleByMembers: this.postAccessibleByMembers,
      feedProfileModel: this.feedProfileModel,
      feedPublicInfoModel: this.feedPublicInfoModel,
      iFollowThisPerson: this.iFollowThisPerson,
      uploadingBGProgress: uploadingBGProgress == null
          ? this.uploadingBGProgress
          : uploadingBGProgress,
      uploadingProfilePhotoProgress: uploadingProfilePhotoProgress == null
          ? this.uploadingProfilePhotoProgress
          : uploadingProfilePhotoProgress,
    );
  }
}

class NotLoggedInWatchingSomeone extends ProfileInitialised {
  final MemberProfileModel feedProfileModel;
  final MemberPublicInfoModel feedPublicInfoModel;

  NotLoggedInWatchingSomeone({
    required String feedId,
    required AppModel app,
    required this.feedProfileModel,
    required this.feedPublicInfoModel,
    required double? uploadingBGProgress,
    required double? uploadingProfilePhotoProgress,
  }) : super(feedId, app, uploadingBGProgress, uploadingProfilePhotoProgress);

  @override
  String? memberId() => null;

  @override
  bool canEditThisProfile() => false;

  @override
  MemberProfileModel? watchingThisProfile() => feedProfileModel;

  @override
  String profileHTML() {
    if (feedProfileModel.profile != null) {
      return feedProfileModel.profile!;
    } else {
      return '';
    }
  }

  @override
  String profileUrl() {
    if (feedProfileModel.profileOverride != null) {
      return feedProfileModel.profileOverride!;
    } else {
      return feedPublicInfoModel.photoURL!;
    }
  }

  @override
  List<Object?> get props => [
        feedId,
        app,
        feedProfileModel,
        feedPublicInfoModel,
        uploadingBGProgress,
        uploadingProfilePhotoProgress
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotLoggedInWatchingSomeone &&
          runtimeType == other.runtimeType &&
          feedId == other.feedId &&
          feedProfileModel == other.feedProfileModel &&
          feedPublicInfoModel == other.feedPublicInfoModel &&
          uploadingBGProgress == other.uploadingBGProgress &&
          uploadingProfilePhotoProgress == other.uploadingProfilePhotoProgress;

  @override
  String? watchingThisMember() {
    return feedPublicInfoModel.documentID!;
  }

  @override
  NotLoggedInWatchingSomeone progressWith(
      {double? uploadingBGProgress, double? uploadingProfilePhotoProgress}) {
    return NotLoggedInWatchingSomeone(
      feedId: this.feedId,
      app: this.app,
      feedProfileModel: this.feedProfileModel,
      feedPublicInfoModel: this.feedPublicInfoModel,
      uploadingBGProgress: uploadingBGProgress == null
          ? this.uploadingBGProgress
          : uploadingBGProgress,
      uploadingProfilePhotoProgress: uploadingProfilePhotoProgress == null
          ? this.uploadingProfilePhotoProgress
          : uploadingProfilePhotoProgress,
    );
  }
}

class WatchingPublicProfile extends ProfileInitialised {
  WatchingPublicProfile(
      {required String feedId,
      required AppModel app,
      required double? uploadingBGProgress,
      required double? uploadingProfilePhotoProgress})
      : super(feedId, app, uploadingBGProgress, uploadingProfilePhotoProgress);

  String? memberId() => null;

  @override
  bool canEditThisProfile() => false;

  @override
  MemberProfileModel? watchingThisProfile() => null;

  @override
  String profileHTML() {
    return '';
  }

  @override
  String profileUrl() {
    return '';
  }

  @override
  List<Object?> get props =>
      [feedId, app, uploadingBGProgress, uploadingProfilePhotoProgress];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchingPublicProfile &&
          runtimeType == other.runtimeType &&
          feedId == other.feedId &&
          app == other.app &&
          uploadingBGProgress == other.uploadingBGProgress &&
          uploadingProfilePhotoProgress == other.uploadingProfilePhotoProgress;

  @override
  String? watchingThisMember() {
    return null;
  }

  @override
  ProfileInitialised progressWith(
      {double? uploadingBGProgress, double? uploadingProfilePhotoProgress}) {
    return WatchingPublicProfile(
        feedId: this.feedId,
        app: this.app,
        uploadingBGProgress: this.uploadingBGProgress,
        uploadingProfilePhotoProgress: this.uploadingProfilePhotoProgress);
  }
}
