/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_medium_form_event.dart
                       
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
abstract class PostMediumFormEvent extends Equatable {
  const PostMediumFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewPostMediumFormEvent extends PostMediumFormEvent {
}


class InitialisePostMediumFormEvent extends PostMediumFormEvent {
  final PostMediumModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialisePostMediumFormEvent({this.value});
}

class InitialisePostMediumFormNoLoadEvent extends PostMediumFormEvent {
  final PostMediumModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialisePostMediumFormNoLoadEvent({this.value});
}

class ChangedPostMediumDocumentID extends PostMediumFormEvent {
  final String? value;

  ChangedPostMediumDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedPostMediumDocumentID{ value: $value }';
}

class ChangedPostMediumMemberMedium extends PostMediumFormEvent {
  final String? value;

  ChangedPostMediumMemberMedium({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedPostMediumMemberMedium{ value: $value }';
}

