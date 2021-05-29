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
import 'package:eliud_pkg_feed/model/post_form_event.dart';
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
        yield await _submit(currentState.postModelDetails);
      }
      if (event is ChangedFeedPostPrivilege) {
        var newValue =
            currentState.postModelDetails.copyWith(postPrivilege: event.value);
        yield SubmittableFeedPostForm(postModelDetails: newValue);
      }
      if (event is UploadingMedium) {
        yield SubmittableFeedPostFormWithMediumUploading(postModelDetails: currentState.postModelDetails, progress: event.progress);
      }
      if (event is ChangedFeedPostDescription) {
        var newValue =
            currentState.postModelDetails.copyWith(description: event.value);
        yield SubmittableFeedPostForm(postModelDetails: newValue);
      } else if (event is ChangedMedia) {
        var newValue = currentState.postModelDetails
            .copyWith(memberMedia: event.memberMedia);
        yield SubmittableFeedPostForm(postModelDetails: newValue);
      }
    }
  }

  FeedPostFormLoaded _initialised() => FeedPostFormLoaded(
          postModelDetails: FeedPostModelDetails(
        description: "",
        memberMedia: [],
        postPrivilege: PostPrivilege.Public,
      ));

  Future<FeedPostFormState> _submit(
      FeedPostModelDetails feedPostModelDetails) async {
    var postMemberMedia = feedPostModelDetails.memberMedia.map((memberMedium) => PostMediumModel(
      documentID: newRandomKey(),
      memberMedium: memberMedium
    )).toList();

    var readAccess = await  PostFollowersHelper.as(feedPostModelDetails.postPrivilege, appId, accessState);

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
        memberMedia: postMemberMedia);

    // Now tell the list bloc to add the post
    postListPagedBloc.add(AddPostPaged(value: postModel));

    // reset the form
    return _initialised();
  }
}
