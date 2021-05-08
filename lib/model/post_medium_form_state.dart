/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_medium_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'post_medium_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostMediumFormState extends Equatable {
  const PostMediumFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class PostMediumFormUninitialized extends PostMediumFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''PostMediumFormState()''';
  }
}

// PostMediumModel has been initialised and hence PostMediumModel is available
class PostMediumFormInitialized extends PostMediumFormState {
  final PostMediumModel? value;

  @override
  List<Object?> get props => [ value ];

  const PostMediumFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class PostMediumFormError extends PostMediumFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const PostMediumFormError({this.message, PostMediumModel? value }) : super(value: value);

  @override
  String toString() {
    return '''PostMediumFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDPostMediumFormError extends PostMediumFormError { 
  const DocumentIDPostMediumFormError({ String? message, PostMediumModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDPostMediumFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class MemberMediumPostMediumFormError extends PostMediumFormError { 
  const MemberMediumPostMediumFormError({ String? message, PostMediumModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''MemberMediumPostMediumFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class PostMediumFormLoaded extends PostMediumFormInitialized { 
  const PostMediumFormLoaded({ PostMediumModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''PostMediumFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittablePostMediumForm extends PostMediumFormInitialized { 
  const SubmittablePostMediumForm({ PostMediumModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittablePostMediumForm {
      value: $value,
    }''';
  }
}


