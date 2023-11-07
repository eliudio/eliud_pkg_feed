import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

enum PostType {
  embeddedPage,
  singlePhoto,
  singleVideo,
  album,
  externalLink,
  html,
  onlyDescription,
  unknown
}

class PostTypeHelper {
  static PostType determineType(PostModel postModel) {
    if (postModel.postPageId != null) {
      return PostType.embeddedPage;
    } else if (postModel.html != null) {
      return PostType.html;
    } else if ((postModel.memberMedia != null) &&
        (postModel.memberMedia!.isNotEmpty)) {
      if (postModel.memberMedia!.length == 1) {
        var medium = postModel.memberMedia![0];
        if (medium.memberMedium == null) return PostType.onlyDescription;
        if (medium.memberMedium!.mediumType == MediumType.photo) {
          return PostType.singlePhoto;
        }
        if (medium.memberMedium!.mediumType == MediumType.video) {
          return PostType.singleVideo;
        }
      } else {
        return PostType.album;
      }
    } else if (postModel.externalLink != null) {
      return PostType.externalLink;
    } else {
      return PostType.onlyDescription;
    }

    return PostType.unknown;
  }

  static bool canUpdate(PostType type) {
    return (type == PostType.singlePhoto) ||
        (type == PostType.singleVideo) ||
        (type == PostType.album) ||
        (type == PostType.onlyDescription) ||
        (type == PostType.html);
  }
}
