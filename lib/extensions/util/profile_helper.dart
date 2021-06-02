import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:flutter/material.dart';

class ProfileHelper {
  final String appId;
  final List<String> readAccess;
  final MemberProfileModel memberProfileModel;
  final SwitchFeedHelper switchFeedHelper;

  ProfileHelper(this.readAccess, this.memberProfileModel, this.switchFeedHelper, this.appId);

  static Future<ProfileHelper> getProfileInformation(BuildContext context,
      AccessState accessState, String appId) async {
    if (accessState is LoggedIn) {
      var pageContextInfo = PageParamHelper.getPagaContextInfo(context);
      var readAccess = await PostFollowersHelper.asPublic(accessState);
      var switchFeedHelper = await SwitchFeedHelper.construct(pageContextInfo, accessState);
      var memberProfileModel = await memberProfileRepository(appId: appId)!.get(
          switchFeedHelper.memberOfFeed.documentID);
      return ProfileHelper(readAccess, memberProfileModel!, switchFeedHelper, appId);
    } else {
      throw Exception("Not logged on, so I can't retrieve profile");
    }
  }

  Future<MemberProfileModel> updateProfile(String value) async {
      var newMemberProfileModel = await memberProfileRepository(appId: appId)!.update(
          memberProfileModel.copyWith(profile: value));
      return newMemberProfileModel;
  }
}
