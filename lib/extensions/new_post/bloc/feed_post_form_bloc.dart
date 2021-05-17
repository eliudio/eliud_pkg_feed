/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/tools/enums.dart';
import 'feed_post_form_event.dart';
import 'feed_post_form_state.dart';
import 'feed_post_model_details.dart';

class FeedPostFormBloc extends Bloc<FeedPostFormEvent, FeedPostFormState> {
  final FormAction? formAction;
  final String? appId;

  FeedPostFormBloc(this.appId, {this.formAction})
      : super(FeedPostFormUninitialized());
  @override
  Stream<FeedPostFormState> mapEventToState(FeedPostFormEvent event) async* {
    final currentState = state;
    if (currentState is FeedPostFormUninitialized) {
      if (event is InitialiseNewFeedPostFormEvent) {
        FeedPostFormLoaded loaded = FeedPostFormLoaded(
            postModelDetails: FeedPostModelDetails(
            description: "",
            photoWithThumbnails: [],
            videoWithThumbnails: [],
        ));
        yield loaded;
        return;
      }
    } else if (currentState is FeedPostFormInitialized) {
      if (event is ChangedFeedPostDescription) {
        var newValue = currentState.postModelDetails.copyWith(description: event.value);
        yield SubmittableFeedPostForm(postModelDetails: newValue);
      } else if (event is ChangedFeedPhotos) {
        var newValue = currentState.postModelDetails.copyWith(photoWithThumbnails: event.photoWithThumbnails);
        yield SubmittableFeedPostForm(postModelDetails: newValue);
      } else if (event is ChangedFeedVideos) {
        var newValue = currentState.postModelDetails.copyWith(videoWithThumbnails: event.videoWithThumbnails);
        yield SubmittableFeedPostForm(postModelDetails: newValue);
      }
    }
  }
}
