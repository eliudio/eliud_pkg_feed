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

  static PopupMenuButton mediaButtons(
    BuildContext context,
    String appId,
    String ownerId,
    List<String> readAccess,
    MemberMediumAvailable photoFeedbackFunction,
    FeedbackProgress photoFeedbackProgress,
    MemberMediumAvailable videoFeedbackFunction,
    FeedbackProgress videoFeedbackProgress,
  ) {
    var items = <PopupMenuItem<int>>[];
    if (AbstractMediumPlatform.platform!.hasCamera()) {
      items.add(
        PopupMenuItem<int>(child: const Text('Take photo'), value: 0),
      );
    }
    items.add(
        new PopupMenuItem<int>(child: const Text('Upload photo'), value: 1));
    if (AbstractMediumPlatform.platform!.hasCamera()) {
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
            AbstractMediumPlatform.platform!.takePhoto(context, appId, ownerId,
                readAccess, photoFeedbackFunction, photoFeedbackProgress);
          }
          if (choice == 1) {
            AbstractMediumPlatform.platform!.uploadPhoto(
                context,
                appId,
                ownerId,
                readAccess,
                photoFeedbackFunction,
                photoFeedbackProgress);
          }
          if (choice == 2) {
            AbstractMediumPlatform.platform!.takeVideo(context, appId, ownerId,
                readAccess, videoFeedbackFunction, videoFeedbackProgress);
          }
          if (choice == 3) {
            AbstractMediumPlatform.platform!.uploadVideo(
                context,
                appId,
                ownerId,
                readAccess,
                videoFeedbackFunction,
                videoFeedbackProgress);
          }
        });
  }
}
