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

import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/storage/firestore_helper.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FeedPostModelDetails {
  final String description;
  final List<MediumAndItsThumbnailData> mediumAndItsThumbnailDatas;

  FeedPostModelDetails({required this.description, required this.mediumAndItsThumbnailDatas});

  FeedPostModelDetails copyWith({String? description,  List<MediumAndItsThumbnailData>? mediumAndItsThumbnailDatas, }) {
    return FeedPostModelDetails(description: description ?? this.description, mediumAndItsThumbnailDatas: mediumAndItsThumbnailDatas ?? this.mediumAndItsThumbnailDatas, );
  }
}