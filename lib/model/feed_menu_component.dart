/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_feed/model/feed_menu_component_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component_event.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_menu_repository.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_model.dart';

abstract class AbstractFeedMenuComponent extends StatelessWidget {
  static String componentName = "feedMenus";
  final AppModel app;
  final String feedMenuId;

  AbstractFeedMenuComponent({Key? key, required this.app, required this.feedMenuId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedMenuComponentBloc> (
          create: (context) => FeedMenuComponentBloc(
            feedMenuRepository: feedMenuRepository(appId: app.documentID)!)
        ..add(FetchFeedMenuComponent(id: feedMenuId)),
      child: _feedMenuBlockBuilder(context),
    );
  }

  Widget _feedMenuBlockBuilder(BuildContext context) {
    return BlocBuilder<FeedMenuComponentBloc, FeedMenuComponentState>(builder: (context, state) {
      if (state is FeedMenuComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(app: app, title: "Error", content: 'No FeedMenu defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is FeedMenuComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is FeedMenuComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().progressIndicatorStyle().progressIndicator(app, context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, FeedMenuModel value);
}

