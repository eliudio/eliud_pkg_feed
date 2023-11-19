import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core_model/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:eliud_pkg_feed/model/feed_front_component.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'feed_front/feed_front.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedFrontComponentConstructorDefault implements ComponentConstructor {
  FeedFrontComponentConstructorDefault();

  @override
  Widget createNew(
      {Key? key,
      required AppModel app,
      required String id,
      Map<String, dynamic>? parameters}) {
    return FeedFrontComponent(key: key, app: app, id: id);
  }

  @override
  Future<dynamic> getModel({required AppModel app, required String id}) async =>
      await feedFrontRepository(appId: app.documentID)!.get(id);
}

class FeedFrontComponent extends AbstractFeedFrontComponent {
  FeedFrontComponent({super.key, required super.app, required String id})
      : super(feedFrontId: id);

  @override
  Widget yourWidget(BuildContext context, FeedFrontModel? value) {
    var modalRoute = ModalRoute.of(context) as ModalRoute;
    var feedId = value!.feed!.documentID;
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
      if (accessState is AccessDetermined) {
        return BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc()
              ..add(
                  InitialiseProfileEvent(app, feedId, accessState, modalRoute)),
            child: FeedFront(app, value));
      } else {
        return progressIndicator(app, context);
      }
    });
  }
}
