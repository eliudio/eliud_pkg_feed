/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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

// PostModel has been initialised and hence PostModel is available
class FeedPostFormInitialized extends FeedPostFormState {
  final PostModel? value;

  @override
  List<Object?> get props => [ value ];

  const FeedPostFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class FeedPostFormError extends FeedPostFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const FeedPostFormError({this.message, PostModel? value }) : super(value: value);

  @override
  String toString() {
    return '''PostFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDPostFormError extends FeedPostFormError {
  const DocumentIDPostFormError({ String? message, PostModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}



class FeedDescriptionPostFormError extends FeedPostFormError {
  const FeedDescriptionPostFormError({ String? message, PostModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DescriptionPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class FeedMemberMediaPostFormError extends FeedPostFormError {
  const FeedMemberMediaPostFormError({ String? message, PostModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''MemberMediaPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class FeedPostFormLoaded extends FeedPostFormInitialized {
  const FeedPostFormLoaded({ PostModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''PostFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableFeedPostForm extends FeedPostFormInitialized {
  const SubmittableFeedPostForm({ PostModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableFeedPostForm {
      value: $value,
    }''';
  }
}


