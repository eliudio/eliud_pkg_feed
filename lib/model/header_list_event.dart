/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';

abstract class HeaderListEvent extends Equatable {
  const HeaderListEvent();
  @override
  List<Object?> get props => [];
}

class LoadHeaderList extends HeaderListEvent {}

class NewPage extends HeaderListEvent {}

class AddHeaderList extends HeaderListEvent {
  final HeaderModel? value;

  const AddHeaderList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddHeaderList{ value: $value }';
}

class UpdateHeaderList extends HeaderListEvent {
  final HeaderModel? value;

  const UpdateHeaderList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'UpdateHeaderList{ value: $value }';
}

class DeleteHeaderList extends HeaderListEvent {
  final HeaderModel? value;

  const DeleteHeaderList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'DeleteHeaderList{ value: $value }';
}

class HeaderListUpdated extends HeaderListEvent {
  final List<HeaderModel?>? value;
  final bool? mightHaveMore;

  const HeaderListUpdated({ this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore ];

  @override
  String toString() => 'HeaderListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

