import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

enum PostType {
  EmbeddedPage, SinglePhoto, SingleVideo, Album, ExternalLink, Html, OnlyDescription, Unknown
}

class PostTypeHelper {
  static PostType determineType(PostModel postModel) {
    if (postModel.postPageId != null) {
      return PostType.EmbeddedPage;
    } else if (postModel.html != null) {
      return PostType.Html;
    } else if ((postModel.memberMedia != null) &&
        (postModel.memberMedia!.length > 0)) {
      if (postModel.memberMedia!.length == 1) {
        var medium = postModel.memberMedia![0];
        if (medium.memberMedium == null) return PostType.OnlyDescription;
        if (medium.memberMedium!.mediumType != MediumType.Photo) return PostType.SinglePhoto;
        if (medium.memberMedium!.mediumType != MediumType.Video) return PostType.SingleVideo;
      } else {
        return PostType.Album;
      }
    } else if (postModel.externalLink != null) {
      return PostType.ExternalLink;
    } else {
      return PostType.OnlyDescription;
    }

    return PostType.Unknown;
  }

  static bool canUpdate(PostType type) {
    return (type == PostType.SinglePhoto) || (type == PostType.SingleVideo) || (type == PostType.Album) || (type == PostType.OnlyDescription) || (type == PostType.Html);
  }
}

