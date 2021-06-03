import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class ProfileStateUninitialized extends ProfileState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''ProfileStateUninitialized()''';
  }
}

class ProfileInitialised extends ProfileState {
  final String feedId;
  final String appId;
  final List<String> _readAccess;
  final MemberProfileModel memberProfileModel;
  final SwitchFeedHelper switchFeedHelper;

  @override
  List<Object?> get props => [ feedId, appId, _readAccess, memberProfileModel, switchFeedHelper ];

  const ProfileInitialised(this.feedId, this.appId, this._readAccess, this.memberProfileModel, this.switchFeedHelper);

  bool allowedToUpdate() {
    return switchFeedHelper.memberCurrent != null && switchFeedHelper.memberOfFeed.documentID ==
        switchFeedHelper.memberCurrent!.documentID!;
  }

  String ownerId() {
    return switchFeedHelper.feedMember().documentID!;
  }

  String html() {
    return memberProfileModel.profile!;
  }

  List<String> readAccess() {
    return _readAccess == null ? ['PUBLIC'] : _readAccess!;
  }

  ProfileInitialised copyWith({required MemberProfileModel newMemberProfileModel}) {
    return ProfileInitialised(feedId, appId, _readAccess, newMemberProfileModel, switchFeedHelper );
  }
}
