import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';

class AvatarHelper {
  /*
   * Not specifying the memberModel type allows to use MemberModel as well as MemberPublicInfoModel
   */
  static Widget avatar(memberModel) {
    var avatar;
    if (memberModel == null) {
      avatar = Text("No avatar");
    } else {
      if (memberModel.photoURL == null) {
        avatar = Image.asset(
            "assets/images/undraw.co/undraw_profile_pic_ic5t.png",
            package: "eliud_pkg_feed");
      } else {
//        avatar = Image.asset("assets/images/undraw.co/undraw_profile_pic_ic5t.png",  package: "eliud_pkg_feed");
        avatar = FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: memberModel.photoURL!,
        );
      }
    }
    return avatar;
  }

  static double circle1Size = 5.0;
  static double circle2Size = 5.0;
  static double circle3Size = 5.0;

  static Widget avatar2(memberModel, double radius,
      {Color? backgroundColor, Color? backgroundColor2}) {
    var avatar;
    if (memberModel == null) {
      return Text("No avatar");
    } else {
      if (memberModel.photoURL == null) {
        return CircleAvatar(
          radius: radius == null ? 12 : radius,
          backgroundColor:
              backgroundColor == null ? Colors.transparent : backgroundColor,
          backgroundImage: Image.asset(
                  "assets/images/undraw.co/undraw_profile_pic_ic5t.png",
                  package: "eliud_pkg_feed")
              .image,
        );
      } else {
        return CircleAvatar(
            radius: radius + circle1Size + circle2Size + circle3Size,
            backgroundColor:
                backgroundColor == null ? Colors.transparent : backgroundColor,
                child: CircleAvatar(
                  radius: radius + circle1Size + circle2Size,
                  backgroundColor: backgroundColor2 == null
                      ? Colors.transparent
                      : backgroundColor2,
                  backgroundImage: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: memberModel.photoURL!,
                  ).image,
                    child: CircleAvatar(
                      radius: radius + circle1Size,
                      backgroundColor: Colors.transparent,
                )));
      }
      // add gesturethingy and :
    }
  }
}
