import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/storage/fb_storage_image.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';

class PostMediaHelper {
  static Widget staggeredMemberMediumModelFromPostMedia(BuildContext context, List<PostMediumModel> media,
      {Function(int index)? deleteAction, Function(int index)? viewAction}) {
    var mmm = media.map((pm) => pm.memberMedium!).toList();
    return MediaHelper.staggeredMemberMediumModel(context, mmm,
        deleteAction: deleteAction, viewAction: viewAction);
  }
}
