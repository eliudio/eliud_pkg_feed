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


import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
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

import 'package:eliud_pkg_feed/model/profile_list_bloc.dart';
import 'package:eliud_pkg_feed/model/profile_list.dart';
import 'package:eliud_pkg_feed/model/profile_dropdown_button.dart';
import 'package:eliud_pkg_feed/model/profile_list_event.dart';

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

import 'package:eliud_pkg_feed/model/feed_menu_list_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_menu_list.dart';
import 'package:eliud_pkg_feed/model/feed_menu_dropdown_button.dart';
import 'package:eliud_pkg_feed/model/feed_menu_list_event.dart';

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

import 'package:eliud_pkg_feed/model/feed_front_list_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_front_list.dart';
import 'package:eliud_pkg_feed/model/feed_front_dropdown_button.dart';
import 'package:eliud_pkg_feed/model/feed_front_list_event.dart';

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

class ListComponentFactory implements ComponentConstructor {
  Widget? createNew({Key? key, required AppModel app,  required String id, Map<String, dynamic>? parameters}) {
    return ListComponent(app: app, componentId: id);
  }

  @override
  dynamic getModel({required AppModel app, required String id}) {
    return null;
  }
}


typedef DropdownButtonChanged(String? value);

class DropdownButtonComponentFactory implements ComponentDropDown {
  @override
  dynamic getModel({required AppModel app, required String id}) {
    return null;
  }


  bool supports(String id) {

    if (id == "feeds") return true;
    if (id == "posts") return true;
    if (id == "postComments") return true;
    if (id == "postLikes") return true;
    if (id == "profiles") return true;
    if (id == "feedMenus") return true;
    if (id == "feedFronts") return true;
    return false;
  }

  Widget createNew({Key? key, required AppModel app, required String id, Map<String, dynamic>? parameters, String? value, DropdownButtonChanged? trigger, bool? optional}) {

    if (id == "feeds")
      return DropdownButtonComponent(app: app, componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "posts")
      return DropdownButtonComponent(app: app, componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "postComments")
      return DropdownButtonComponent(app: app, componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "postLikes")
      return DropdownButtonComponent(app: app, componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "profiles")
      return DropdownButtonComponent(app: app, componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "feedMenus")
      return DropdownButtonComponent(app: app, componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "feedFronts")
      return DropdownButtonComponent(app: app, componentId: id, value: value, trigger: trigger, optional: optional);

    return Text("Id $id not found");
  }
}


class ListComponent extends StatelessWidget with HasFab {
  final AppModel app;
  final String? componentId;
  Widget? widget;

  @override
  Widget? fab(BuildContext context){
    if ((widget != null) && (widget is HasFab)) {
      HasFab hasFab = widget as HasFab;
      return hasFab.fab(context);
    }
    return null;
  }

  ListComponent({required this.app, this.componentId}) {
    initWidget();
  }

  @override
  Widget build(BuildContext context) {

    if (componentId == 'feeds') return _feedBuild(context);
    if (componentId == 'posts') return _postBuild(context);
    if (componentId == 'postComments') return _postCommentBuild(context);
    if (componentId == 'postLikes') return _postLikeBuild(context);
    if (componentId == 'profiles') return _profileBuild(context);
    if (componentId == 'feedMenus') return _feedMenuBuild(context);
    if (componentId == 'feedFronts') return _feedFrontBuild(context);
    return Text('Component with componentId == $componentId not found');
  }

  void initWidget() {
    if (componentId == 'feeds') widget = FeedListWidget(app: app);
    if (componentId == 'posts') widget = PostListWidget(app: app);
    if (componentId == 'postComments') widget = PostCommentListWidget(app: app);
    if (componentId == 'postLikes') widget = PostLikeListWidget(app: app);
    if (componentId == 'profiles') widget = ProfileListWidget(app: app);
    if (componentId == 'feedMenus') widget = FeedMenuListWidget(app: app);
    if (componentId == 'feedFronts') widget = FeedFrontListWidget(app: app);
  }

