/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_feed/model/post_like_component_bloc.dart';
import 'package:eliud_pkg_feed/model/post_like_component_event.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_like_repository.dart';
import 'package:eliud_pkg_feed/model/post_like_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_model.dart';

abstract class AbstractPostLikeComponent extends StatelessWidget {
  static String componentName = "postLikes";
  final AppModel app;
  final String postLikeId;

  AbstractPostLikeComponent({Key? key, required this.app, required this.postLikeId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostLikeComponentBloc> (
          create: (context) => PostLikeComponentBloc(
            postLikeRepository: postLikeRepository(appId: app.documentID!)!)
        ..add(FetchPostLikeComponent(id: postLikeId)),
      child: _postLikeBlockBuilder(context),
    );
  }

  Widget _postLikeBlockBuilder(BuildContext context) {
    return BlocBuilder<PostLikeComponentBloc, PostLikeComponentState>(builder: (context, state) {
      if (state is PostLikeComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(app: app, title: "Error", content: 'No PostLike defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is PostLikeComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is PostLikeComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().progressIndicatorStyle().progressIndicator(app, context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, PostLikeModel value);
}

