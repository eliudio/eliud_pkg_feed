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

    // first try to get the information from memberProfileRepository
    var memberProfileModel =
        await memberProfileRepository(appId: appId)!.get(key, onError: (err) {});
    if (memberProfileModel != null) {
      var name = memberProfileModel.nameOverride;
      var photoURL = memberProfileModel.profileOverride != null ? memberProfileModel.profileOverride! : null;
      if (name != null) {
        return ProfileAttributes(
            name,
            photoURL);
      }
    }

    // second, this might not yet exit, as it's created by firebase functions
    var memberPub = await memberPublicInfoRepository()!.get(authorId);
    if (memberPub != null) {
      var name = memberPub.name;
      var photoURL = memberPub.photoURL;
      if (name != null) {
        return ProfileAttributes(
            name,
            photoURL);
      }
    }

    // third, we might not have access, unless it's our own, or we're the owner of the app
    var memberModel = await memberRepository()!.get(authorId);
    if (memberModel != null) {
      var name = memberModel.name;
      var photoURL = memberModel.photoURL;
      if (name != null) {
        return ProfileAttributes(
            name,
            photoURL);
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

  static Widget nameH1(
      BuildContext context, String memberId, String appId, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, appId, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().h1(context, profileAttributes.name);
            }
          }
          return StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context);
        });
  }

  static Widget nameH2(
      BuildContext context, String memberId, String appId, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, appId, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().h2(context, profileAttributes.name);
            }
          }
          return StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context);
        });
  }

  static Widget nameH3(
      BuildContext context, String memberId, String appId, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, appId, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().h3(context, profileAttributes.name);
            }
          }
          return StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context);
        });
  }

  static Widget nameH4(
      BuildContext context, String memberId, String appId, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, appId, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().h4(context, profileAttributes.name);
            }
          }
          return StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context);
        });
  }

  static Widget nameH5(
      BuildContext context, String memberId, String appId, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, appId, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().h5(context, profileAttributes.name);
            }
          }
          return StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context);
        });
  }

  static Widget nameText(
      BuildContext context, String memberId, String appId, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, appId, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, profileAttributes.name);
            }
          }
          return StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context);
        });
  }
}
