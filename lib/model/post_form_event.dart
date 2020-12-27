/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


@immutable
abstract class PostFormEvent extends Equatable {
  const PostFormEvent();

  @override
  List<Object> get props => [];
}

class InitialiseNewPostFormEvent extends PostFormEvent {
}


class InitialisePostFormEvent extends PostFormEvent {
  final PostModel value;

  @override
  List<Object> get props => [ value ];

  InitialisePostFormEvent({this.value});
}

class InitialisePostFormNoLoadEvent extends PostFormEvent {
  final PostModel value;

  @override
  List<Object> get props => [ value ];

  InitialisePostFormNoLoadEvent({this.value});
}

class ChangedPostDocumentID extends PostFormEvent {
  final String value;

  ChangedPostDocumentID({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostDocumentID{ value: $value }';
}

class ChangedPostAuthor extends PostFormEvent {
  final String value;

  ChangedPostAuthor({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostAuthor{ value: $value }';
}

class ChangedPostTimestamp extends PostFormEvent {
  final String value;

  ChangedPostTimestamp({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostTimestamp{ value: $value }';
}

class ChangedPostAppId extends PostFormEvent {
  final String value;

  ChangedPostAppId({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostAppId{ value: $value }';
}

class ChangedPostPostAppId extends PostFormEvent {
  final String value;

  ChangedPostPostAppId({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostPostAppId{ value: $value }';
}

class ChangedPostPostPageId extends PostFormEvent {
  final String value;

  ChangedPostPostPageId({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostPostPageId{ value: $value }';
}

class ChangedPostPageParameters extends PostFormEvent {
  final Map<String, Object> value;

  ChangedPostPageParameters({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostPageParameters{ value: $value }';
}

class ChangedPostDescription extends PostFormEvent {
  final String value;

  ChangedPostDescription({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostDescription{ value: $value }';
}

class ChangedPostReadAccess extends PostFormEvent {
  final String value;

  ChangedPostReadAccess({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedPostReadAccess{ value: $value }';
}

