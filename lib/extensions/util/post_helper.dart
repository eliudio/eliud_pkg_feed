import 'package:eliud_core/platform/storage_platform.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';

typedef PhotoWithThumbnailTrigger(
    PostModel postModel, PhotoWithThumbnail photoWithThumbnail);
typedef VideoWithThumbnailTrigger(
    PostModel postModel, VideoWithThumbnail videoWithThumbnail);

class PostHelper {
  static Widget getFormattedPost(List<Widget> children) {
    return Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
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

  static PopupMenuButton mediaButtons(
      BuildContext context,
      PhotoWithThumbnailAvailable photoWithThumbnailAvailable,
      VideoWithThumbnailAvailable videoWithThumbnailAvailable) {
    var items = <PopupMenuItem<int>>[];
    if (AbstractStoragePlatform.platform!.hasCamera()) {
      items.add(
        PopupMenuItem<int>(child: const Text('Take photo'), value: 0),
      );
    }
    items.add(
        new PopupMenuItem<int>(child: const Text('Upload photo'), value: 1));
    if (AbstractStoragePlatform.platform!.hasCamera()) {
      items.add(
        PopupMenuItem<int>(child: const Text('Take video'), value: 2),
      );
    }
    items.add(
        new PopupMenuItem<int>(child: const Text('Upload video'), value: 3));
    return PopupMenuButton(
        color: Colors.red,
        icon: Icon(
          Icons.add,
        ),
        itemBuilder: (_) => items,
        onSelected: (choice) {
          if (choice == 0) {
            AbstractStoragePlatform.platform!.takePhoto(
              context,
              (value) => photoWithThumbnailAvailable(value),
            );
          }
          if (choice == 1) {
            AbstractStoragePlatform.platform!.uploadPhoto(
              context,
              (value) => photoWithThumbnailAvailable(value),
            );
          }
          if (choice == 2) {
            AbstractStoragePlatform.platform!.takeVideo(
              context,
              (value) => videoWithThumbnailAvailable(value),
            );
          }
          if (choice == 3) {
            AbstractStoragePlatform.platform!.uploadVideo(
              context,
              (value) => videoWithThumbnailAvailable(value),
            );
          }
        });
  }
}
