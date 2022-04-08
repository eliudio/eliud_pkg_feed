import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/core/blocs/access/state/logged_in.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'feed_post_form_event.dart';
import 'feed_post_form_state.dart';
import 'feed_post_model_details.dart';

class FeedPostFormBloc extends Bloc<FeedPostFormEvent, FeedPostFormState> {
  final AppModel app;
  final PostListPagedBloc postListPagedBloc;
  final String memberId;
  final String feedId;
  final LoggedIn accessState;
  late PostModel? post; // if this is an update then this is the post being updated

  FeedPostFormBloc(this.app, this.postListPagedBloc,
      this.memberId, this.feedId, this.accessState)
      : super(FeedPostFormUninitialized());

  @override
  Stream<FeedPostFormState> mapEventToState(FeedPostFormEvent event) async* {
    final currentState = state;
    if (currentState is FeedPostFormUninitialized) {
      if (event is InitialiseNewFeedPostFormEvent) {
        post = null;
        yield await _initialiseNew(event.postAccessibleByGroup, event.postAccessibleByMembers);
      } else if (event is InitialiseUpdateFeedPostFormEvent) {
        post = event.originalPost;
        yield await _initialiseUpdate(event);
      }

    } else if (currentState is FeedPostFormInitialized) {
      if (event is SubmitPost) {
        yield await _submit(currentState.postModelDetails);
      }
      if (event is ChangedFeedPostPrivilege) {
        var newValue =
            currentState.postModelDetails.copyWith(postAccessibleByGroup: event.postAccessibleByGroup, postAccessibleByMembers: event.postAccessibleByMembers);
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

  Future<FeedPostFormLoaded> _initialiseNew(PostAccessibleByGroup postAccessibleByGroup, List<String>? postAccessibleByMembers) async {
    return FeedPostFormLoaded(
        postModelDetails: FeedPostModelDetails(
          description: "",
          memberMedia: [],
          postAccessibleByGroup: postAccessibleByGroup,
          postAccessibleByMembers: postAccessibleByMembers,
        ));
  }

  Future<FeedPostFormLoaded> _initialiseUpdate(InitialiseUpdateFeedPostFormEvent event) async {
    return FeedPostFormLoaded(
        postModelDetails: FeedPostModelDetails(
          description: event.description,
          memberMedia: event.memberMedia,
          postAccessibleByGroup: event.postAccessibleByGroup,
          postAccessibleByMembers: event.postAccessibleByMembers,
        ));
  }

  Future<FeedPostFormState> _submit(
      FeedPostModelDetails feedPostModelDetails) async {
    PostModel postModel = PostModel(
        documentID: post != null ? post!.documentID : newRandomKey(),
        authorId: memberId,
        appId: app.documentID,
        feedId: feedId,
        description: feedPostModelDetails.description,
        likes: 0,
        dislikes: 0,
        accessibleByGroup: feedPostModelDetails.postAccessibleByGroup,
        accessibleByMembers: feedPostModelDetails.postAccessibleByMembers,
        archived: PostArchiveStatus.Active,
        memberMedia: feedPostModelDetails.memberMedia,
        readAccess: [memberId],  // default readAccess to the owner. The function will expand this based on accessibleByGroup/Members
        );

    // Now tell the list bloc to add the post
    if (post == null) {
      postListPagedBloc.add(AddPostPaged(value: postModel));
    } else {
      postListPagedBloc.add(UpdatePostPaged(value: postModel));
    }
    // reset the form
    return _initialiseNew(feedPostModelDetails.postAccessibleByGroup, feedPostModelDetails.postAccessibleByMembers);
  }
}
