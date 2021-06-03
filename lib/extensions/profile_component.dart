import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_feed/extensions/util/profile_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:eliud_pkg_feed/model/profile_component.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';
import 'package:eliud_pkg_feed/model/profile_repository.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:flutter/material.dart';

import 'profile/profile.dart';

class ProfileComponentConstructorDefault implements ComponentConstructor {
  ProfileComponentConstructorDefault();

  Widget createNew({String? id, Map<String, dynamic>? parameters}) {
    return ProfileComponent(id: id);
  }
}

class ProfileComponent extends AbstractProfileComponent {
  ProfileComponent({String? id}) : super(profileID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, ProfileModel? profileModel) {
    var _accessState = AccessBloc.getState(context);
    return FutureBuilder<ProfileHelper?>(
        future: ProfileHelper.getProfileInformation(context, profileModel!.feed!.documentID!, _accessState, profileModel!.appId!),
        builder: (context, snapshot) {
          if (snapshot.hasData)  {
            var profileInformation = snapshot.data!;
            return Profile(appId: profileModel!.appId!,profileHelper: profileInformation);
          }
          return Center(
            child: DelayedCircularProgressIndicator(),
          );
        }
    );
  }

  @override
  ProfileRepository getProfileRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .profileRepository(AccessBloc.appId(context))!;
  }
}
