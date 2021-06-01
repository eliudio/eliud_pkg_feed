/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 header_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';

abstract class HeaderListState extends Equatable {
  const HeaderListState();

  @override
  List<Object?> get props => [];
}

class HeaderListLoading extends HeaderListState {}

class HeaderListLoaded extends HeaderListState {
  final List<HeaderModel?>? values;
  final bool? mightHaveMore;

  const HeaderListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'HeaderListLoaded { values: $values }';
}

class HeaderNotLoaded extends HeaderListState {}

