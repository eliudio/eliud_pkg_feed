/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_profile_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'member_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MemberProfileFormState extends Equatable {
  const MemberProfileFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class MemberProfileFormUninitialized extends MemberProfileFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''MemberProfileFormState()''';
  }
}

// MemberProfileModel has been initialised and hence MemberProfileModel is available
class MemberProfileFormInitialized extends MemberProfileFormState {
  final MemberProfileModel? value;

  @override
  List<Object?> get props => [ value ];

  const MemberProfileFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class MemberProfileFormError extends MemberProfileFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const MemberProfileFormError({this.message, MemberProfileModel? value }) : super(value: value);

  @override
  String toString() {
    return '''MemberProfileFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDMemberProfileFormError extends MemberProfileFormError { 
  const DocumentIDMemberProfileFormError({ String? message, MemberProfileModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDMemberProfileFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdMemberProfileFormError extends MemberProfileFormError { 
  const AppIdMemberProfileFormError({ String? message, MemberProfileModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdMemberProfileFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class FeedIdMemberProfileFormError extends MemberProfileFormError { 
  const FeedIdMemberProfileFormError({ String? message, MemberProfileModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''FeedIdMemberProfileFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AuthorMemberProfileFormError extends MemberProfileFormError { 
  const AuthorMemberProfileFormError({ String? message, MemberProfileModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AuthorMemberProfileFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ProfileMemberProfileFormError extends MemberProfileFormError { 
  const ProfileMemberProfileFormError({ String? message, MemberProfileModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ProfileMemberProfileFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ProfileBackgroundMemberProfileFormError extends MemberProfileFormError { 
  const ProfileBackgroundMemberProfileFormError({ String? message, MemberProfileModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ProfileBackgroundMemberProfileFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ProfileOverrideMemberProfileFormError extends MemberProfileFormError { 
  const ProfileOverrideMemberProfileFormError({ String? message, MemberProfileModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ProfileOverrideMemberProfileFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ReadAccessMemberProfileFormError extends MemberProfileFormError { 
  const ReadAccessMemberProfileFormError({ String? message, MemberProfileModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ReadAccessMemberProfileFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class MemberProfileFormLoaded extends MemberProfileFormInitialized { 
  const MemberProfileFormLoaded({ MemberProfileModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''MemberProfileFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableMemberProfileForm extends MemberProfileFormInitialized { 
  const SubmittableMemberProfileForm({ MemberProfileModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableMemberProfileForm {
      value: $value,
    }''';
  }
}


