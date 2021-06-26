import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/style/frontend/has_profile_photo.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_member.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:flutter/material.dart';

class AvatarHelper {
  static Future<ProfileAttributes> _getFutureProfileAttributes(
      String authorId, String appId, String feedId) async {
    var key = authorId + "-" + feedId;
    var memberProfileModel =
        await memberProfileRepository(appId: appId)!.get(key);
    if ((memberProfileModel != null) &&
        (memberProfileModel.profileOverride != null)) {
      return ProfileAttributes(
          memberProfileModel.author != null &&
                  memberProfileModel.author!.name != null
              ? memberProfileModel.author!.name!
              : '?',
          memberProfileModel.profileOverride!.url);
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
                _getFutureProfileAttributes(memberId, appId, feedId),
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
