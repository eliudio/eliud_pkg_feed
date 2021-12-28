/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_feed/model/post_comment_component_bloc.dart';
import 'package:eliud_pkg_feed/model/post_comment_component_event.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_comment_repository.dart';
import 'package:eliud_pkg_feed/model/post_comment_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_model.dart';

abstract class AbstractPostCommentComponent extends StatelessWidget {
  static String componentName = "postComments";
  final AppModel app;
  final String postCommentId;

  AbstractPostCommentComponent({Key? key, required this.app, required this.postCommentId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCommentComponentBloc> (
          create: (context) => PostCommentComponentBloc(
            postCommentRepository: postCommentRepository(appId: app.documentID!)!)
        ..add(FetchPostCommentComponent(id: postCommentId)),
      child: _postCommentBlockBuilder(context),
    );
  }

  Widget _postCommentBlockBuilder(BuildContext context) {
    return BlocBuilder<PostCommentComponentBloc, PostCommentComponentState>(builder: (context, state) {
      if (state is PostCommentComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(app: app, title: "Error", content: 'No PostComment defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is PostCommentComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is PostCommentComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().progressIndicatorStyle().progressIndicator(app, context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, PostCommentModel value);
}

