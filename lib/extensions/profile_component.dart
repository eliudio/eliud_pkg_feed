import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_menu_repository.dart';

import 'feed_menu/feed_menu.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/profile_component.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';
import 'package:eliud_pkg_feed/model/profile_repository.dart';
import 'package:flutter/material.dart';

import 'profile/profile.dart';

class ProfileComponentConstructorDefault implements ComponentConstructor {
  ProfileComponentConstructorDefault();

  @override
  Widget createNew({Key? key, required String id, Map<String, dynamic>? parameters}) {
    return ProfileComponent(key: key, id: id);
  }

  @override
  Future<dynamic> getModel({required String appId, required String id}) async => await profileRepository(appId: appId)!.get(id);
}

class ProfileComponent extends AbstractProfileComponent {
  ProfileComponent({Key? key, required String id}) : super(key: key, profileID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, ProfileModel? profileModel) {
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    var feedId = profileModel!.feed!.documentID!;
    var _accessState = AccessBloc.getState(context);
    if (_accessState is AppLoaded) {
      return BlocProvider<ProfileBloc>(
          create: (context) =>
          ProfileBloc()
            ..add(InitialiseProfileEvent(
                feedId, _accessState, modalRoute)),
          child: Profile(appId: _accessState.app.documentID!)
      );
    } else {
      return text(context, 'App not loaded');
    }
  }

  @override
  ProfileRepository getProfileRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .profileRepository(AccessBloc.appId(context))!;
  }
}
