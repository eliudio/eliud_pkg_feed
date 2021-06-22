import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateUninitialized());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is InitialiseProfileEvent) {
      yield await getProfileInformation(event);
    } else if (state is ProfileInitialised) {
      var myState = state as ProfileInitialised;
      if (event is ProfileChangedProfileEvent) {
        yield await _updated(
            myState, myState.memberProfileModel.copyWith(profile: event.value));
      } else if (event is ProfilePhotoChangedProfileEvent) {
        yield await _updated(myState,
            myState.memberProfileModel.copyWith(profileOverride: event.value));
      } else if (event is ProfileBGPhotoChangedProfileEvent) {
        yield await _updated(
            myState,
            myState.memberProfileModel
                .copyWith(profileBackground: event.value));
      }
    }
  }

  Future<ProfileInitialised> _updated(ProfileInitialised myState,
      MemberProfileModel newMemberProfileModel) async {
    await memberProfileRepository(appId: myState.appId)!
        .update(newMemberProfileModel);
    return myState.copyWith(newMemberProfileModel: newMemberProfileModel);
  }

  static Future<ProfileState> getProfileInformation(
      InitialiseProfileEvent event) async {
    var accessState = event.appLoaded;
    var member = accessState.getMember();
    var app = accessState.app;
    var pageContextInfo =
        PageParamHelper.getPagaContextInfoWithRoutAndApp(event.modalRoute, app);
    var switchFeedHelper = await SwitchFeedHelper.construct(
        pageContextInfo,
        app.documentID!,
        event.feedId,
        member == null ? null : member.documentID);
    var key = switchFeedHelper.memberOfFeed.documentID! + "-" + event.feedId;
    var memberProfileModel =
        await memberProfileRepository(appId: app.documentID)!.get(key);
    if (memberProfileModel == null) {
      var pubMember = await memberPublicInfoRepository(appId: app.documentID)!
          .get(member!.documentID);
      // create default profile
      memberProfileModel = MemberProfileModel(
          documentID: key,
          appId: app.documentID,
          feedId: event.feedId,
          author: pubMember,
          readAccess: switchFeedHelper.defaultReadAccess,
          profile: "");
      await memberProfileRepository(appId: app.documentID)!
          .add(memberProfileModel);
    }
    return ProfileInitialised(
        event.feedId,
        app.documentID!,
        switchFeedHelper.defaultReadAccess,
        memberProfileModel,
        switchFeedHelper);
  }
}
