/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_front_form_event.dart
                       
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
abstract class FeedFrontFormEvent extends Equatable {
  const FeedFrontFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewFeedFrontFormEvent extends FeedFrontFormEvent {
}


class InitialiseFeedFrontFormEvent extends FeedFrontFormEvent {
  final FeedFrontModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseFeedFrontFormEvent({this.value});
}

class InitialiseFeedFrontFormNoLoadEvent extends FeedFrontFormEvent {
  final FeedFrontModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseFeedFrontFormNoLoadEvent({this.value});
}

class ChangedFeedFrontDocumentID extends FeedFrontFormEvent {
  final String? value;

  ChangedFeedFrontDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedFeedFrontDocumentID{ value: $value }';
}

class ChangedFeedFrontAppId extends FeedFrontFormEvent {
  final String? value;

  ChangedFeedFrontAppId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedFeedFrontAppId{ value: $value }';
}

class ChangedFeedFrontDescription extends FeedFrontFormEvent {
  final String? value;

  ChangedFeedFrontDescription({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedFeedFrontDescription{ value: $value }';
}

class ChangedFeedFrontFeed extends FeedFrontFormEvent {
  final String? value;

  ChangedFeedFrontFeed({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedFeedFrontFeed{ value: $value }';
}

class ChangedFeedFrontConditions extends FeedFrontFormEvent {
  final StorageConditionsModel? value;

  ChangedFeedFrontConditions({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedFeedFrontConditions{ value: $value }';
}