  Widget _feedBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedListBloc>(
          create: (context) => FeedListBloc(
            feedRepository: feedRepository(appId: app.documentID!)!,
          )..add(LoadFeedList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _postBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostListBloc>(
          create: (context) => PostListBloc(
            postRepository: postRepository(appId: app.documentID!)!,
          )..add(LoadPostList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _postCommentBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCommentListBloc>(
          create: (context) => PostCommentListBloc(
            postCommentRepository: postCommentRepository(appId: app.documentID!)!,
          )..add(LoadPostCommentList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _postLikeBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostLikeListBloc>(
          create: (context) => PostLikeListBloc(
            postLikeRepository: postLikeRepository(appId: app.documentID!)!,
          )..add(LoadPostLikeList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _profileBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileListBloc>(
          create: (context) => ProfileListBloc(
            profileRepository: profileRepository(appId: app.documentID!)!,
          )..add(LoadProfileList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _feedMenuBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedMenuListBloc>(
          create: (context) => FeedMenuListBloc(
            feedMenuRepository: feedMenuRepository(appId: app.documentID!)!,
          )..add(LoadFeedMenuList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _feedFrontBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedFrontListBloc>(
          create: (context) => FeedFrontListBloc(
            feedFrontRepository: feedFrontRepository(appId: app.documentID!)!,
          )..add(LoadFeedFrontList()),
        )
      ],
      child: widget!,
    );
  }

}


typedef Changed(String? value);

class DropdownButtonComponent extends StatelessWidget {
  final AppModel app;
  final String? componentId;
  final String? value;
  final Changed? trigger;
  final bool? optional;

  DropdownButtonComponent({required this.app, this.componentId, this.value, this.trigger, this.optional});

  @override
  Widget build(BuildContext context) {

    if (componentId == 'feeds') return _feedBuild(context);
    if (componentId == 'posts') return _postBuild(context);
    if (componentId == 'postComments') return _postCommentBuild(context);
    if (componentId == 'postLikes') return _postLikeBuild(context);
    if (componentId == 'profiles') return _profileBuild(context);
    if (componentId == 'feedMenus') return _feedMenuBuild(context);
    if (componentId == 'feedFronts') return _feedFrontBuild(context);
    return Text('Component with componentId == $componentId not found');
  }


  Widget _feedBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedListBloc>(
          create: (context) => FeedListBloc(
            feedRepository: feedRepository(appId: app.documentID!)!,
          )..add(LoadFeedList()),
        )
      ],
      child: FeedDropdownButtonWidget(app: app, value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _postBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostListBloc>(
          create: (context) => PostListBloc(
            postRepository: postRepository(appId: app.documentID!)!,
          )..add(LoadPostList()),
        )
      ],
      child: PostDropdownButtonWidget(app: app, value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _postCommentBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCommentListBloc>(
          create: (context) => PostCommentListBloc(
            postCommentRepository: postCommentRepository(appId: app.documentID!)!,
          )..add(LoadPostCommentList()),
        )
      ],
      child: PostCommentDropdownButtonWidget(app: app, value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _postLikeBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostLikeListBloc>(
          create: (context) => PostLikeListBloc(
            postLikeRepository: postLikeRepository(appId: app.documentID!)!,
          )..add(LoadPostLikeList()),
        )
      ],
      child: PostLikeDropdownButtonWidget(app: app, value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _profileBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileListBloc>(
          create: (context) => ProfileListBloc(
            profileRepository: profileRepository(appId: app.documentID!)!,
          )..add(LoadProfileList()),
        )
      ],
      child: ProfileDropdownButtonWidget(app: app, value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _feedMenuBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedMenuListBloc>(
          create: (context) => FeedMenuListBloc(
            feedMenuRepository: feedMenuRepository(appId: app.documentID!)!,
          )..add(LoadFeedMenuList()),
        )
      ],
      child: FeedMenuDropdownButtonWidget(app: app, value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _feedFrontBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedFrontListBloc>(
          create: (context) => FeedFrontListBloc(
            feedFrontRepository: feedFrontRepository(appId: app.documentID!)!,
          )..add(LoadFeedFrontList()),
        )
      ],
      child: FeedFrontDropdownButtonWidget(app: app, value: value, trigger: trigger, optional: optional),
    );
  }

}


