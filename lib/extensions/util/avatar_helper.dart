import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_profile_photo.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_member.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:flutter/material.dart';

class AvatarHelper {
  static Future<ProfileAttributes> _getProfileAttributes(
      String authorId, AppModel app, String feedId) async {
    var key = authorId + "-" + feedId;

    // first try to get the information from memberProfileRepository
    var memberProfileModel =
        await memberProfileRepository(appId: app.documentID!)!.get(key, onError: (err) {});
    var name;
    var photoURL;
    if (memberProfileModel != null) {
      name = memberProfileModel.nameOverride;
      photoURL = memberProfileModel.profileOverride != null ? memberProfileModel.profileOverride! : null;
    }

    // do we have name and photo?
    if ((name != null) && (photoURL != null)) {
      return ProfileAttributes(
          name,
          photoURL);
    }

    // second, this might not yet exit, as it's created by firebase functions
    var memberPub = await memberPublicInfoRepository()!.get(authorId);
    if (memberPub != null) {
      name ??= memberPub.name;
      photoURL ??= memberPub.photoURL;
    }

    // do we have name and photo?
    if ((name != null) && (photoURL != null)) {
      return ProfileAttributes(
          name,
          photoURL);
    }

    // third, we might not have access, unless it's our own, or we're the owner of the app
    var memberModel = await memberRepository()!.get(authorId);
    if (memberModel != null) {
      name ??= memberModel.name;
      photoURL ??= memberModel.photoURL;
    }

    // do we have name and photo?
    if ((name != null) && (photoURL != null)) {
      return ProfileAttributes(
          name,
          photoURL);
    }
    return ProfileAttributes("?", null);
  }

  static Widget avatar(BuildContext context, double radius, String pageId,
      String profileMemberId, String? currentMemberId, AppModel app, String feedId) {
    return getProfilePhotoButtonFromExternalProvider(app, context,
            radius: radius,
            externalProfileURLProvider: () =>
                _getProfileAttributes(profileMemberId, app, feedId),
            onPressed: () {
              SwitchMember.switchMember(context, app, pageId, profileMemberId, currentMemberId);
            });
  }

  static Widget nameH1(
      BuildContext context, String memberId, AppModel app, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, app, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return h1(app, context, profileAttributes.name);
            }
          }
          return progressIndicator(app, context);
        });
  }

  static Widget nameH2(
      BuildContext context, String memberId, AppModel app, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, app, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return h2(app, context, profileAttributes.name);
            }
          }
          return progressIndicator(app, context);
        });
  }

  static Widget nameH3(
      BuildContext context, String memberId, AppModel app, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, app, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return h3(app, context, profileAttributes.name);
            }
          }
          return progressIndicator(app, context);
        });
  }

  static Widget nameH4(
      BuildContext context, String memberId, AppModel app, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, app, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return h4(app, context, profileAttributes.name);
            }
          }
          return progressIndicator(app, context);
        });
  }

  static Widget nameH5(
      BuildContext context, String memberId, AppModel app, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, app, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return h5(app, context, profileAttributes.name);
            }
          }
          return progressIndicator(app, context);
        });
  }

  static Widget nameText(
      BuildContext context, String memberId, AppModel app, String feedId) {
    return FutureBuilder<ProfileAttributes>(
        future: _getProfileAttributes(memberId, app, feedId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var profileAttributes = snapshot.data;
            if (profileAttributes!.name != null) {
              return text(app, context, profileAttributes.name);
            }
          }
          return progressIndicator(app, context);
        });
  }
}
