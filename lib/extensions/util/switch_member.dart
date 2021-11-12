import 'package:eliud_core/core/navigate/router.dart' as router;
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


enum WhichFeed { MyFeed, OnlyMyFeed, SomeoneIFollow, SomeoneElse, PublicFeed }

class SwitchMember {
  static String switchMemberFeedPageParameter = 'memberId';

  static Widget gestured(BuildContext context, String switchToThisMemberId,
      String currentMemberId, String appId, String pageId, Widget avatar) {
    return GestureDetector(
        onTap: () {
          SwitchMember.switchMember(
              context, appId, pageId, switchToThisMemberId, currentMemberId);
        },
        child: avatar);
  }

  static void switchMember(BuildContext context, String appId, String pageId,
      String memberId, String? currentMemberId) {
    router.Router.navigateTo(context, GotoPage(appId, pageID: pageId),
        parameters: currentMemberId == memberId
            ? null
            : {switchMemberFeedPageParameter: memberId});
  }
}
