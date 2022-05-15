import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/model/app_model.dart';
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
  Widget createNew({Key? key, required AppModel app, required String id, Map<String, dynamic>? parameters}) {
    return ProfileComponent(key: key, app: app, id: id);
  }

  @override
  Future<dynamic> getModel({required AppModel app, required String id}) async => await profileRepository(appId: app.documentID!)!.get(id);
}

class ProfileComponent extends AbstractProfileComponent {
  ProfileComponent({Key? key, required AppModel app, required String id}) : super(key: key, app: app, profileId: id);

  @override
  Widget yourWidget(BuildContext context, ProfileModel? profileModel) {
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    var feedId = profileModel!.feed!.documentID!;

    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
          if (accessState is AccessDetermined) {
            return BlocProvider<ProfileBloc>(
                create: (context) =>
                ProfileBloc()
                  ..add(InitialiseProfileEvent(app,
                      feedId, accessState, modalRoute)),
                child: Profile(app: app, backgroundOverride: profileModel.backgroundOverride,)
            );
          } else {
            return progressIndicator(app, context);
          }
        });
  }

}
