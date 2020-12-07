/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action_model.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_core/tools/action_entity.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';


@immutable
abstract class FeedFormEvent extends Equatable {
  const FeedFormEvent();

  @override
  List<Object> get props => [];
}

class InitialiseNewFeedFormEvent extends FeedFormEvent {
}


class InitialiseFeedFormEvent extends FeedFormEvent {
  final FeedModel value;

  @override
  List<Object> get props => [ value ];

  InitialiseFeedFormEvent({this.value});
}

class InitialiseFeedFormNoLoadEvent extends FeedFormEvent {
  final FeedModel value;

  @override
  List<Object> get props => [ value ];

  InitialiseFeedFormNoLoadEvent({this.value});
}

class ChangedFeedDocumentID extends FeedFormEvent {
  final String value;

  ChangedFeedDocumentID({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedFeedDocumentID{ value: $value }';
}

class ChangedFeedAppId extends FeedFormEvent {
  final String value;

  ChangedFeedAppId({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedFeedAppId{ value: $value }';
}

class ChangedFeedDescription extends FeedFormEvent {
  final String value;

  ChangedFeedDescription({this.value});

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'ChangedFeedDescription{ value: $value }';
}

