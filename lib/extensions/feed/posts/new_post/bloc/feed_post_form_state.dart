import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'feed_post_model_details.dart';

@immutable
abstract class FeedPostFormState extends Equatable {
  const FeedPostFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class FeedPostFormUninitialized extends FeedPostFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''FeedPostFormState()''';
  }
}

class FeedPostFormInitialized extends FeedPostFormState {
  final FeedPostModelDetails postModelDetails;

  @override
  List<Object?> get props => [ postModelDetails ];

  const FeedPostFormInitialized({ required this.postModelDetails });
}

// Menu has been initialised and hence a menu is available
abstract class FeedPostFormError extends FeedPostFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, postModelDetails ];

  const FeedPostFormError({this.message, required FeedPostModelDetails postModelDetails }) : super(postModelDetails: postModelDetails);

  @override
  String toString() {
    return '''FeedPostFormError {
      value: $postModelDetails,
      message: $message,
    }''';
  }
}

class DescriptionFeedPostFormError extends FeedPostFormError {
  const DescriptionFeedPostFormError({ String? message, required FeedPostModelDetails postModelDetails}): super(message: message, postModelDetails: postModelDetails);

  @override
  List<Object?> get props => [ message, postModelDetails ];

  @override
  String toString() {
    return '''DescriptionFeedPostFormError {
      value: $postModelDetails,
      message: $message,
    }''';
  }
}

/*
 * Form is loaded and ready to be changed / submitted
 */
class FeedPostFormLoaded extends FeedPostFormInitialized {
  const FeedPostFormLoaded({ required FeedPostModelDetails postModelDetails }): super(postModelDetails: postModelDetails);

  @override
  List<Object?> get props => [ postModelDetails ];

  @override
  String toString() {
    return '''FeedPostFormLoaded {
      value: $postModelDetails,
    }''';
  }
}

/*
 * Form is ok to be submitted
 */
class SubmittableFeedPostForm extends FeedPostFormInitialized {
  const SubmittableFeedPostForm({ required FeedPostModelDetails postModelDetails }): super(postModelDetails: postModelDetails);

  @override
  List<Object?> get props => [ postModelDetails ];

  @override
  String toString() {
    return '''SubmittableFeedPostForm {
      value: $postModelDetails,
    }''';
  }
}

/*
 * Photo or video being uploaded
 */
class SubmittableFeedPostFormWithMediumUploading extends SubmittableFeedPostForm {
  final double progress;

  SubmittableFeedPostFormWithMediumUploading({ required this.progress, required FeedPostModelDetails postModelDetails }): super(postModelDetails: postModelDetails);

  @override
  List<Object?> get props => [ postModelDetails, progress, ];
}