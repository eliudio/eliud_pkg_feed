/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_front_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_feed/model/feed_front_component_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_front_component_event.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'package:eliud_pkg_feed/model/feed_front_repository.dart';
import 'package:eliud_pkg_feed/model/feed_front_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_model.dart';

abstract class AbstractFeedFrontComponent extends StatelessWidget {
  static String componentName = "feedFronts";
  final AppModel app;
  final String feedFrontId;

  AbstractFeedFrontComponent({Key? key, required this.app, required this.feedFrontId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedFrontComponentBloc> (
          create: (context) => FeedFrontComponentBloc(
            feedFrontRepository: feedFrontRepository(appId: app.documentID!)!)
        ..add(FetchFeedFrontComponent(id: feedFrontId)),
      child: _feedFrontBlockBuilder(context),
    );
  }

  Widget _feedFrontBlockBuilder(BuildContext context) {
    return BlocBuilder<FeedFrontComponentBloc, FeedFrontComponentState>(builder: (context, state) {
      if (state is FeedFrontComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(app: app, title: "Error", content: 'No FeedFront defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is FeedFrontComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is FeedFrontComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().progressIndicatorStyle().progressIndicator(app, context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, FeedFrontModel value);
}

