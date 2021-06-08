import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/storage/fb_storage_image.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';

class AvatarHelper {

  static Future<String?> _getFuture(String memberId, String authorId, String appId, String feedId) async {
    var key = authorId + "-" + feedId;
    var memberProfileModel = await memberProfileRepository(appId: appId)!.get(key);
    if (memberProfileModel != null) {
      // In theory a person can create multiple profiles. However, we use the first only.
      var value = memberProfileModel;
      if (value!.profileOverride == null) return null;
      return value!.profileOverride!.url;
    } else {
      return null;
    }
  }

  /*
   * Not specifying the memberModel type allows to use MemberModel as well as MemberPublicInfoModel
   */
  static Widget avatar(memberModel, String appId, String feedId) {
    if (memberModel == null) {
      return Text("No member");
    } else {
      return FutureBuilder<String?>(
          future: _getFuture(memberModel.documentID!, memberModel.documentID!, appId, feedId) ,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: snapshot.data!,
              );
            } else if (memberModel.photoURL == null) {
              return Image.asset(
                  "assets/images/undraw.co/undraw_profile_pic_ic5t.png",
                  package: "eliud_pkg_feed");
            } else {
              return FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: memberModel.photoURL!,
              );
            }
          });
    }
  }

  static double circle1Size = 5.0;
  static double circle2Size = 5.0;
  static double circle3Size = 5.0;

  static Widget _getIt(String url, double radius, Color? backgroundColor, Color? backgroundColor2) {
    return CircleAvatar(
        radius: radius + circle1Size + circle2Size + circle3Size,
        backgroundColor: backgroundColor == null
            ? Colors.transparent
            : backgroundColor,
        child: CircleAvatar(
            radius: radius + circle1Size + circle2Size,
            backgroundColor: backgroundColor2 == null
                ? Colors.transparent
                : backgroundColor2,
            backgroundImage: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: url,
            ).image,
            child: CircleAvatar(
              radius: radius + circle1Size,
              backgroundColor: Colors.transparent,
            )));
  }

  static Widget avatar2(memberModel, String appId, String feedId, double radius,
      {Color? backgroundColor, Color? backgroundColor2}) {
    var avatar;
    if (memberModel == null) {
      return Text("No avatar");
    } else {
      return FutureBuilder<String?>(
          future: _getFuture(memberModel.documentID!, memberModel.documentID!, appId, feedId) ,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _getIt(snapshot.data!, radius, backgroundColor, backgroundColor2);
            } else if (memberModel.photoURL == null) {
              return CircleAvatar(
                radius: radius == null ? 12 : radius,
                backgroundColor: backgroundColor == null
                    ? Colors.transparent
                    : backgroundColor,
                backgroundImage: Image.asset(
                        "assets/images/undraw.co/undraw_profile_pic_ic5t.png",
                        package: "eliud_pkg_feed")
                    .image,
              );
            } else {
              return _getIt(memberModel.photoURL!,radius, backgroundColor, backgroundColor2);
            }
            // add gesturethingy and :
          });
    }
  }

  static Widget _defaultAvatar() {
    return PostHelper.getFormattedCircleShape(Image.asset(
        "assets/images/undraw.co/undraw_profile_pic_ic5t.png",
        package: "eliud_pkg_feed"));
  }

  static Widget avatarProfile(MemberPublicInfoModel memberModel,
      MemberProfileModel memberProfileModel) {
    var avatar;
    if ((memberModel == null) ||
        (memberModel.photoURL == null) && (memberProfileModel == null) ||
        (memberProfileModel.profileOverride == null) ||
        (memberProfileModel.profileOverride!.ref == null)) {
      return _defaultAvatar();
    } else {
      if ((memberProfileModel == null) ||
          (memberProfileModel.profileOverride == null) ||
          (memberProfileModel.profileOverride!.ref == null)) {
        return PostHelper.getFormattedCircleShape(FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: memberModel.photoURL!,
          fit: BoxFit.fill,
        ));
      } else {
        return PostHelper.getFormattedCircleShape(FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: memberProfileModel.profileOverride!.url!,
          fit: BoxFit.cover,
        ));
//        return PostHelper.getFormattedCircleShape(FbStorageImage(ref: memberProfileModel.profileOverride!.ref!));
      }
    }
  }
}
