import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/header_component.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';
import 'package:eliud_pkg_feed/model/header_repository.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'header/header.dart';

class HeaderComponentConstructorDefault implements ComponentConstructor {
  HeaderComponentConstructorDefault();

  @override
  Widget createNew({Key? key, required String id, Map<String, dynamic>? parameters}) {
    return HeaderComponent(key: key, id: id);
  }

  @override
  Future<dynamic> getModel({required String appId, required String id}) async => await headerRepository(appId: appId)!.get(id);
}

class HeaderComponent extends AbstractHeaderComponent {
  HeaderComponent({Key? key, required String id}) : super(key: key, headerID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, HeaderModel? headerModel) {
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    var feedId = headerModel!.feed!.documentID!;
    var _accessState = AccessBloc.getState(context);
    if (_accessState is AppLoaded) {
      return BlocProvider<ProfileBloc>(
          create: (context) =>
          ProfileBloc()
            ..add(InitialiseProfileEvent(
                feedId, _accessState, modalRoute)),
          child:      Header()
    );
    } else {
      return text(context, 'App not loaded');
    }
  }

  @override
  HeaderRepository getHeaderRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .headerRepository(AccessBloc.appId(context))!;
  }
}
