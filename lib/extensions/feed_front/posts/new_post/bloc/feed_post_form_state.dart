import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'feed_post_model_details.dart';

@immutable
abstract class FeedPostFormState extends Equatable {
  const FeedPostFormState();

  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedPostFormState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class FeedPostFormUninitialized extends FeedPostFormState {
  @override
  String toString() {
    return '''FeedPostFormState()''';
  }

  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedPostFormUninitialized && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

abstract class FeedPostFormInitialized extends FeedPostFormState {
  final FeedPostModelDetails postModelDetails;

  const FeedPostFormInitialized({required this.postModelDetails});

  @override
  List<Object?> get props => [postModelDetails];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedPostFormInitialized &&
          runtimeType == other.runtimeType &&
          postModelDetails == other.postModelDetails;

  @override
  int get hashCode => postModelDetails.hashCode;
}

// Menu has been initialised and hence a menu is available
abstract class FeedPostFormError extends FeedPostFormInitialized {
  final String? message;

  const FeedPostFormError({this.message, required super.postModelDetails});

  @override
  String toString() {
    return '''FeedPostFormError {
      value: $postModelDetails,
      message: $message,
    }''';
  }
}

class DescriptionFeedPostFormError extends FeedPostFormError {
  const DescriptionFeedPostFormError(
      {super.message, required super.postModelDetails});

  @override
  String toString() {
    return '''DescriptionFeedPostFormError {
      value: $postModelDetails,
      message: $message,
    }''';
  }

  @override
  List<Object?> get props => [message, postModelDetails];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DescriptionFeedPostFormError &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          postModelDetails == other.postModelDetails;

  @override
  int get hashCode => message.hashCode ^ postModelDetails.hashCode;
}

/*
 * Form is loaded and ready to be changed / submitted
 */
class FeedPostFormLoaded extends FeedPostFormInitialized {
  const FeedPostFormLoaded({required super.postModelDetails});

  @override
  String toString() {
    return '''FeedPostFormLoaded {
      value: $postModelDetails,
    }''';
  }

  @override
  List<Object?> get props => [postModelDetails];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedPostFormLoaded &&
          runtimeType == other.runtimeType &&
          postModelDetails == other.postModelDetails;

  @override
  int get hashCode => runtimeType.hashCode;
}

/*
 * Form is ok to be submitted
 */
class SubmittableFeedPostForm extends FeedPostFormInitialized {
  const SubmittableFeedPostForm({required super.postModelDetails});

  @override
  String toString() {
    return '''SubmittableFeedPostForm {
      value: $postModelDetails,
    }''';
  }

  @override
  List<Object?> get props => [postModelDetails];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmittableFeedPostForm &&
          runtimeType == other.runtimeType &&
          postModelDetails == other.postModelDetails;

  @override
  int get hashCode => postModelDetails.hashCode;
}

/*
 * Photo or video being uploaded
 */
class SubmittableFeedPostFormWithMediumUploading
    extends SubmittableFeedPostForm {
  final double progress;

  SubmittableFeedPostFormWithMediumUploading(
      {required this.progress, required super.postModelDetails});

  @override
  List<Object?> get props => [
        postModelDetails,
        progress,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmittableFeedPostFormWithMediumUploading &&
          runtimeType == other.runtimeType &&
          postModelDetails == other.postModelDetails &&
          progress == other.progress;

  @override
  int get hashCode => postModelDetails.hashCode ^ progress.hashCode;
}
