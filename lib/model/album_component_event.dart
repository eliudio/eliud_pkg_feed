/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 album_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';

abstract class AlbumComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAlbumComponent extends AlbumComponentEvent {
  final String? id;

  FetchAlbumComponent({ this.id });
}

