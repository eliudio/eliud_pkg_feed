/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';

abstract class HeaderComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchHeaderComponent extends HeaderComponentEvent {
  final String? id;

  FetchHeaderComponent({ this.id });
}

class HeaderComponentUpdated extends HeaderComponentEvent {
  final HeaderModel value;

  HeaderComponentUpdated({ required this.value });
}


