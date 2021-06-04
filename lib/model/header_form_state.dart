/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'header_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HeaderFormState extends Equatable {
  const HeaderFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class HeaderFormUninitialized extends HeaderFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''HeaderFormState()''';
  }
}

// HeaderModel has been initialised and hence HeaderModel is available
class HeaderFormInitialized extends HeaderFormState {
  final HeaderModel? value;

  @override
  List<Object?> get props => [ value ];

  const HeaderFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class HeaderFormError extends HeaderFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const HeaderFormError({this.message, HeaderModel? value }) : super(value: value);

  @override
  String toString() {
    return '''HeaderFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDHeaderFormError extends HeaderFormError { 
  const DocumentIDHeaderFormError({ String? message, HeaderModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDHeaderFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdHeaderFormError extends HeaderFormError { 
  const AppIdHeaderFormError({ String? message, HeaderModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdHeaderFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class DescriptionHeaderFormError extends HeaderFormError { 
  const DescriptionHeaderFormError({ String? message, HeaderModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DescriptionHeaderFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class FeedHeaderFormError extends HeaderFormError { 
  const FeedHeaderFormError({ String? message, HeaderModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''FeedHeaderFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ConditionsHeaderFormError extends HeaderFormError { 
  const ConditionsHeaderFormError({ String? message, HeaderModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ConditionsHeaderFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class HeaderFormLoaded extends HeaderFormInitialized { 
  const HeaderFormLoaded({ HeaderModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''HeaderFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableHeaderForm extends HeaderFormInitialized { 
  const SubmittableHeaderForm({ HeaderModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableHeaderForm {
      value: $value,
    }''';
  }
}


