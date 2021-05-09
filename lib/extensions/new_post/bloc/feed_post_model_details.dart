/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FeedPostModelDetails {
  final String description;
  final List<String> mediaPaths;

  FeedPostModelDetails({required this.description, required this.mediaPaths});

  FeedPostModelDetails copyWith({String? description,  List<String>? mediaPaths, }) {
    return FeedPostModelDetails(description: description ?? this.description, mediaPaths: mediaPaths ?? this.mediaPaths, );
  }
}