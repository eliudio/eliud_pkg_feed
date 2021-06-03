import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateUninitialized());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is InitialiseProfileEvent) {
      yield await getProfileInformation(event);
    } else if (event is ChangedProfileEventProfile) {
      if (state is ProfileInitialised) {
        var myState = state as ProfileInitialised;
        var newMemberProfileModel = myState.memberProfileModel.copyWith(profile: event.value);
         await memberProfileRepository(appId: myState.appId)!
            .update(newMemberProfileModel);
        yield myState.copyWith(newMemberProfileModel: newMemberProfileModel);
      }
    }
  }

  static Future<ProfileState> getProfileInformation(
      InitialiseProfileEvent event) async {
    var accessState = event.appLoaded;
    var member = accessState.getMember();
    var app = accessState.app;
    var pageContextInfo =
        PageParamHelper.getPagaContextInfoWithRoutAndApp(event.modalRoute, app);
    var readAccess = await PostFollowersHelper.asPublic(accessState);
    var readRights = ['PUBLIC'];
    if (member != null) readRights.add(member.documentID!);
    var switchFeedHelper = await SwitchFeedHelper.construct(pageContextInfo,
        app.documentID!, member == null ? null : member.documentID);
    var query = EliudQuery()
        .withCondition(EliudQueryCondition('feedId', isEqualTo: event.feedId))
        .withCondition(EliudQueryCondition('authorId',
            isEqualTo: switchFeedHelper.memberOfFeed.documentID))
        .withCondition(
            EliudQueryCondition('readAccess', arrayContainsAny: readRights));
    var valuesList = await memberProfileRepository(appId: app.documentID)!
        .valuesListWithDetails(eliudQuery: query);
    if (valuesList.length > 1) {
      // In theory a person can create multiple profiles. However, we use the first only.
      var memberProfileModel = valuesList[0];
      return ProfileInitialised(event.feedId, app.documentID!, readAccess,
          memberProfileModel!, switchFeedHelper);
    } else {
      return ProfileError("No profile available");
    }
  }
}
