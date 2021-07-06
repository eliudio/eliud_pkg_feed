import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_text/platform/text_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/storage/fb_storage_image.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_pkg_feed/extensions/util/post_media_helper.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';

import 'embedded_page.dart';

enum PostType {
  EmbeddedPage, SinglePhoto, SingleVideo, Album, ExternalLink, Html, OnlyDescription, Unknown
}

class PostTypeHelper {
  static PostType determineType(PostModel postModel) {
    if (postModel.postPageId != null) {
      return PostType.EmbeddedPage;
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
    } else if (postModel.html != null) {
      return PostType.Html;
    } else {
      return PostType.OnlyDescription;
    }

    return PostType.Unknown;
  }

  static bool canUpdate(PostType type) {
    return (type == PostType.SinglePhoto) || (type == PostType.SingleVideo) || (type == PostType.Album) || (type == PostType.OnlyDescription) || (type == PostType.Html);
  }
}

