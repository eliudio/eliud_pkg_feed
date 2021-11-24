/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_feed/model/feed_component_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_component_event.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';
import 'package:eliud_pkg_feed/model/feed_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';

abstract class AbstractFeedComponent extends StatelessWidget {
  static String componentName = "feeds";
  final String theAppId;
  final String feedId;

  AbstractFeedComponent({Key? key, required this.theAppId, required this.feedId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedComponentBloc> (
          create: (context) => FeedComponentBloc(
            feedRepository: feedRepository(appId: theAppId)!)
        ..add(FetchFeedComponent(id: feedId)),
      child: _feedBlockBuilder(context),
    );
  }

  Widget _feedBlockBuilder(BuildContext context) {
    return BlocBuilder<FeedComponentBloc, FeedComponentState>(builder: (context, state) {
      if (state is FeedComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(title: "Error", content: 'No Feed defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is FeedComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is FeedComponentError) {
        return AlertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, FeedModel value);
}

