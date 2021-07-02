import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
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
  final String appId;

  const ProfileInitialised(this.feedId, this.appId);

  String? memberId();

  bool canEditThisProfile();

  MemberProfileModel? watchingThisProfile();

  String? watchingThisMember();

  String profileUrl();
  String profileHTML();
}

abstract class LoggedInProfileInitialized extends ProfileInitialised {
  final MemberProfileModel currentMemberProfileModel;
  final MemberModel currentMember;
  final List<String> defaultReadAccess;

  LoggedInProfileInitialized(
      String feedId,
      String appId,
      this.currentMemberProfileModel,
      this.currentMember,
      this.defaultReadAccess)
      : super(feedId, appId);

  @override
  String? memberId() => currentMember.documentID!;
}

class LoggedInWatchingMyProfile extends LoggedInProfileInitialized {
  final bool onlyMyPosts;

  LoggedInWatchingMyProfile(
      {required String feedId,
      required String appId,
      required MemberProfileModel currentMemberProfileModel,
      required MemberModel currentMember,
      required List<String> defaultReadAccess,
      required this.onlyMyPosts})
      : super(feedId, appId, currentMemberProfileModel, currentMember,
            defaultReadAccess);

  LoggedInWatchingMyProfile copyWith(
      {required MemberProfileModel newMemberProfileModel}) {
    return LoggedInWatchingMyProfile(
      feedId: this.feedId,
      appId: this.appId,
      currentMemberProfileModel: newMemberProfileModel,
      currentMember: this.currentMember,
      defaultReadAccess: this.defaultReadAccess,
      onlyMyPosts: this.onlyMyPosts,
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
        appId,
        currentMemberProfileModel,
        currentMember,
        defaultReadAccess
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedInWatchingMyProfile &&
          runtimeType == other.runtimeType &&
          feedId == other.feedId &&
          appId == other.appId &&
          currentMemberProfileModel == other.currentMemberProfileModel &&
          currentMember == other.currentMember &&
          ListEquality().equals(defaultReadAccess, other.defaultReadAccess);

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
      required String appId,
      required MemberProfileModel currentMemberProfileModel,
      required MemberModel currentMember,
      required List<String> defaultReadAccess,
      required this.feedProfileModel,
      required this.feedPublicInfoModel,
      required this.iFollowThisPerson})
      : super(feedId, appId, currentMemberProfileModel, currentMember,
            defaultReadAccess);

  @override
  bool canEditThisProfile() => true;

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
        appId,
        currentMemberProfileModel,
        currentMember,
        defaultReadAccess,
        iFollowThisPerson,
        feedProfileModel,
        feedPublicInfoModel
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedInAndWatchingOtherProfile &&
          runtimeType == other.runtimeType &&
          feedId == other.feedId &&
          appId == other.appId &&
          currentMemberProfileModel == other.currentMemberProfileModel &&
          currentMember == other.currentMember &&
          ListEquality().equals(defaultReadAccess, other.defaultReadAccess) &&
          iFollowThisPerson == other.iFollowThisPerson &&
          feedProfileModel == other.feedProfileModel &&
          feedPublicInfoModel == other.feedPublicInfoModel;


  @override
  String? watchingThisMember() {
    return feedProfileModel.documentID!;
  }
}

class NotLoggedInWatchingSomeone extends ProfileInitialised {
  final MemberProfileModel feedProfileModel;
  final MemberPublicInfoModel feedPublicInfoModel;

  NotLoggedInWatchingSomeone(
      {required String feedId,
      required String appId,
      required this.feedProfileModel,
      required this.feedPublicInfoModel})
      : super(feedId, appId);

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
        appId,
        feedProfileModel,
        feedPublicInfoModel,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotLoggedInWatchingSomeone &&
          runtimeType == other.runtimeType &&
          feedId == other.feedId &&
          feedProfileModel == other.feedProfileModel &&
          feedPublicInfoModel == other.feedPublicInfoModel;

  @override
  String? watchingThisMember() {
    return feedPublicInfoModel.documentID!;
  }
}

class WatchingPublicProfile extends ProfileInitialised {
  WatchingPublicProfile({required String feedId, required String appId})
      : super(feedId, appId);

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
  List<Object?> get props => [feedId, appId];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchingPublicProfile &&
          runtimeType == other.runtimeType &&
          feedId == other.feedId &&
          appId == other.appId;

  @override
  String? watchingThisMember() {
    return null;
  }
}
