import 'package:eliud_core/model/member_medium_container_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';

class FilterMemberMedia {
  final List<MemberMediumContainerModel> memberMedia;

  FilterMemberMedia(this.memberMedia);

  List<MemberMediumModel>? getPhotos() {
    if (memberMedia == null) return null;
    var photos = memberMedia.where((medium) => medium.memberMedium!.mediumType == MediumType.Photo).map((postMediumModel) => postMediumModel.memberMedium!).toList();
    if (photos.length == 0) return null;
    return photos;
  }

  List<MemberMediumModel>? getVideos() {
    if (memberMedia == null) return null;
    var videos = memberMedia.where((medium) => medium.memberMedium!.mediumType == MediumType.Video).map((postMediumModel) => postMediumModel.memberMedium!).toList();
    if (videos.length == 0) return null;
    return videos;
  }

}
