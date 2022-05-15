/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_front_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'feed_front_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FeedFrontFormState extends Equatable {
  const FeedFrontFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class FeedFrontFormUninitialized extends FeedFrontFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''FeedFrontFormState()''';
  }
}

// FeedFrontModel has been initialised and hence FeedFrontModel is available
class FeedFrontFormInitialized extends FeedFrontFormState {
  final FeedFrontModel? value;

  @override
  List<Object?> get props => [ value ];

  const FeedFrontFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class FeedFrontFormError extends FeedFrontFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const FeedFrontFormError({this.message, FeedFrontModel? value }) : super(value: value);

  @override
  String toString() {
    return '''FeedFrontFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDFeedFrontFormError extends FeedFrontFormError { 
  const DocumentIDFeedFrontFormError({ String? message, FeedFrontModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDFeedFrontFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdFeedFrontFormError extends FeedFrontFormError { 
  const AppIdFeedFrontFormError({ String? message, FeedFrontModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdFeedFrontFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class DescriptionFeedFrontFormError extends FeedFrontFormError { 
  const DescriptionFeedFrontFormError({ String? message, FeedFrontModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DescriptionFeedFrontFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class FeedFeedFrontFormError extends FeedFrontFormError { 
  const FeedFeedFrontFormError({ String? message, FeedFrontModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''FeedFeedFrontFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class BackgroundOverridePostsFeedFrontFormError extends FeedFrontFormError { 
  const BackgroundOverridePostsFeedFrontFormError({ String? message, FeedFrontModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''BackgroundOverridePostsFeedFrontFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class BackgroundOverrideProfileFeedFrontFormError extends FeedFrontFormError { 
  const BackgroundOverrideProfileFeedFrontFormError({ String? message, FeedFrontModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''BackgroundOverrideProfileFeedFrontFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class BackgroundOverrideHeaderFeedFrontFormError extends FeedFrontFormError { 
  const BackgroundOverrideHeaderFeedFrontFormError({ String? message, FeedFrontModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''BackgroundOverrideHeaderFeedFrontFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ConditionsFeedFrontFormError extends FeedFrontFormError { 
  const ConditionsFeedFrontFormError({ String? message, FeedFrontModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ConditionsFeedFrontFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class FeedFrontFormLoaded extends FeedFrontFormInitialized { 
  const FeedFrontFormLoaded({ FeedFrontModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''FeedFrontFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableFeedFrontForm extends FeedFrontFormInitialized { 
  const SubmittableFeedFrontForm({ FeedFrontModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableFeedFrontForm {
      value: $value,
    }''';
  }
}


