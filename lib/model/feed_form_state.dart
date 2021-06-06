/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'feed_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FeedFormState extends Equatable {
  const FeedFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class FeedFormUninitialized extends FeedFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''FeedFormState()''';
  }
}

// FeedModel has been initialised and hence FeedModel is available
class FeedFormInitialized extends FeedFormState {
  final FeedModel? value;

  @override
  List<Object?> get props => [ value ];

  const FeedFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class FeedFormError extends FeedFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const FeedFormError({this.message, FeedModel? value }) : super(value: value);

  @override
  String toString() {
    return '''FeedFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDFeedFormError extends FeedFormError { 
  const DocumentIDFeedFormError({ String? message, FeedModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDFeedFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdFeedFormError extends FeedFormError { 
  const AppIdFeedFormError({ String? message, FeedModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdFeedFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class DescriptionFeedFormError extends FeedFormError { 
  const DescriptionFeedFormError({ String? message, FeedModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DescriptionFeedFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ThumbImageFeedFormError extends FeedFormError { 
  const ThumbImageFeedFormError({ String? message, FeedModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ThumbImageFeedFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ConditionsFeedFormError extends FeedFormError { 
  const ConditionsFeedFormError({ String? message, FeedModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ConditionsFeedFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class FeedFormLoaded extends FeedFormInitialized { 
  const FeedFormLoaded({ FeedModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''FeedFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableFeedForm extends FeedFormInitialized { 
  const SubmittableFeedForm({ FeedModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableFeedForm {
      value: $value,
    }''';
  }
}


