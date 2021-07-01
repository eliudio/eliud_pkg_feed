import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:eliud_pkg_follow/tools/follower_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliud_core/core/navigate/navigate_bloc.dart';
import 'package:eliud_core/core/navigate/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'avatar_helper.dart';

enum WhichFeed { MyFeed, OnlyMyFeed, SomeoneIFollow, SomeoneElse, PublicFeed }

class SwitchMember {
  static String switchMemberFeedPageParameter = 'memberId';

  static Widget gestured(BuildContext context, String switchToThisMemberId, String appId, String pageId, Widget avatar) {
    return GestureDetector(
        onTap: () {
          SwitchMember.switchMember(context, appId, pageId, switchToThisMemberId);
        },
        child: avatar);
  }

  static void switchMember(
      BuildContext context, String appId, String pageId, String memberId) {
    var _navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    _navigatorBloc.add(GoToPageEvent(appId, pageId, parameters: {
      switchMemberFeedPageParameter: memberId
    }));
  }
}
