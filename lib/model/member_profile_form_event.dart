/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_profile_form_event.dart
                       
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
abstract class MemberProfileFormEvent extends Equatable {
  const MemberProfileFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewMemberProfileFormEvent extends MemberProfileFormEvent {
}


class InitialiseMemberProfileFormEvent extends MemberProfileFormEvent {
  final MemberProfileModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseMemberProfileFormEvent({this.value});
}

class InitialiseMemberProfileFormNoLoadEvent extends MemberProfileFormEvent {
  final MemberProfileModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseMemberProfileFormNoLoadEvent({this.value});
}

class ChangedMemberProfileDocumentID extends MemberProfileFormEvent {
  final String? value;

  ChangedMemberProfileDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedMemberProfileDocumentID{ value: $value }';
}

class ChangedMemberProfileAppId extends MemberProfileFormEvent {
  final String? value;

  ChangedMemberProfileAppId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedMemberProfileAppId{ value: $value }';
}

class ChangedMemberProfileProfile extends MemberProfileFormEvent {
  final String? value;

  ChangedMemberProfileProfile({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedMemberProfileProfile{ value: $value }';
}

class ChangedMemberProfileProfileBackground extends MemberProfileFormEvent {
  final String? value;

  ChangedMemberProfileProfileBackground({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedMemberProfileProfileBackground{ value: $value }';
}

class ChangedMemberProfileProfileOverride extends MemberProfileFormEvent {
  final String? value;

  ChangedMemberProfileProfileOverride({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedMemberProfileProfileOverride{ value: $value }';
}

class ChangedMemberProfileReadAccess extends MemberProfileFormEvent {
  final String? value;

  ChangedMemberProfileReadAccess({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedMemberProfileReadAccess{ value: $value }';
}

