import 'package:eliud_core/core/navigate/router.dart' as router;
import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum WhichFeed { myFeed, onlyMyFeed, someoneIFollow, someoneElse, publicFeed }

class SwitchMember {
  static String switchMemberFeedPageParameter = 'memberId';

  static Widget gestured(BuildContext context, String switchToThisMemberId,
      String currentMemberId, AppModel app, String pageId, Widget avatar) {
    return GestureDetector(
        onTap: () {
          SwitchMember.switchMember(
              context, app, pageId, switchToThisMemberId, currentMemberId);
        },
        child: avatar);
  }

  static void switchMember(BuildContext context, AppModel app, String pageId,
      String memberId, String? currentMemberId) {
    router.Router.navigateTo(context, GotoPage(app, pageID: pageId),
        parameters: currentMemberId == memberId
            ? null
            : {switchMemberFeedPageParameter: memberId});
  }
}
