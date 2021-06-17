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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'package:eliud_pkg_feed/model/post_like_component_bloc.dart';
import 'package:eliud_pkg_feed/model/post_like_component_event.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_like_repository.dart';
import 'package:eliud_pkg_feed/model/post_like_component_state.dart';

abstract class AbstractPostLikeComponent extends StatelessWidget {
  static String componentName = "postLikes";
  final String? postLikeID;

  AbstractPostLikeComponent({this.postLikeID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostLikeComponentBloc> (
          create: (context) => PostLikeComponentBloc(
            postLikeRepository: getPostLikeRepository(context))
        ..add(FetchPostLikeComponent(id: postLikeID)),
      child: _postLikeBlockBuilder(context),
    );
  }

  Widget _postLikeBlockBuilder(BuildContext context) {
    return BlocBuilder<PostLikeComponentBloc, PostLikeComponentState>(builder: (context, state) {
      if (state is PostLikeComponentLoaded) {
        if (state.value == null) {
          return alertWidget(title: 'Error', content: 'No PostLike defined');
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
        return alertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, PostLikeModel? value);
  Widget alertWidget({ title: String, content: String});
  PostLikeRepository getPostLikeRepository(BuildContext context);
}

