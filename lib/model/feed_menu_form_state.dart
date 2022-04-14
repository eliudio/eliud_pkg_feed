/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'feed_menu_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FeedMenuFormState extends Equatable {
  const FeedMenuFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class FeedMenuFormUninitialized extends FeedMenuFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''FeedMenuFormState()''';
  }
}

// FeedMenuModel has been initialised and hence FeedMenuModel is available
class FeedMenuFormInitialized extends FeedMenuFormState {
  final FeedMenuModel? value;

  @override
  List<Object?> get props => [ value ];

  const FeedMenuFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class FeedMenuFormError extends FeedMenuFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const FeedMenuFormError({this.message, FeedMenuModel? value }) : super(value: value);

  @override
  String toString() {
    return '''FeedMenuFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDFeedMenuFormError extends FeedMenuFormError { 
  const DocumentIDFeedMenuFormError({ String? message, FeedMenuModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDFeedMenuFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdFeedMenuFormError extends FeedMenuFormError { 
  const AppIdFeedMenuFormError({ String? message, FeedMenuModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdFeedMenuFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class DescriptionFeedMenuFormError extends FeedMenuFormError { 
  const DescriptionFeedMenuFormError({ String? message, FeedMenuModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DescriptionFeedMenuFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class BodyComponentsCurrentMemberFeedMenuFormError extends FeedMenuFormError { 
  const BodyComponentsCurrentMemberFeedMenuFormError({ String? message, FeedMenuModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''BodyComponentsCurrentMemberFeedMenuFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class BodyComponentsOtherMemberFeedMenuFormError extends FeedMenuFormError { 
  const BodyComponentsOtherMemberFeedMenuFormError({ String? message, FeedMenuModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''BodyComponentsOtherMemberFeedMenuFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ItemColorFeedMenuFormError extends FeedMenuFormError { 
  const ItemColorFeedMenuFormError({ String? message, FeedMenuModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ItemColorFeedMenuFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class SelectedItemColorFeedMenuFormError extends FeedMenuFormError { 
  const SelectedItemColorFeedMenuFormError({ String? message, FeedMenuModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''SelectedItemColorFeedMenuFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class FeedFrontFeedMenuFormError extends FeedMenuFormError { 
  const FeedFrontFeedMenuFormError({ String? message, FeedMenuModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''FeedFrontFeedMenuFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ConditionsFeedMenuFormError extends FeedMenuFormError { 
  const ConditionsFeedMenuFormError({ String? message, FeedMenuModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ConditionsFeedMenuFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class FeedMenuFormLoaded extends FeedMenuFormInitialized { 
  const FeedMenuFormLoaded({ FeedMenuModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''FeedMenuFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableFeedMenuForm extends FeedMenuFormInitialized { 
  const SubmittableFeedMenuForm({ FeedMenuModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableFeedMenuForm {
      value: $value,
    }''';
  }
}


