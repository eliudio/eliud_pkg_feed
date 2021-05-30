import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_follow/tools/follower_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliud_core/core/navigate/navigate_bloc.dart';
import 'package:eliud_core/core/navigate/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'avatar_helper.dart';

enum WhichFeed { MyFeed, OnlyMyFeed, SomeoneIFollow, SomeoneElse }

class SwitchFeedHelper {
  static String switchMemberFeedPageParameter = 'memberId';
  final String pageId;
  final WhichFeed whichFeed;
  final MemberPublicInfoModel memberCurrent;
  final MemberPublicInfoModel memberOfFeed;

  SwitchFeedHelper(
      this.pageId, this.whichFeed, this.memberCurrent, this.memberOfFeed);

  Widget gestured(
      BuildContext context, String switchToThisMemberId, Widget avatar) {
    return GestureDetector(
        onTap: () {
          _switchMember(context, pageId, switchToThisMemberId);
        },
        child: avatar);
  }

  Widget getFeedWidget(
    BuildContext context,
  ) {
    return gestured(
        context, feedMember().documentID!, AvatarHelper.avatar(feedMember()));
  }

  Widget getFeedWidget2(BuildContext context,
      {Color? backgroundColor, Color? backgroundColor2, double? radius}) {
    return gestured(
        context,
        feedMember().documentID!,
        AvatarHelper.avatar2(feedMember(),
            backgroundColor: backgroundColor, backgroundColor2: backgroundColor2, radius: radius));
  }

  static void _switchMember(
      BuildContext context, String pageId, String memberId) {
    var _navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    _navigatorBloc.add(GoToPageEvent(pageId, parameters: {
      SwitchFeedHelper.switchMemberFeedPageParameter: memberId
    }));
  }

  bool allowNewPost() => currentMember() == feedMember();

  MemberPublicInfoModel currentMember() => memberCurrent;

  MemberPublicInfoModel feedMember() => memberOfFeed;

  WhichFeed getWhichFeed() => whichFeed;

  static Future<MemberPublicInfoModel> _getMember(String documentId) async {
    var member = await memberPublicInfoRepository()!.get(documentId);
    if (member == null) {
      throw Exception(
          "Can't find member with id $documentId in public members repository");
    }
    return member;
  }

  // when watching your own feed, you can
  // * watch your feed and everybody who posted to your feed,
  // or
  // * watch your feed only.
  // This flag is to indicate you just want to watch your own feed.
  static Future<SwitchFeedHelper> construct(
      PageContextInfo pageContextInfo, LoggedIn loggedIn,
      {bool? watchOnlyMyFeed}) async {
    // Determine current member
    MemberPublicInfoModel _memberCurrent =
        await _getMember(loggedIn.member.documentID!);

    // Determine feed member
    MemberPublicInfoModel _memberOfFeed;
    if (pageContextInfo.parameters == null) {
      _memberOfFeed = _memberCurrent;
    } else {
      var param = pageContextInfo.parameters![switchMemberFeedPageParameter];
      if (param == null) {
        _memberOfFeed = _memberCurrent;
      } else {
        _memberOfFeed = await _getMember(param);
      }
    }

    String meId = _memberCurrent.documentID!;

    // Determine whichFeed
    WhichFeed whichFeed;
    if (meId == _memberOfFeed.documentID!) {
      if ((watchOnlyMyFeed != null) && (watchOnlyMyFeed)) {
        whichFeed = WhichFeed.OnlyMyFeed;
      } else {
        whichFeed = WhichFeed.MyFeed;
      }
    } else {
      var following =
          await FollowerHelper.following(meId, loggedIn.app.documentID!);
      if (following.contains(meId)) {
        whichFeed = WhichFeed.SomeoneIFollow;
      } else {
        whichFeed = WhichFeed.SomeoneElse;
      }
    }

    return SwitchFeedHelper(
        pageContextInfo.pageId, whichFeed, _memberCurrent, _memberOfFeed);
  }
}
