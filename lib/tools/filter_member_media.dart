import 'package:eliud_core_main/model/member_medium_model.dart';
import 'package:eliud_core_model/model/member_medium_container_model.dart';

class FilterMemberMedia {
  final List<MemberMediumContainerModel> memberMedia;

  FilterMemberMedia(this.memberMedia);

  List<MemberMediumModel>? getPhotos() {
    var photos = memberMedia
        .where((medium) => medium.memberMedium!.mediumType == MediumType.photo)
        .map((postMediumModel) => postMediumModel.memberMedium!)
        .toList();
    if (photos.isEmpty) return null;
    return photos;
  }

  List<MemberMediumModel>? getVideos() {
    var videos = memberMedia
        .where((medium) => medium.memberMedium!.mediumType == MediumType.video)
        .map((postMediumModel) => postMediumModel.memberMedium!)
        .toList();
    if (videos.isEmpty) return null;
    return videos;
  }
}
