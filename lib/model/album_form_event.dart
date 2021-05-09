/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_form_event.dart
                       
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
abstract class AlbumFormEvent extends Equatable {
  const AlbumFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewAlbumFormEvent extends AlbumFormEvent {
}


class InitialiseAlbumFormEvent extends AlbumFormEvent {
  final AlbumModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseAlbumFormEvent({this.value});
}

class InitialiseAlbumFormNoLoadEvent extends AlbumFormEvent {
  final AlbumModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseAlbumFormNoLoadEvent({this.value});
}

class ChangedAlbumDocumentID extends AlbumFormEvent {
  final String? value;

  ChangedAlbumDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumDocumentID{ value: $value }';
}

class ChangedAlbumAppId extends AlbumFormEvent {
  final String? value;

  ChangedAlbumAppId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumAppId{ value: $value }';
}

class ChangedAlbumPost extends AlbumFormEvent {
  final String? value;

  ChangedAlbumPost({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumPost{ value: $value }';
}

class ChangedAlbumDescription extends AlbumFormEvent {
  final String? value;

  ChangedAlbumDescription({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumDescription{ value: $value }';
}

class ChangedAlbumConditions extends AlbumFormEvent {
  final ConditionsSimpleModel? value;

  ChangedAlbumConditions({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedAlbumConditions{ value: $value }';
}
