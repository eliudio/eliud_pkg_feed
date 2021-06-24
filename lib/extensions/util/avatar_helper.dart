import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/style/frontend/has_profile_photo.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_member.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:flutter/material.dart';

class AvatarHelper {
  static Future<ProfileAttributes> _getFutureProfileAttributes(
      String memberId, String authorId, String appId, String feedId) async {
    var key = authorId + "-" + feedId;
    var memberProfileModel =
        await memberProfileRepository(appId: appId)!.get(key);
    if (memberProfileModel != null) {
      // In theory a person can create multiple profiles. However, we use the first only.
      var value = memberProfileModel;
      if (value.profileOverride != null)
        return ProfileAttributes(value.profileOverride!.url);
    }
    return ProfileAttributes(null);
  }

  static Widget avatar(BuildContext context, double radius, String pageId,
      String memberId, String url, String appId, String feedId) {
    return StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .profilePhotoStyle()
        .getProfilePhotoButtonFromExternalProvider(context,
            radius: radius,
            fallBackURLProvider: () => url,
            externalProfileURLProvider: () =>
                _getFutureProfileAttributes(memberId, memberId, appId, feedId),
            onPressed: () {
              SwitchMember.switchMember(context, pageId, memberId);
            });
  }
}
