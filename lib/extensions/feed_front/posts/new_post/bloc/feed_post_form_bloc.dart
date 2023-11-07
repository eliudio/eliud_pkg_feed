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
  late PostModel?
      post; // if this is an update then this is the post being updated

  FeedPostFormBloc(this.app, this.postListPagedBloc, this.memberId, this.feedId,
      this.accessState)
      : super(FeedPostFormUninitialized()) {
    if (state is FeedPostFormUninitialized) {
      //final currentState = state as FeedPostFormUninitialized;
    }
    on<InitialiseNewFeedPostFormEvent>((event, emit) async {
      post = null;
      emit(await _initialiseNew(
          event.postAccessibleByGroup, event.postAccessibleByMembers));
    });
    on<InitialiseUpdateFeedPostFormEvent>((event, emit) async {
      post = event.originalPost;
      emit(await _initialiseUpdate(event));
    });

    on<SubmitPost>((event, emit) async {
      if (state is FeedPostFormInitialized) {
        final currentState = state as FeedPostFormInitialized;
        emit(await _submit(currentState.postModelDetails));
      }
    });
    on<ChangedFeedPostPrivilege>((event, emit) async {
      if (state is FeedPostFormInitialized) {
        final currentState = state as FeedPostFormInitialized;
        var newValue = currentState.postModelDetails.copyWith(
            postAccessibleByGroup: event.postAccessibleByGroup,
            postAccessibleByMembers: event.postAccessibleByMembers);
        emit(SubmittableFeedPostForm(postModelDetails: newValue));
      }
    });
    on<UploadingMedium>((event, emit) async {
      if (state is FeedPostFormInitialized) {
        final currentState = state as FeedPostFormInitialized;
        emit(SubmittableFeedPostFormWithMediumUploading(
            postModelDetails: currentState.postModelDetails,
            progress: event.progress));
      }
    });
    on<ChangedFeedPostDescription>((event, emit) async {
      if (state is FeedPostFormInitialized) {
        final currentState = state as FeedPostFormInitialized;
        var newValue =
            currentState.postModelDetails.copyWith(description: event.value);
        emit(SubmittableFeedPostForm(postModelDetails: newValue));
      }
    });

    on<ChangedMedia>((event, emit) {
      if (state is FeedPostFormInitialized) {
        final currentState = state as FeedPostFormInitialized;
        var newValue = currentState.postModelDetails
            .copyWith(memberMedia: event.memberMedia);
        emit(SubmittableFeedPostForm(postModelDetails: newValue));
      }
    });
  }

  Future<FeedPostFormLoaded> _initialiseNew(
      PostAccessibleByGroup postAccessibleByGroup,
      List<String>? postAccessibleByMembers) async {
    return FeedPostFormLoaded(
        postModelDetails: FeedPostModelDetails(
      description: "",
      memberMedia: [],
      postAccessibleByGroup: postAccessibleByGroup,
      postAccessibleByMembers: postAccessibleByMembers,
    ));
  }

  Future<FeedPostFormLoaded> _initialiseUpdate(
      InitialiseUpdateFeedPostFormEvent event) async {
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
      archived: PostArchiveStatus.active,
      memberMedia: feedPostModelDetails.memberMedia,
      readAccess: [
        memberId
      ], // default readAccess to the owner. The function will expand this based on accessibleByGroup/Members
    );

    // Now tell the list bloc to add the post
    if (post == null) {
      postListPagedBloc.add(AddPostPaged(value: postModel));
    } else {
      postListPagedBloc.add(UpdatePostPaged(value: postModel));
    }
    // reset the form
    return _initialiseNew(feedPostModelDetails.postAccessibleByGroup,
        feedPostModelDetails.postAccessibleByMembers);
  }
}
