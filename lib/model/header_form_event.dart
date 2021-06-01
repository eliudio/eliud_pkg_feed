/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_form_event.dart
                       
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
abstract class HeaderFormEvent extends Equatable {
  const HeaderFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewHeaderFormEvent extends HeaderFormEvent {
}


class InitialiseHeaderFormEvent extends HeaderFormEvent {
  final HeaderModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseHeaderFormEvent({this.value});
}

class InitialiseHeaderFormNoLoadEvent extends HeaderFormEvent {
  final HeaderModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseHeaderFormNoLoadEvent({this.value});
}

class ChangedHeaderDocumentID extends HeaderFormEvent {
  final String? value;

  ChangedHeaderDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedHeaderDocumentID{ value: $value }';
}

class ChangedHeaderAppId extends HeaderFormEvent {
  final String? value;

  ChangedHeaderAppId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedHeaderAppId{ value: $value }';
}

class ChangedHeaderDescription extends HeaderFormEvent {
  final String? value;

  ChangedHeaderDescription({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedHeaderDescription{ value: $value }';
}

class ChangedHeaderConditions extends HeaderFormEvent {
  final ConditionsSimpleModel? value;

  ChangedHeaderConditions({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedHeaderConditions{ value: $value }';
}

