import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:flutter/widgets.dart';
import 'package:eliud_pkg_feed/model/profile_component.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';
import 'package:eliud_pkg_feed/model/profile_repository.dart';
import 'profile/profile.dart';

class ProfileComponentConstructorDefault implements ComponentConstructor {
  ProfileComponentConstructorDefault();

  @override
  Widget createNew({Key? key, required String appId, required String id, Map<String, dynamic>? parameters}) {
    return ProfileComponent(key: key, appId: appId, id: id);
  }

  @override
  Future<dynamic> getModel({required String appId, required String id}) async => await profileRepository(appId: appId)!.get(id);
}

class ProfileComponent extends AbstractProfileComponent {
  ProfileComponent({Key? key, required String appId, required String id}) : super(key: key, theAppId: appId, profileId: id);

  @override
  Widget yourWidget(BuildContext context, ProfileModel? profileModel) {
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    var feedId = profileModel!.feed!.documentID!;

    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
          if (accessState is AccessDetermined) {
            var appId = accessState.currentAppId(context);
            return BlocProvider<ProfileBloc>(
                create: (context) =>
                ProfileBloc()
                  ..add(InitialiseProfileEvent(appId,
                      feedId, accessState, modalRoute)),
                child: Profile(appId: accessState.currentApp(context).documentID!)
            );
          } else {
            return progressIndicator(context);
          }
        });
  }

}
