import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_member.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:eliud_pkg_follow/tools/follower_helper.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateUninitialized());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is InitialiseProfileEvent) {
      yield await determineProfileState(event);
    } else if (state is LoggedInWatchingMyProfile) {
      var myState = state as LoggedInWatchingMyProfile;
      if (event is ProfileChangedProfileEvent) {
        yield await _updated(myState,
            myState.currentMemberProfileModel.copyWith(profile: event.value));
      } else if (event is ProfilePhotoChangedProfileEvent) {
        yield await _updated(
            myState,
            myState.currentMemberProfileModel
                .copyWith(profileOverride: event.value));
      } else if (event is ProfileBGPhotoChangedProfileEvent) {
        yield await _updated(
            myState,
            myState.currentMemberProfileModel
                .copyWith(profileBackground: event.value));
      }
    }
  }

  Future<ProfileInitialised> _updated(LoggedInWatchingMyProfile myState,
      MemberProfileModel newMemberProfileModel) async {
    await memberProfileRepository(appId: myState.appId)!
        .update(newMemberProfileModel);
    return myState.copyWith(newMemberProfileModel: newMemberProfileModel);
  }

  Future<ProfileState> determineProfileState(
      InitialiseProfileEvent event) async {
    var accessState = event.appLoaded;
    var app = accessState.app;
    var currentMemberModel = accessState.getMember();
    var pageContextInfo =
        PageParamHelper.getPagaContextInfoWithRoutAndApp(event.modalRoute, app);
    var feedId = event.feedId;
    var appId = app.documentID!;
    if (currentMemberModel == null) {
      if (pageContextInfo.parameters != null) {
        var param = pageContextInfo
            .parameters![SwitchMember.switchMemberFeedPageParameter];
        if (param == null) {
          return WatchingPublicProfile(feedId: feedId, appId: appId);
        } else {
          var feedPublicInfoModel = await getMemberPublicInfo(param);
          var feedProfileModel =
              await getMemberProfileModel(appId, feedId, param, null);
          return NotLoggedInWatchingSomeone(
              appId: appId,
              feedId: feedId,
              feedProfileModel: feedProfileModel,
              feedPublicInfoModel: feedPublicInfoModel);
        }
      } else {
        return WatchingPublicProfile(feedId: feedId, appId: appId);
      }
    } else {
      var defaultReadAccess = await PostFollowersMemberHelper.asPublic(
          appId, currentMemberModel.documentID!);
      // Determine current member
      var currentMemberProfileModel = await getMemberProfileModel(
          appId, feedId, currentMemberModel.documentID!, defaultReadAccess);
      var param;
      if (pageContextInfo.parameters != null) {
        param = pageContextInfo
            .parameters![SwitchMember.switchMemberFeedPageParameter];
      }
      if (param == null) {
        return LoggedInWatchingMyProfile(
            feedId: feedId,
            appId: appId,
            currentMemberProfileModel: currentMemberProfileModel,
            currentMember: currentMemberModel,
            defaultReadAccess: defaultReadAccess,
            onlyMyPosts: false);
      } else {
        var following = await FollowerHelper.following(
            currentMemberModel.documentID!, appId);
        var feedPublicInfoModel = await getMemberPublicInfo(param);
        var feedProfileModel = await getMemberProfileModel(
            appId, feedId, param, defaultReadAccess);
        return LoggedInAndWatchingOtherProfile(
            feedId: feedId,
            appId: appId,
            currentMemberProfileModel: currentMemberProfileModel,
            currentMember: currentMemberModel,
            defaultReadAccess: defaultReadAccess,
            feedProfileModel: feedProfileModel,
            feedPublicInfoModel: feedPublicInfoModel,
            iFollowThisPerson:
                following.contains(currentMemberModel.documentID!));
      }
    }
  }

  Future<MemberPublicInfoModel> getMemberPublicInfo(String documentId) async {
    var member = await memberPublicInfoRepository()!.get(documentId);
    if (member == null) {
      throw Exception(
          "Can't find member with id $documentId in public members repository");
    }
    return member;
  }

  static Future<MemberProfileModel> getMemberProfileModel(String appId,
      String feedId, String memberId, List<String>? readAccess) async {
    var key = memberId + "-" + feedId;
    var memberProfileModel =
        await memberProfileRepository(appId: appId)!.get(key, onError: (exception) {} );
    if (memberProfileModel == null) {
      var pubMember =
          await memberPublicInfoRepository(appId: appId)!.get(memberId);
      // create default profile
      memberProfileModel = MemberProfileModel(
          documentID: key,
          appId: appId,
          feedId: feedId,
          author: pubMember,
          readAccess: readAccess,
          profile: pubMember!.photoURL);
      memberProfileRepository(appId: appId)!.add(memberProfileModel);
    }
    return memberProfileModel;
  }

  static EliudQuery postQuery(ProfileInitialised state) {
    // We could limit the posts retrieve by making adding the condition: 'authorId' whereIn FollowerHelper.following(me, state.app.documentID)
    // However, combining this query with arrayContainsAny in 1 query is not possible currently in the app.
    // For now we lay the responsibility with the one posting the post, i.e. that the readAccess includes the person.
    // More comments, see firestore.rules > match /post/{id} > allow create

    // When we post, we indicate we post to public, followers or just me. The readAccess field is determined with that indicator with the following entries
    // - public: readAccess becomes "PUBLIC", + the list of followers + me
    // - followers: readAccess becomes the list of followers + me
    // - me: readAccess becomes me
    if (state is LoggedInWatchingMyProfile) {
      if (!state.onlyMyPosts) {
        // query where I'm in the readAccess, which means I see my posts and everybody's
        // posts where I was included as follower, be it indicated as publc of as follower:
        // We're not interested in ALL people's posts, we're only interested in the posts of ourselves or
        // or the people I follow
        return EliudQuery()
            .withCondition(EliudQueryCondition('archived',
                isEqualTo: PostArchiveStatus.Active.index))
            .withCondition(
                EliudQueryCondition('feedId', isEqualTo: state.feedId))
            .withCondition(EliudQueryCondition('readAccess',
                arrayContainsAny: [state.currentMember.documentID!, 'PUBLIC']));
      } else {
        // query where I'm the author. We could include that we're part of the readAccess but that's obsolete
        return EliudQuery()
            .withCondition(EliudQueryCondition('archived',
                isEqualTo: PostArchiveStatus.Active.index))
            .withCondition(EliudQueryCondition('authorId',
                isEqualTo: state.currentMember.documentID!))
            .withCondition(
                EliudQueryCondition('feedId', isEqualTo: state.feedId));
      }
    } else if (state is LoggedInAndWatchingOtherProfile) {
      if (state.iFollowThisPerson) {
        // query where that person is the author and I'm in the readAccess
        return EliudQuery()
            .withCondition(EliudQueryCondition('archived',
                isEqualTo: PostArchiveStatus.Active.index))
            .withCondition(EliudQueryCondition('authorId',
                isEqualTo: state.feedPublicInfoModel.documentID!))
            .withCondition(
                EliudQueryCondition('feedId', isEqualTo: state.feedId))
            .withCondition(EliudQueryCondition('readAccess',
                arrayContainsAny: [state.currentMember.documentID!]));
      } else {
        // query where that person is the author and PUBLIC in the readAccess
        return publicQueryForAuthor(
            state.feedPublicInfoModel.documentID!, state.feedId);
      }
    } else if (state is NotLoggedInWatchingSomeone) {
      return publicQueryForAuthor(
          state.feedPublicInfoModel.documentID!, state.feedId);
    } else if (state is WatchingPublicProfile) {
      return publicQuery(state.feedId);
    } else {
      throw Exception('Post query case not expected');
    }
  }

  static EliudQuery publicQueryForAuthor(String authorId, String feedId) {
    return EliudQuery()
        .withCondition(EliudQueryCondition('archived',
            isEqualTo: PostArchiveStatus.Active.index))
        .withCondition(EliudQueryCondition('authorId', isEqualTo: authorId))
        .withCondition(EliudQueryCondition('feedId', isEqualTo: feedId))
        .withCondition(
            EliudQueryCondition('readAccess', arrayContainsAny: ['PUBLIC']));
  }

  static EliudQuery publicQuery(String feedId) {
    return EliudQuery()
        .withCondition(EliudQueryCondition('archived',
            isEqualTo: PostArchiveStatus.Active.index))
        .withCondition(EliudQueryCondition('feedId', isEqualTo: feedId))
        .withCondition(
            EliudQueryCondition('readAccess', arrayContainsAny: ['PUBLIC']));
    ;
  }
}
