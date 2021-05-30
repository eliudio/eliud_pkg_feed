import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_pkg_follow/tools/follower_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliud_core/core/navigate/navigate_bloc.dart';
import 'package:eliud_core/core/navigate/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum WhichFeed {
  MyFeed, OnlyMyFeed, SomeoneIFollow, SomeoneElse
}

class SwitchFeedHelper {
  static String switchMemberFeedPageParameter = 'memberId';
  final PageContextInfo pageContextInfo;
  final LoggedIn loggedIn;

  // when watching your own feed, you can
  // * watch your feed and everybody who posted to your feed,
  // or
  // * watch your feed only.
  // This flag is to indicate you just want to watch your own feed.
  final bool? watchOnlyMyFeed;

  SwitchFeedHelper(this.pageContextInfo, this.loggedIn, {this.watchOnlyMyFeed});

  Widget gestured(BuildContext context, String switchToThisMemberId, Widget avatar) {
    return GestureDetector(
        onTap: () {
          _switchMember(context, pageContextInfo.pageId, switchToThisMemberId);
        },
        child: avatar
    );
  }

  static void _switchMember(BuildContext context, String pageId, String memberId) {
    var _navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    _navigatorBloc
        .add(GoToPageEvent(pageId, parameters: {SwitchFeedHelper.switchMemberFeedPageParameter: memberId}));
  }

  bool allowNewPost() => currentMember() == feedMember();

  String currentMember() => loggedIn.member.documentID!;

  String feedMember() {
    if (pageContextInfo.parameters == null) {
      return currentMember();
    }
    var param = pageContextInfo.parameters![switchMemberFeedPageParameter];
    if (param == null) {
      return currentMember();
    }
    return param;
  }

  Future<WhichFeed> getWhichFeed () async {
    String meId = currentMember();
    if (feedMember() == meId) {
      if ((watchOnlyMyFeed != null) && (watchOnlyMyFeed!)) {
        return WhichFeed.OnlyMyFeed;
      } else {
        return WhichFeed.MyFeed;
      }
    } else {
      var following = await FollowerHelper.following(meId, loggedIn.app.documentID!);
      if (following.contains(meId)) {
        return WhichFeed.SomeoneIFollow;
      } else {
        return WhichFeed.SomeoneElse;
      }
    }
    return Future.value(WhichFeed.MyFeed);
  }
}
