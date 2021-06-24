import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/tools/component_info.dart';
import 'package:eliud_core/core/tools/page_body.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
 * Every feed-component, e.g. Header, Profile, ... could all have a BlocProvider as below.
 * However, it causes a slight delay in displaying and when scrolling up or down, that delay can cause some flickering of the components on screen.
 * To prevent this, we introduce this component widget wrapper which creates the bloc.
 *
 * How:
 * 1. The feed pages are configured with this widget wrapper
 * 2. The feed packageFeedPackage registers this wrapper
 *
 * By doing so, when the page is loaded, it calls this wrapWidget with the componentInfo, rather than construct itself
 *
 */
class ProfileWidgetWrapper extends ComponentWidgetWrapper {
  final String feedId;

  ProfileWidgetWrapper(this.feedId);

  @override
  Widget wrapWidget(BuildContext context, ComponentInfo componentInfo) {
    // For example we could find the feeds component and than take the
    var _accessState = AccessBloc.getState(context);
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    if (_accessState is AppLoaded) {
      return BlocProvider<ProfileBloc>(
        create: (context) =>
        ProfileBloc()
          ..add(InitialiseProfileEvent(
              feedId, _accessState, modalRoute)),
        child: PageBody(componentInfo: componentInfo,));
    } else {
      return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'App not loaded');
    }
  }
}