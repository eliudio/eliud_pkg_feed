import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:flutter/material.dart';

class ProfileHelper {
  final String feedId;
  final String appId;
  final List<String> readAccess;
  final MemberProfileModel memberProfileModel;
  final SwitchFeedHelper switchFeedHelper;

  ProfileHelper(this.feedId, this.readAccess, this.memberProfileModel,
      this.switchFeedHelper, this.appId);

  static Future<ProfileHelper?> getProfileInformation(BuildContext context,
      String feedId, AccessState accessState, String appId) async {
    if (accessState is LoggedIn) {
      var pageContextInfo = PageParamHelper.getPagaContextInfo(context);
      var readAccess = await PostFollowersHelper.asPublic(accessState);
      var switchFeedHelper =
          await SwitchFeedHelper.construct(pageContextInfo, accessState);
      var query = EliudQuery()
          .withCondition(EliudQueryCondition('feedId', isEqualTo: feedId))
          .withCondition(EliudQueryCondition('readAccess',
              arrayContainsAny: ['PUBLIC', switchFeedHelper.currentMember().documentID]));
      //EliudQueryCondition('authorId', isEqualTo: switchFeedHelper.memberCurrent.documentID),
      var valuesList = await memberProfileRepository(appId: appId)!
          .valuesListWithDetails(eliudQuery: query);
      if (valuesList.length > 1) {
        // In theory a person can create multiple profiles. However, we use the first only.
        var memberProfileModel = valuesList[0];
        return ProfileHelper(
            feedId, readAccess, memberProfileModel!, switchFeedHelper, appId);
      } else {
        return null;
      }
    } else {
      throw Exception("Not logged on, so I can't retrieve profile");
    }
  }

  Future<MemberProfileModel> updateProfile(String value) async {
    var newMemberProfileModel = await memberProfileRepository(appId: appId)!
        .update(memberProfileModel.copyWith(profile: value));
    return newMemberProfileModel;
  }
}
