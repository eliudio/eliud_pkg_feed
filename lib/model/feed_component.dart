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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eliud_pkg_feed/model/feed_component_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_component_event.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';
import 'package:eliud_pkg_feed/model/feed_component_state.dart';

abstract class AbstractFeedComponent extends StatelessWidget {
  static String componentName = "feeds";
  final String feedID;

  AbstractFeedComponent({this.feedID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedComponentBloc> (
          create: (context) => FeedComponentBloc(
            feedRepository: getFeedRepository(context))
        ..add(FetchFeedComponent(id: feedID)),
      child: _feedBlockBuilder(context),
    );
  }

  Widget _feedBlockBuilder(BuildContext context) {
    return BlocBuilder<FeedComponentBloc, FeedComponentState>(builder: (context, state) {
      if (state is FeedComponentLoaded) {
        if (state.value == null) {
          return alertWidget(title: 'Error', content: 'No feed defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is FeedComponentError) {
        return alertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, FeedModel value);
  Widget alertWidget({ title: String, content: String});
  FeedRepository getFeedRepository(BuildContext context);
}
