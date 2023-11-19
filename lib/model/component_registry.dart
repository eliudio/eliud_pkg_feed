/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/component_registry.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import '../model/internal_component.dart';
import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core_model/tools/component/component_spec.dart';
import 'abstract_repository_singleton.dart';

import '../extensions/feed_front_component.dart';
import '../editors/feed_front_component_editor.dart';
import 'feed_front_component_selector.dart';
import '../extensions/feed_menu_component.dart';
import '../editors/feed_menu_component_editor.dart';
import 'feed_menu_component_selector.dart';
import '../extensions/profile_component.dart';
import '../editors/profile_component_editor.dart';
import 'profile_component_selector.dart';

/* 
 * Component registry contains a list of components
 */
class ComponentRegistry {
  /* 
   * Initialise the component registry
   */
  void init() {
    Apis.apis().addInternalComponents('eliud_pkg_feed', [
      "feeds",
      "feedFronts",
      "feedMenus",
      "posts",
      "postComments",
      "postLikes",
      "profiles",
    ]);

    Apis.apis().register(
        componentName: "eliud_pkg_feed_internalWidgets",
        componentConstructor: ListComponentFactory());
    Apis.apis()
        .addDropDownSupporter("feedFronts", DropdownButtonComponentFactory());
    Apis.apis().register(
        componentName: "feedFronts",
        componentConstructor: FeedFrontComponentConstructorDefault());
    Apis.apis()
        .addDropDownSupporter("feedMenus", DropdownButtonComponentFactory());
    Apis.apis().register(
        componentName: "feedMenus",
        componentConstructor: FeedMenuComponentConstructorDefault());
    Apis.apis()
        .addDropDownSupporter("profiles", DropdownButtonComponentFactory());
    Apis.apis().register(
        componentName: "profiles",
        componentConstructor: ProfileComponentConstructorDefault());
    Apis.apis().addComponentSpec('eliud_pkg_feed', 'feed', [
      ComponentSpec(
          'feedFronts',
          FeedFrontComponentConstructorDefault(),
          FeedFrontComponentSelector(),
          FeedFrontComponentEditorConstructor(),
          ({String? appId}) => feedFrontRepository(appId: appId)!),
      ComponentSpec(
          'feedMenus',
          FeedMenuComponentConstructorDefault(),
          FeedMenuComponentSelector(),
          FeedMenuComponentEditorConstructor(),
          ({String? appId}) => feedMenuRepository(appId: appId)!),
      ComponentSpec(
          'profiles',
          ProfileComponentConstructorDefault(),
          ProfileComponentSelector(),
          ProfileComponentEditorConstructor(),
          ({String? appId}) => profileRepository(appId: appId)!),
    ]);
    Apis.apis().registerRetrieveRepository('eliud_pkg_feed', 'feeds',
        ({String? appId}) => feedRepository(appId: appId)!);
    Apis.apis().registerRetrieveRepository('eliud_pkg_feed',
        'feedFronts', ({String? appId}) => feedFrontRepository(appId: appId)!);
    Apis.apis().registerRetrieveRepository('eliud_pkg_feed',
        'feedMenus', ({String? appId}) => feedMenuRepository(appId: appId)!);
    Apis.apis().registerRetrieveRepository(
        'eliud_pkg_feed',
        'memberProfiles',
        ({String? appId}) => memberProfileRepository(appId: appId)!);
    Apis.apis().registerRetrieveRepository('eliud_pkg_feed', 'posts',
        ({String? appId}) => postRepository(appId: appId)!);
    Apis.apis().registerRetrieveRepository(
        'eliud_pkg_feed',
        'postComments',
        ({String? appId}) => postCommentRepository(appId: appId)!);
    Apis.apis().registerRetrieveRepository('eliud_pkg_feed',
        'postLikes', ({String? appId}) => postLikeRepository(appId: appId)!);
    Apis.apis().registerRetrieveRepository('eliud_pkg_feed',
        'profiles', ({String? appId}) => profileRepository(appId: appId)!);
  }
}
