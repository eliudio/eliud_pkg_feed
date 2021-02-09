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

import 'post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostFormState extends Equatable {
  const PostFormState();

  @override
  List<Object> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class PostFormUninitialized extends PostFormState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '''PostFormState()''';
  }
}

// PostModel has been initialised and hence PostModel is available
class PostFormInitialized extends PostFormState {
  final PostModel value;

  @override
  List<Object> get props => [ value ];

  const PostFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class PostFormError extends PostFormInitialized {
  final String message;

  @override
  List<Object> get props => [ message, value ];

  const PostFormError({this.message, PostModel value }) : super(value: value);

  @override
  String toString() {
    return '''PostFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDPostFormError extends PostFormError { 
  const DocumentIDPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AuthorPostFormError extends PostFormError { 
  const AuthorPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''AuthorPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class TimestampPostFormError extends PostFormError { 
  const TimestampPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''TimestampPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdPostFormError extends PostFormError { 
  const AppIdPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class PostAppIdPostFormError extends PostFormError { 
  const PostAppIdPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''PostAppIdPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class PostPageIdPostFormError extends PostFormError { 
  const PostPageIdPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''PostPageIdPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class PageParametersPostFormError extends PostFormError { 
  const PageParametersPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''PageParametersPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class DescriptionPostFormError extends PostFormError { 
  const DescriptionPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''DescriptionPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class LikesPostFormError extends PostFormError { 
  const LikesPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''LikesPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class DislikesPostFormError extends PostFormError { 
  const DislikesPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''DislikesPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ReadAccessPostFormError extends PostFormError { 
  const ReadAccessPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''ReadAccessPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ArchivedPostFormError extends PostFormError { 
  const ArchivedPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''ArchivedPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class MemberImagesPostFormError extends PostFormError { 
  const MemberImagesPostFormError({ String message, PostModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''MemberImagesPostFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class PostFormLoaded extends PostFormInitialized { 
  const PostFormLoaded({ PostModel value }): super(value: value);

  @override
  List<Object> get props => [ value ];

  @override
  String toString() {
    return '''PostFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittablePostForm extends PostFormInitialized { 
  const SubmittablePostForm({ PostModel value }): super(value: value);

  @override
  List<Object> get props => [ value ];

  @override
  String toString() {
    return '''SubmittablePostForm {
      value: $value,
    }''';
  }
}


