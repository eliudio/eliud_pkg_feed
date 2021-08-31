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


import 'package:eliud_pkg_feed/model/album_list_bloc.dart';
import 'package:eliud_pkg_feed/model/album_list.dart';
import 'package:eliud_pkg_feed/model/album_dropdown_button.dart';
import 'package:eliud_pkg_feed/model/album_list_event.dart';

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

import 'package:eliud_pkg_feed/model/header_list_bloc.dart';
import 'package:eliud_pkg_feed/model/header_list.dart';
import 'package:eliud_pkg_feed/model/header_dropdown_button.dart';
import 'package:eliud_pkg_feed/model/header_list_event.dart';

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

class ListComponentFactory implements ComponentConstructor {
  Widget? createNew({Key? key, required String id, Map<String, dynamic>? parameters}) {
    return ListComponent(componentId: id);
  }
}


typedef DropdownButtonChanged(String? value);

class DropdownButtonComponentFactory implements ComponentDropDown {

  bool supports(String id) {

    if (id == "albums") return true;
    if (id == "feeds") return true;
    if (id == "feedMenus") return true;
    if (id == "headers") return true;
    if (id == "posts") return true;
    if (id == "postComments") return true;
    if (id == "postLikes") return true;
    if (id == "profiles") return true;
    return false;
  }

  Widget createNew({Key? key, required String id, Map<String, dynamic>? parameters, String? value, DropdownButtonChanged? trigger, bool? optional}) {

    if (id == "albums")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "feeds")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "feedMenus")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "headers")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "posts")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "postComments")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "postLikes")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "profiles")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    return Text("Id $id not found");
  }
}


class ListComponent extends StatelessWidget with HasFab {
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

  ListComponent({this.componentId}) {
    initWidget();
  }

  @override
  Widget build(BuildContext context) {

    if (componentId == 'albums') return _albumBuild(context);
    if (componentId == 'feeds') return _feedBuild(context);
    if (componentId == 'feedMenus') return _feedMenuBuild(context);
    if (componentId == 'headers') return _headerBuild(context);
    if (componentId == 'posts') return _postBuild(context);
    if (componentId == 'postComments') return _postCommentBuild(context);
    if (componentId == 'postLikes') return _postLikeBuild(context);
    if (componentId == 'profiles') return _profileBuild(context);
    return Text('Component with componentId == $componentId not found');
  }

  void initWidget() {
    if (componentId == 'albums') widget = AlbumListWidget();
    if (componentId == 'feeds') widget = FeedListWidget();
    if (componentId == 'feedMenus') widget = FeedMenuListWidget();
    if (componentId == 'headers') widget = HeaderListWidget();
    if (componentId == 'posts') widget = PostListWidget();
    if (componentId == 'postComments') widget = PostCommentListWidget();
    if (componentId == 'postLikes') widget = PostLikeListWidget();
    if (componentId == 'profiles') widget = ProfileListWidget();
  }

  Widget _albumBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumListBloc>(
          create: (context) => AlbumListBloc(
            albumRepository: albumRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadAlbumList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _feedBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedListBloc>(
          create: (context) => FeedListBloc(
            feedRepository: feedRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadFeedList()),
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
            feedMenuRepository: feedMenuRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadFeedMenuList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _headerBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HeaderListBloc>(
          create: (context) => HeaderListBloc(
            headerRepository: headerRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadHeaderList()),
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
            postRepository: postRepository(appId: AccessBloc.appId(context))!,
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
            postCommentRepository: postCommentRepository(appId: AccessBloc.appId(context))!,
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
            postLikeRepository: postLikeRepository(appId: AccessBloc.appId(context))!,
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
            profileRepository: profileRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadProfileList()),
        )
      ],
      child: widget!,
    );
  }

}


typedef Changed(String? value);

class DropdownButtonComponent extends StatelessWidget {
  final String? componentId;
  final String? value;
  final Changed? trigger;
  final bool? optional;

  DropdownButtonComponent({this.componentId, this.value, this.trigger, this.optional});

  @override
  Widget build(BuildContext context) {

    if (componentId == 'albums') return _albumBuild(context);
    if (componentId == 'feeds') return _feedBuild(context);
    if (componentId == 'feedMenus') return _feedMenuBuild(context);
    if (componentId == 'headers') return _headerBuild(context);
    if (componentId == 'posts') return _postBuild(context);
    if (componentId == 'postComments') return _postCommentBuild(context);
    if (componentId == 'postLikes') return _postLikeBuild(context);
    if (componentId == 'profiles') return _profileBuild(context);
    return Text('Component with componentId == $componentId not found');
  }


  Widget _albumBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumListBloc>(
          create: (context) => AlbumListBloc(
            albumRepository: albumRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadAlbumList()),
        )
      ],
      child: AlbumDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _feedBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedListBloc>(
          create: (context) => FeedListBloc(
            feedRepository: feedRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadFeedList()),
        )
      ],
      child: FeedDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _feedMenuBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedMenuListBloc>(
          create: (context) => FeedMenuListBloc(
            feedMenuRepository: feedMenuRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadFeedMenuList()),
        )
      ],
      child: FeedMenuDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _headerBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HeaderListBloc>(
          create: (context) => HeaderListBloc(
            headerRepository: headerRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadHeaderList()),
        )
      ],
      child: HeaderDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _postBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostListBloc>(
          create: (context) => PostListBloc(
            postRepository: postRepository(appId: AccessBloc.appId(context))!,
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
            postCommentRepository: postCommentRepository(appId: AccessBloc.appId(context))!,
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
            postLikeRepository: postLikeRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadPostLikeList()),
        )
      ],
      child: PostLikeDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _profileBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileListBloc>(
          create: (context) => ProfileListBloc(
            profileRepository: profileRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadProfileList()),
        )
      ],
      child: ProfileDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

}


