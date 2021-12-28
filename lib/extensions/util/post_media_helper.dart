import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';

class PostMediaHelper {
  static Widget staggeredMemberMediumModelFromPostMedia(BuildContext context, AppModel app, List<PostMediumModel> media,
      {Function(int index)? deleteAction, Function(int index)? viewAction}) {
    var mmm = media.map((pm) => pm.memberMedium!).toList();
    return MediaHelper.staggeredMemberMediumModel(app, context, mmm,
        deleteAction: deleteAction, viewAction: viewAction);
  }
}
