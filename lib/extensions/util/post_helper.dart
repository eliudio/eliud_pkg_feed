import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/platform/medium_platform.dart';
import 'package:flutter/material.dart';

typedef PhotoWithThumbnailTrigger(
    PostModel postModel, PhotoWithThumbnail photoWithThumbnail);
typedef VideoWithThumbnailTrigger(
    PostModel postModel, VideoWithThumbnail videoWithThumbnail);

class PostHelper {
  static Widget getFormattedPost(List<Widget> children, {DecorationImage? image}) {
    return Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                image: image,
            border: Border.all(color: Colors.white, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.7),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: new BorderRadius.all(
                  const Radius.circular(10.0),
                )),
            child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ))));
  }

}
