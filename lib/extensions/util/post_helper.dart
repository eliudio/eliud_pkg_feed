import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/platform/storage_platform.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/firestore_helper.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';

typedef PhotoWithThumbnailTrigger(PostModel postModel, PhotoWithThumbnail photoWithThumbnail);
typedef VideoWithThumbnailTrigger(PostModel postModel, VideoWithThumbnail videoWithThumbnail);

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

  static PopupMenuButton mediaButtons(BuildContext context, PostModel? postModel, String memberID, PhotoWithThumbnailTrigger photoWithThumbnailTrigger, VideoWithThumbnailTrigger videoWithThumbnailTrigger) {
    return PopupMenuButton(
        color: Colors.red,
        icon: Icon(
          Icons.add,
        ),
        itemBuilder: (_) => <PopupMenuItem<int>>[
          new PopupMenuItem<int>(
              child: const Text('Take photo'), value: 0),
          new PopupMenuItem<int>(
              child: const Text('Upload photo'), value: 1),
          new PopupMenuItem<int>(
              child: const Text('Take video'), value: 2),
          new PopupMenuItem<int>(
              child: const Text('Upload video'), value: 3),
        ],
        onSelected: (choice) {
          if (choice == 0) {
            AbstractStoragePlatform.platform!.takePhoto(
                context,
                postModel!.appId!,
                    (value) => photoWithThumbnailTrigger(postModel, value),
                memberID,);
          }
          if (choice == 1) {
            AbstractStoragePlatform.platform!.uploadPhoto(
              context,
              postModel!.appId!,
                  (value) => photoWithThumbnailTrigger(postModel, value),
              memberID,);
          }
          if (choice == 2) {
            AbstractStoragePlatform.platform!.takeVideo(
              context,
              postModel!.appId!,
                  (value) => videoWithThumbnailTrigger(postModel, value),
              memberID,);
          }
          if (choice == 3) {
            AbstractStoragePlatform.platform!.uploadVideo(
              context,
              postModel!.appId!,
                  (value) => videoWithThumbnailTrigger(postModel, value),
              memberID,);
          }
        });
  }
}
