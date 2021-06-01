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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';

import 'package:eliud_pkg_feed/model/feed_menu_component_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component_event.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_menu_repository.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component_state.dart';

abstract class AbstractFeedMenuComponent extends StatelessWidget {
  static String componentName = "feedMenus";
  final String? feedMenuID;

  AbstractFeedMenuComponent({this.feedMenuID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedMenuComponentBloc> (
          create: (context) => FeedMenuComponentBloc(
            feedMenuRepository: getFeedMenuRepository(context))
        ..add(FetchFeedMenuComponent(id: feedMenuID)),
      child: _feedMenuBlockBuilder(context),
    );
  }

  Widget _feedMenuBlockBuilder(BuildContext context) {
    return BlocBuilder<FeedMenuComponentBloc, FeedMenuComponentState>(builder: (context, state) {
      if (state is FeedMenuComponentLoaded) {
        if (state.value == null) {
          return alertWidget(title: 'Error', content: 'No FeedMenu defined');
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
        return alertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: DelayedCircularProgressIndicator(),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, FeedMenuModel? value);
  Widget alertWidget({ title: String, content: String});
  FeedMenuRepository getFeedMenuRepository(BuildContext context);
}

