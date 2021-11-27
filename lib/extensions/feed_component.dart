import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'feed/feed.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedComponentConstructorDefault implements ComponentConstructor {
  FeedComponentConstructorDefault();

  @override
  Widget createNew(
      {Key? key,
      required String appId,
      required String id,
      Map<String, dynamic>? parameters}) {
    return FeedComponent(key: key, appId: appId, id: id);
  }

  @override
  Future<dynamic> getModel({required String appId, required String id}) async =>
      await feedRepository(appId: appId)!.get(id);
}

class FeedComponent extends AbstractFeedComponent {
  FeedComponent({Key? key, required String appId, required String id})
      : super(key: key, theAppId: appId, feedId: id);

  @override
  Widget yourWidget(BuildContext context, FeedModel? value) {
    var _accessState = AccessBloc.getState(context);
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    var feedId = value!.documentID!;
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
      if (accessState is AccessDetermined) {
        var appId = accessState.currentAppId(context);
        return BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc()
              ..add(InitialiseProfileEvent(appId,
                  feedId, accessState, modalRoute)),
            child: Feed(value));
      } else {
        return progressIndicator(context);
      }
    });
  }
}
