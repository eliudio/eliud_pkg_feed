import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'feed_post_form_event.dart';
import 'feed_post_form_state.dart';
import 'feed_post_model_details.dart';

class FeedPostFormBloc extends Bloc<FeedPostFormEvent, FeedPostFormState> {
  final String appId;
  final PostListPagedBloc postListPagedBloc;
  final MemberPublicInfoModel memberPublicInfoModel;
  final String feedId;
  final LoggedIn accessState;

  FeedPostFormBloc(this.appId, this.postListPagedBloc,
      this.memberPublicInfoModel, this.feedId, this.accessState)
      : super(FeedPostFormUninitialized());
  @override
  Stream<FeedPostFormState> mapEventToState(FeedPostFormEvent event) async* {
    final currentState = state;
    if (currentState is FeedPostFormUninitialized) {
      if (event is InitialiseNewFeedPostFormEvent) {
        yield _initialised();
      }
    } else if (currentState is FeedPostFormInitialized) {
      if (event is SubmitPost) {
        yield* _submit(currentState.postModelDetails);
      }
      if (event is ChangedFeedPostPrivilege) {
        var newValue =
            currentState.postModelDetails.copyWith(postPrivilege: event.value);
        yield SubmittableFeedPostForm(postModelDetails: newValue);
      }
      if (event is ChangedFeedPostDescription) {
        var newValue =
            currentState.postModelDetails.copyWith(description: event.value);
        yield SubmittableFeedPostForm(postModelDetails: newValue);
      } else if (event is ChangedFeedPhotos) {
        var newValue = currentState.postModelDetails
            .copyWith(photoWithThumbnails: event.photoWithThumbnails);
        yield SubmittableFeedPostForm(postModelDetails: newValue);
      } else if (event is ChangedFeedVideos) {
        var newValue = currentState.postModelDetails
            .copyWith(videoWithThumbnails: event.videoWithThumbnails);
        yield SubmittableFeedPostForm(postModelDetails: newValue);
      }
    }
  }

  FeedPostFormLoaded _initialised() => FeedPostFormLoaded(
          postModelDetails: FeedPostModelDetails(
        description: "",
        photoWithThumbnails: [],
        videoWithThumbnails: [],
        postPrivilege: PostPrivilege.Public,
      ));

  Stream<FeedPostFormState> _submit(
      FeedPostModelDetails feedPostModelDetails) async* {
    yield UploadingPostForm(
        postModelDetails: feedPostModelDetails, percentageFinished: 0);

    int done = 0;
    int amount = ((feedPostModelDetails.photoWithThumbnails == null) ? 0 : feedPostModelDetails.photoWithThumbnails.length) +
        ((feedPostModelDetails.videoWithThumbnails == null) ? 0 : feedPostModelDetails.videoWithThumbnails.length);

    List<String> readAccess = await PostFollowersHelper.as(
        feedPostModelDetails.postPrivilege, appId, accessState);
    List<PostMediumModel> memberMedia = [];

    for (PhotoWithThumbnail photoWithThumbnail
        in feedPostModelDetails.photoWithThumbnails) {
      var memberMediumModel = await MemberMediumHelper.uploadPhotoWithThumbnail(
        appId,
        photoWithThumbnail,
        memberPublicInfoModel.documentID!,
        readAccess,
      );
      memberMedia.add(PostMediumModel(
          documentID: newRandomKey(), memberMedium: memberMediumModel));
      done++;
      yield UploadingPostForm(
          postModelDetails: feedPostModelDetails, percentageFinished: done / amount);
    }

    for (VideoWithThumbnail videoWithThumbnail
        in feedPostModelDetails.videoWithThumbnails) {
      var memberMediumModel = await MemberMediumHelper.uploadVideoWithThumbnail(
        appId,
        videoWithThumbnail,
        memberPublicInfoModel.documentID!,
        readAccess,
      );
      memberMedia.add(PostMediumModel(
          documentID: newRandomKey(), memberMedium: memberMediumModel));
      done++;
      yield UploadingPostForm(
          postModelDetails: feedPostModelDetails, percentageFinished: done / amount);
    }

    PostModel postModel = PostModel(
        documentID: newRandomKey(),
        author: memberPublicInfoModel,
        appId: appId,
        feedId: feedId,
        description: feedPostModelDetails.description,
        likes: 0,
        dislikes: 0,
        readAccess: readAccess,
        archived: PostArchiveStatus.Active,
        memberMedia: memberMedia);

    postListPagedBloc.add(AddPostPaged(value: postModel));

    // reset the form
    yield _initialised();
  }
}
