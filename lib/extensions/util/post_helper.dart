import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/platform/storage_platform.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';

typedef PhotoAvailableTrigger(PostModel postModel, String path);

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

  static PopupMenuButton mediaButtons(BuildContext context, PostModel? postModel, String memberID, PhotoAvailableTrigger photoAvailableTrigger) {
    return PopupMenuButton(
        color: Colors.red,
        icon: Icon(
          Icons.add,
        ),
        itemBuilder: (_) => <PopupMenuItem<int>>[
          new PopupMenuItem<int>(
              child: const Text('Take photo or video'), value: 0),
        ],
        onSelected: (choice) {
          if (choice == 0) {
            AbstractStoragePlatform.platform!.takeMedium(
                context,
                postModel!.appId!,
                    (value) => photoAvailableTrigger(postModel, value),
                memberID,
                postModel.readAccess);
          }
        });
  }
}
