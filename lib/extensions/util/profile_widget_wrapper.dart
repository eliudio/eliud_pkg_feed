import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/tools/component_info.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_page_body.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
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
  final AppModel app;
  final String feedId;

  ProfileWidgetWrapper(this.app, this.feedId);

  @override
  Widget wrapWidget(BuildContext context, ComponentInfo componentInfo) {
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
          if (accessState is AccessDetermined) {
            return BlocProvider<ProfileBloc>(
                create: (context) =>
                ProfileBloc()
                  ..add(InitialiseProfileEvent(app,
                      feedId, accessState, modalRoute)),
                child: pageBody(app, context,
                    backgroundOverride: componentInfo.backgroundOverride,
                    components: componentInfo.widgets,
                    layout: componentInfo.layout,
                    gridView: componentInfo.gridView));
          } else {
            return progressIndicator(app, context);
          }
        });
  }
}
