/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/internal_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eliud_core/tools/has_fab.dart';


import 'package:eliud_pkg_feed/model/feed_list_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_list.dart';
import 'package:eliud_pkg_feed/model/feed_dropdown_button.dart';
import 'package:eliud_pkg_feed/model/feed_list_event.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/post_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_list.dart';
import 'package:eliud_pkg_feed/model/post_dropdown_button.dart';
import 'package:eliud_pkg_feed/model/post_list_event.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/post_comment_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_comment_list.dart';
import 'package:eliud_pkg_feed/model/post_comment_dropdown_button.dart';
import 'package:eliud_pkg_feed/model/post_comment_list_event.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/post_like_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_like_list.dart';
import 'package:eliud_pkg_feed/model/post_like_dropdown_button.dart';
import 'package:eliud_pkg_feed/model/post_like_list_event.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

class ListComponentFactory implements ComponentConstructor {
  Widget createNew({String id, Map<String, Object> parameters}) {
    return ListComponent(componentId: id);
  }
}


typedef DropdownButtonChanged(String value);

class DropdownButtonComponentFactory implements ComponentDropDown {

  bool supports(String id) {

    if (id == "feeds") return true;
    if (id == "posts") return true;
    if (id == "postComments") return true;
    if (id == "postLikes") return true;
    return false;
  }

  Widget createNew({String id, Map<String, Object> parameters, String value, DropdownButtonChanged trigger, bool optional}) {

    if (id == "feeds")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "posts")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "postComments")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "postLikes")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    return null;
  }
}


class ListComponent extends StatelessWidget with HasFab {
  final String componentId;
  Widget widget;

  @override
  Widget fab(BuildContext context){
    if ((widget != null) && (widget is HasFab)) {
      HasFab hasFab = widget as HasFab;
      return hasFab.fab(context);
    }
    return null;
  }

  ListComponent({this.componentId}) {
    initWidget();
  }

  @override
  Widget build(BuildContext context) {

    if (componentId == 'feeds') return _feedBuild(context);
    if (componentId == 'posts') return _postBuild(context);
    if (componentId == 'postComments') return _postCommentBuild(context);
    if (componentId == 'postLikes') return _postLikeBuild(context);
    return Text('Component with componentId == $componentId not found');
  }

  Widget initWidget() {
    if (componentId == 'feeds') widget = FeedListWidget();
    if (componentId == 'posts') widget = PostListWidget();
    if (componentId == 'postComments') widget = PostCommentListWidget();
    if (componentId == 'postLikes') widget = PostLikeListWidget();
  }

  Widget _feedBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedListBloc>(
          create: (context) => FeedListBloc(
            feedRepository: feedRepository(appId: AccessBloc.appId(context)),
          )..add(LoadFeedList()),
        )
      ],
      child: widget,
    );
  }

  Widget _postBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostListBloc>(
          create: (context) => PostListBloc(
            postRepository: postRepository(appId: AccessBloc.appId(context)),
          )..add(LoadPostList()),
        )
      ],
      child: widget,
    );
  }

  Widget _postCommentBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCommentListBloc>(
          create: (context) => PostCommentListBloc(
            postCommentRepository: postCommentRepository(appId: AccessBloc.appId(context)),
          )..add(LoadPostCommentList()),
        )
      ],
      child: widget,
    );
  }

  Widget _postLikeBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostLikeListBloc>(
          create: (context) => PostLikeListBloc(
            postLikeRepository: postLikeRepository(appId: AccessBloc.appId(context)),
          )..add(LoadPostLikeList()),
        )
      ],
      child: widget,
    );
  }

}


typedef Changed(String value);

class DropdownButtonComponent extends StatelessWidget {
  final String componentId;
  final String value;
  final Changed trigger;
  final bool optional;

  DropdownButtonComponent({this.componentId, this.value, this.trigger, this.optional});

  @override
  Widget build(BuildContext context) {

    if (componentId == 'feeds') return _feedBuild(context);
    if (componentId == 'posts') return _postBuild(context);
    if (componentId == 'postComments') return _postCommentBuild(context);
    if (componentId == 'postLikes') return _postLikeBuild(context);
    return Text('Component with componentId == $componentId not found');
  }


  Widget _feedBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedListBloc>(
          create: (context) => FeedListBloc(
            feedRepository: feedRepository(appId: AccessBloc.appId(context)),
          )..add(LoadFeedList()),
        )
      ],
      child: FeedDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _postBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostListBloc>(
          create: (context) => PostListBloc(
            postRepository: postRepository(appId: AccessBloc.appId(context)),
          )..add(LoadPostList()),
        )
      ],
      child: PostDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _postCommentBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCommentListBloc>(
          create: (context) => PostCommentListBloc(
            postCommentRepository: postCommentRepository(appId: AccessBloc.appId(context)),
          )..add(LoadPostCommentList()),
        )
      ],
      child: PostCommentDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _postLikeBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostLikeListBloc>(
          create: (context) => PostLikeListBloc(
            postLikeRepository: postLikeRepository(appId: AccessBloc.appId(context)),
          )..add(LoadPostLikeList()),
        )
      ],
      child: PostLikeDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

}


