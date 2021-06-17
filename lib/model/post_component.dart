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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'package:eliud_pkg_feed/model/post_component_bloc.dart';
import 'package:eliud_pkg_feed/model/post_component_event.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/model/post_repository.dart';
import 'package:eliud_pkg_feed/model/post_component_state.dart';

abstract class AbstractPostComponent extends StatelessWidget {
  static String componentName = "posts";
  final String? postID;

  AbstractPostComponent({this.postID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostComponentBloc> (
          create: (context) => PostComponentBloc(
            postRepository: getPostRepository(context))
        ..add(FetchPostComponent(id: postID)),
      child: _postBlockBuilder(context),
    );
  }

  Widget _postBlockBuilder(BuildContext context) {
    return BlocBuilder<PostComponentBloc, PostComponentState>(builder: (context, state) {
      if (state is PostComponentLoaded) {
        if (state.value == null) {
          return alertWidget(title: 'Error', content: 'No Post defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is PostComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is PostComponentError) {
        return alertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, PostModel? value);
  Widget alertWidget({ title: String, content: String});
  PostRepository getPostRepository(BuildContext context);
}

