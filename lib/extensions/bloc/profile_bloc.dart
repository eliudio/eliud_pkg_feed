import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core_helpers/query/query_tools.dart';
import 'package:eliud_core_main/model/abstract_repository_singleton.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/member_model.dart';
import 'package:eliud_core_main/model/member_public_info_model.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_member.dart';
import 'package:eliud_pkg_feed_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed_model/model/member_profile_model.dart';
import 'package:eliud_pkg_feed_model/model/post_model.dart';
import 'package:eliud_pkg_follow/tools/follower_helper.dart';

import 'profile_event.dart';
import 'profile_state.dart';

/*
 * Different member collections:
 * - MemberRepository: core collection where all user data is stored. This data is only accessible to the member and the owner
 * - MemberPublicInfoRepository: core collection where the user can store data he allows to share with others, public of followers only at his choice. This collection is created by firebase functions and is not guaranteed to exist
 * - MemberProfileRepository: feed specific collection used to store profile information. The user can choose a different name and avatar for his feed.
 *
 * The rules for using member information:
 * When logging on, the MemberRepository data is copied into the MemberProfileRepository. A reference to the MemberPubicInfoRepository is
 * added, when available.
 */
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateUninitialized()) {
    on<InitialiseProfileEvent>((event, emit) async {
      emit(await determineProfileState(event));
    });

    on<UploadingProfilePhotoEvent>((event, emit) {
      if (state is ProfileInitialised) {
        var theState = state as ProfileInitialised;
        emit(theState.progressWith(
            uploadingProfilePhotoProgress: event.progress));
      }
    });

    on<UploadingBGPhotoEvent>((event, emit) {
      if (state is ProfileInitialised) {
        var theState = state as ProfileInitialised;
        emit(theState.progressWith(uploadingBGProgress: event.progress));
      }
    });

    on<ProfileChangedProfileEvent>((event, emit) async {
      if (state is LoggedInWatchingMyProfile) {
        var myState = state as LoggedInWatchingMyProfile;
        emit(await _updated(
            myState,
            myState.currentMemberProfileModel.copyWith(
                profile: event.html, memberMedia: event.memberMedia)));
      }
    });

    on<ProfilePhotoChangedProfileEvent>((event, emit) async {
      if (state is LoggedInWatchingMyProfile) {
        var myState = state as LoggedInWatchingMyProfile;
        emit(await _updated(
            myState,
            myState.currentMemberProfileModel
                .copyWith(profileOverride: event.value.url)));
      }
    });

    on<ProfileBGPhotoChangedProfileEvent>((event, emit) async {
      if (state is LoggedInWatchingMyProfile) {
        var myState = state as LoggedInWatchingMyProfile;
        emit(await _updated(
            myState,
            myState.currentMemberProfileModel
                .copyWith(profileBackground: event.value)));
      }
    });
  }

  Future<ProfileInitialised> _updated(LoggedInWatchingMyProfile myState,
      MemberProfileModel newMemberProfileModel) async {
    await memberProfileRepository(appId: myState.app.documentID)!
        .update(newMemberProfileModel);
    return myState.copyWith(
        newMemberProfileModel: newMemberProfileModel,
        uploadingBGProgress: null,
        uploadingProfilePhotoProgress: null);
  }

  Future<ProfileState> determineProfileState(
      InitialiseProfileEvent event) async {
    var accessState = event.accessDetermined;
    var currentMemberModel = accessState.getMember();
    var pageContextInfo =
        eliudrouter.Router.getPageContextInfoWithRoute(event.modalRoute);
    var feedId = event.feedId;
    var app = event.app;
    if (currentMemberModel == null) {
      if (pageContextInfo.parameters != null) {
        var param = pageContextInfo
            .parameters![SwitchMember.switchMemberFeedPageParameter];
        if (param == null) {
          return WatchingPublicProfile(
              feedId: feedId,
              app: app,
              uploadingProfilePhotoProgress: null,
              uploadingBGProgress: null);
        } else {
          var feedPublicInfoModel = await getMemberPublicInfo(param);
          var feedProfileModel = await getMemberProfileModelWithPublicInfo(
              false,
              app,
              feedId,
              feedPublicInfoModel,
              MemberProfileAccessibleByGroup.public,
              null);
          return NotLoggedInWatchingSomeone(
              app: app,
              feedId: feedId,
              feedProfileModel: feedProfileModel,
              feedPublicInfoModel: feedPublicInfoModel,
              uploadingProfilePhotoProgress: null,
              uploadingBGProgress: null);
        }
      } else {
        return WatchingPublicProfile(
            feedId: feedId,
            app: app,
            uploadingProfilePhotoProgress: null,
            uploadingBGProgress: null);
      }
    } else {
      var defaultPostGroup = PostAccessibleByGroup.public;
      var defaultMemberProfileGroup =
          toMemberProfileAccessibleByGroup(defaultPostGroup.index);
      List<String> defaultMembers = [];
      // Determine current member
      String? param;
      if (pageContextInfo.parameters != null) {
        param = pageContextInfo
            .parameters![SwitchMember.switchMemberFeedPageParameter];
      }

      if (param == null) {
        var currentMemberProfileModel =
            await getMemberProfileModelWithCurrentMemberModel(true, app, feedId,
                currentMemberModel, defaultMemberProfileGroup, defaultMembers);
        return LoggedInWatchingMyProfile(
            feedId: feedId,
            app: app,
            currentMemberProfileModel: currentMemberProfileModel,
            currentMember: currentMemberModel,
            postAccessibleByGroup: defaultPostGroup,
            postAccessibleByMembers: defaultMembers,
            onlyMyPosts: false,
            uploadingProfilePhotoProgress: null,
            uploadingBGProgress: null);
      } else {
        var currentMemberProfileModel =
            await getMemberProfileModelWithCurrentMemberModel(
                false,
                app,
                feedId,
                currentMemberModel,
                defaultMemberProfileGroup,
                defaultMembers);
        var following =
            await FollowerHelper.following(currentMemberModel.documentID, app);
        var feedPublicInfoModel = await getMemberPublicInfo(param);
        var feedProfileModel = await getMemberProfileModelWithPublicInfo(
            false,
            app,
            feedId,
            feedPublicInfoModel,
            MemberProfileAccessibleByGroup.public,
            null);
        return LoggedInAndWatchingOtherProfile(
            feedId: feedId,
            app: app,
            currentMemberProfileModel: currentMemberProfileModel,
            currentMember: currentMemberModel,
            postAccessibleByGroup: PostAccessibleByGroup.public,
            feedProfileModel: feedProfileModel,
            feedPublicInfoModel: feedPublicInfoModel,
            iFollowThisPerson: following.contains(
              currentMemberModel.documentID,
            ),
            uploadingProfilePhotoProgress: null,
            uploadingBGProgress: null);
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

  static Future<MemberProfileModel> getMemberProfileModelWithCurrentMemberModel(
      bool create,
      AppModel app,
      String feedId,
      MemberModel member,
      MemberProfileAccessibleByGroup accessibleByGroup,
      List<String>? accessibleByMembers) async {
    return getMemberProfileModel(
        create,
        app,
        feedId,
        member.documentID,
        member.photoURL ??
            (app.anonymousProfilePhoto != null
                ? app.anonymousProfilePhoto!.url
                : null),
        member.name ?? "Anonymous",
        accessibleByGroup,
        accessibleByMembers);
  }

  static Future<MemberProfileModel> getMemberProfileModelWithPublicInfo(
      bool create,
      AppModel app,
      String feedId,
      MemberPublicInfoModel member,
      MemberProfileAccessibleByGroup accessibleByGroup,
      List<String>? accessibleByMembers) async {
    return getMemberProfileModel(
        create,
        app,
        feedId,
        member.documentID,
        member.photoURL,
        member.name ?? "Anonymous${member.documentID}",
        accessibleByGroup,
        accessibleByMembers);
  }

  static Future<MemberProfileModel> getMemberProfileModel(
      bool create,
      AppModel app,
      String feedId,
      String memberId,
      String? photoURL,
      String name,
      MemberProfileAccessibleByGroup accessibleByGroup,
      List<String>? accessibleByMembers) async {
    var key = "$memberId-$feedId";
    var memberProfileModel =
        await memberProfileRepository(appId: app.documentID)!
            .get(key, onError: (exception) {});
    if (memberProfileModel == null) {
      // create default profile
      memberProfileModel = MemberProfileModel(
        documentID: key,
        appId: app.documentID,
        feedId: feedId,
        authorId: memberId,
        accessibleByGroup: accessibleByGroup,
        accessibleByMembers: accessibleByMembers,
        profileOverride: photoURL,
        nameOverride: name,
        readAccess: [
          memberId
        ], // default readAccess to the owner. The function will expand this based on accessibleByGroup/Members
      );
      if (create) {
        await memberProfileRepository(appId: app.documentID)!
            .add(memberProfileModel);
      }
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
                isEqualTo: PostArchiveStatus.active.index))
            .withCondition(
                EliudQueryCondition('feedId', isEqualTo: state.feedId))
            .withCondition(EliudQueryCondition('readAccess',
                arrayContainsAny: [state.currentMember.documentID, 'PUBLIC']));
      } else {
        // query where I'm the author. We could include that we're part of the readAccess but that's obsolete
        return EliudQuery()
            .withCondition(EliudQueryCondition('archived',
                isEqualTo: PostArchiveStatus.active.index))
            .withCondition(EliudQueryCondition('authorId',
                isEqualTo: state.currentMember.documentID))
            .withCondition(
                EliudQueryCondition('feedId', isEqualTo: state.feedId));
      }
    } else if (state is LoggedInAndWatchingOtherProfile) {
      if (state.iFollowThisPerson) {
        // query where that person is the author and I'm in the readAccess
        return EliudQuery()
            .withCondition(EliudQueryCondition('archived',
                isEqualTo: PostArchiveStatus.active.index))
            .withCondition(EliudQueryCondition('authorId',
                isEqualTo: state.feedPublicInfoModel.documentID))
            .withCondition(
                EliudQueryCondition('feedId', isEqualTo: state.feedId))
            .withCondition(EliudQueryCondition('readAccess',
                arrayContainsAny: [state.currentMember.documentID]));
      } else {
        // query where that person is the author and PUBLIC in the readAccess
        return publicQueryForAuthor(
            state.feedPublicInfoModel.documentID, state.feedId);
      }
    } else if (state is NotLoggedInWatchingSomeone) {
      return publicQueryForAuthor(
          state.feedPublicInfoModel.documentID, state.feedId);
    } else if (state is WatchingPublicProfile) {
      return publicQuery(state.feedId);
    } else {
      throw Exception('Post query case not expected');
    }
  }

  static EliudQuery publicQueryForAuthor(String authorId, String feedId) {
    return EliudQuery()
        .withCondition(EliudQueryCondition('archived',
            isEqualTo: PostArchiveStatus.active.index))
        .withCondition(EliudQueryCondition('authorId', isEqualTo: authorId))
        .withCondition(EliudQueryCondition('feedId', isEqualTo: feedId))
        .withCondition(
            EliudQueryCondition('readAccess', arrayContainsAny: ['PUBLIC']));
  }

  static EliudQuery publicQuery(String feedId) {
    return EliudQuery()
        .withCondition(EliudQueryCondition('archived',
            isEqualTo: PostArchiveStatus.active.index))
        .withCondition(EliudQueryCondition('feedId', isEqualTo: feedId))
        .withCondition(
            EliudQueryCondition('readAccess', arrayContainsAny: ['PUBLIC']));
  }
}
