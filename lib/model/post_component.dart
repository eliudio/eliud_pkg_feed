/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_feed/model/post_component_bloc.dart';
import 'package:eliud_pkg_feed/model/post_component_event.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/model/post_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/model/app_model.dart';

abstract class AbstractPostComponent extends StatelessWidget {
  static String componentName = "posts";
  final AppModel app;
  final String postId;

  AbstractPostComponent({Key? key, required this.app, required this.postId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostComponentBloc> (
          create: (context) => PostComponentBloc(
            postRepository: postRepository(appId: app.documentID)!)
        ..add(FetchPostComponent(id: postId)),
      child: _postBlockBuilder(context),
    );
  }

  Widget _postBlockBuilder(BuildContext context) {
    return BlocBuilder<PostComponentBloc, PostComponentState>(builder: (context, state) {
      if (state is PostComponentLoaded) {
        return yourWidget(context, state.value);
      } else if (state is PostComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is PostComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().progressIndicatorStyle().progressIndicator(app, context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, PostModel value);
}

