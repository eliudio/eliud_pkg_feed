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
        avatar = Image.asset("assets/images/undraw.co/undraw_profile_pic_ic5t.png",  package: "eliud_pkg_feed");
      } else {
        avatar = FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: memberModel.photoURL!,
        );
      }
    }
    return avatar;
  }

  static Widget avatar2(memberModel) {
    var avatar;
    if (memberModel == null) {
      return Text("No avatar");
    } else {
      if (memberModel.photoURL == null) {
        return CircleAvatar(
          radius: 12,
          backgroundColor: Colors.transparent,
          backgroundImage: Image.asset("assets/images/undraw.co/undraw_profile_pic_ic5t.png",  package: "eliud_pkg_feed").image,
        );
      } else {
        return CircleAvatar(
          radius: 12,
          backgroundColor: Colors.transparent,
          backgroundImage: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: memberModel.photoURL!,
          ).image,
        );
      }
      // add gesturethingy and :
    }
  }

}
