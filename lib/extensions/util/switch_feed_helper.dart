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

enum WhichFeed { MyFeed, OnlyMyFeed, SomeoneIFollow, SomeoneElse, PublicFeed }

class SwitchFeedHelper {
  static String switchMemberFeedPageParameter = 'memberId';
  final String appId;
  final String feedId;
  final String pageId;
  final WhichFeed whichFeed;
  final MemberPublicInfoModel? memberCurrent;
  final MemberPublicInfoModel memberOfFeed;

  SwitchFeedHelper(this.appId, this.feedId, this.pageId, this.whichFeed, this.memberCurrent, this.memberOfFeed);

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
        context, feedMember().documentID!, AvatarHelper.avatar(feedMember, appId, feedId));
  }

  static void _switchMember(
      BuildContext context, String pageId, String memberId) {
    var _navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    _navigatorBloc.add(GoToPageEvent(pageId, parameters: {
      SwitchFeedHelper.switchMemberFeedPageParameter: memberId
    }));
  }

  bool allowNewPost() => currentMember() == feedMember();

  MemberPublicInfoModel? currentMember() => memberCurrent;

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
      PageContextInfo pageContextInfo, String appId, String feedId, String? memberId,
      {bool? watchOnlyMyFeed}) async {
    // Determine current member
    MemberPublicInfoModel? _memberCurrent;
    if (memberId != null) _memberCurrent = await _getMember(memberId);

    // Determine feed member
    MemberPublicInfoModel _memberOfFeed;
    if (_memberCurrent != null) {
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
    } else {
      if (pageContextInfo.parameters == null) {
        throw Exception(
            "Looking at a feed without argument, without being logged in");
      } else {
        var param = pageContextInfo.parameters![switchMemberFeedPageParameter];
        if (param == null) {
          throw Exception(
              "Looking at a feed without argument, without being logged in");
        } else {
          _memberOfFeed = await _getMember(param);
        }
      }
    }

    // Determine whichFeed
    WhichFeed whichFeed;
    if (_memberCurrent != null) {
      String meId = _memberCurrent.documentID!;
      if (meId == _memberOfFeed.documentID!) {
        if ((watchOnlyMyFeed != null) && (watchOnlyMyFeed)) {
          whichFeed = WhichFeed.OnlyMyFeed;
        } else {
          whichFeed = WhichFeed.MyFeed;
        }
      } else {
        var following = await FollowerHelper.following(meId, appId);
        if (following.contains(meId)) {
          whichFeed = WhichFeed.SomeoneIFollow;
        } else {
          whichFeed = WhichFeed.SomeoneElse;
        }
      }
    } else {
      whichFeed = WhichFeed.PublicFeed;
    }

    return SwitchFeedHelper(appId, feedId,
        pageContextInfo.pageId, whichFeed, _memberCurrent, _memberOfFeed);
  }
}
