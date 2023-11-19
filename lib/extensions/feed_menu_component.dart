import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core_model/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_core_model/style/frontend/has_text.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';

import 'feed_menu/feed_menu.dart';

class FeedMenuComponentConstructorDefault implements ComponentConstructor {
  FeedMenuComponentConstructorDefault();

  @override
  Widget createNew(
      {Key? key,
      required AppModel app,
      required String id,
      Map<String, dynamic>? parameters}) {
    return FeedMenuComponent(key: key, app: app, id: id);
  }

  @override
  Future<dynamic> getModel({required AppModel app, required String id}) async =>
      await feedMenuRepository(appId: app.documentID)!.get(id);
}

class FeedMenuComponent extends AbstractFeedMenuComponent {
  FeedMenuComponent({super.key, required super.app, required String id})
      : super(feedMenuId: id);

  @override
  Widget yourWidget(BuildContext context, FeedMenuModel? value) {
    if (value == null) {
      return text(app, context, "feedMenuModel is null");
    }
    if (value.feedFront == null) {
      return text(app, context, "feedMenuModel.feedFront is null");
    }
    if (value.feedFront!.feed == null) {
      return text(app, context, "feedMenuModel.feedFront!.feed is null");
    }
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    var feedId = value.feedFront!.feed!.documentID;
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
      if (accessState is AccessDetermined) {
        return BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc()
              ..add(
                  InitialiseProfileEvent(app, feedId, accessState, modalRoute)),
            child: FeedMenu(app, value));
      } else {
        return progressIndicator(app, context);
      }
    });
  }
}
