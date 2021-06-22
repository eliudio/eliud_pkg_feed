import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/profile_component.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';
import 'package:eliud_pkg_feed/model/profile_repository.dart';
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
    if (_accessState is AppLoaded) {
      return Profile(appId: _accessState.app.documentID!);
    } else {
      return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'No app loaded');
    }
  }

  @override
  ProfileRepository getProfileRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .profileRepository(AccessBloc.appId(context))!;
  }
}
