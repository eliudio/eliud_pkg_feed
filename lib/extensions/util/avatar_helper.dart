import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/style/frontend/has_profile_photo.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_member.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:flutter/material.dart';

class AvatarHelper {
  static Future<ProfileAttributes> _getProfileAttributes(
      String authorId, String appId, String feedId) async {
    var key = authorId + "-" + feedId;
    var memberProfileModel =
        await memberProfileRepository(appId: appId)!.get(key);
    if (memberProfileModel != null) {
      var name = memberProfileModel.nameOverride;
      if ((name == null) & (memberProfileModel.author != null) && (memberProfileModel.author!.name != null)) {
         name = memberProfileModel.author!.name!;
      } else {
        name = '?';
      }
      return ProfileAttributes(
          name,
          memberProfileModel.profileOverride!.url);
    } else {
      var memberProfileModel = await memberPublicInfoRepository()!.get(authorId);
      // this might not yet exit, as it's created by firebase functions
      if (memberProfileModel != null) {
        return ProfileAttributes(
            memberProfileModel.name!,
            memberProfileModel.photoURL);
      } else {
        var memberModel = await memberRepository()!.get(authorId);
        // we might not have access, unless it's our own, or we're the owner of the app
        if (memberModel != null) {
          return ProfileAttributes(
              memberModel.name!,
              memberModel.photoURL);
        }
      }
    }
    return ProfileAttributes("?", null);
  }

  static Widget avatar(BuildContext context, double radius, String pageId,
      String memberId, String appId, String feedId) {
    return StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .profilePhotoStyle()
        .getProfilePhotoButtonFromExternalProvider(context,
            radius: radius,
            externalProfileURLProvider: () =>
                _getProfileAttributes(memberId, appId, feedId),
            onPressed: () {
              SwitchMember.switchMember(context, pageId, memberId);
            });
  }

  static Future<String?> _getName(
      String authorId, String appId) async {
    var memberPublicInfoModel = await memberPublicInfoRepository(appId: appId)!.get(authorId);
    if (memberPublicInfoModel != null) {
      return memberPublicInfoModel.name;
    }
    return null;
  }

  static Widget name(
      BuildContext context, String memberId, String appId, String feedId) {
    return FutureBuilder<String?>(
        future: _getName(memberId, appId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var name = snapshot.data!;
            return StyleRegistry.registry()
                .styleWithContext(context)
                .frontEndStyle()
                .textStyle()
                .h5(context, name, textAlign: TextAlign.left);
          }
          return StyleRegistry.registry()
              .styleWithContext(context)
              .frontEndStyle()
              .progressIndicatorStyle()
              .progressIndicator(context);
        });
  }
}
