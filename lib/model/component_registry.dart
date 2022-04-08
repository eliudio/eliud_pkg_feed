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
import 'package:eliud_core/tools/component/component_spec.dart';

import '../extensions/profile_component.dart';
import '../editors/profile_component_editor.dart';
import 'profile_component_selector.dart';
import '../extensions/feed_menu_component.dart';
import '../editors/feed_menu_component_editor.dart';
import 'feed_menu_component_selector.dart';
import '../extensions/feed_front_component.dart';
import '../editors/feed_front_component_editor.dart';
import 'feed_front_component_selector.dart';
import 'package:eliud_pkg_feed/model/internal_component.dart';




class ComponentRegistry {

  void init() {
    Registry.registry()!.addInternalComponents('eliud_pkg_feed', ["feeds", "posts", "postComments", "postLikes", "profiles", "feedMenus", "feedFronts", ]);

    Registry.registry()!.register(componentName: "eliud_pkg_feed_internalWidgets", componentConstructor: ListComponentFactory());
    Registry.registry()!.addDropDownSupporter("profiles", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "profiles", componentConstructor: ProfileComponentConstructorDefault());
    Registry.registry()!.addDropDownSupporter("feedMenus", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "feedMenus", componentConstructor: FeedMenuComponentConstructorDefault());
    Registry.registry()!.addDropDownSupporter("feedFronts", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "feedFronts", componentConstructor: FeedFrontComponentConstructorDefault());
    Registry.registry()!.addComponentSpec('eliud_pkg_feed', [
      ComponentSpec('profiles', ProfileComponentConstructorDefault(), ProfileComponentSelector(), ProfileComponentEditorConstructor(), ), 
      ComponentSpec('feedMenus', FeedMenuComponentConstructorDefault(), FeedMenuComponentSelector(), FeedMenuComponentEditorConstructor(), ), 
      ComponentSpec('feedFronts', FeedFrontComponentConstructorDefault(), FeedFrontComponentSelector(), FeedFrontComponentEditorConstructor(), ), 
    ]);

  }
}


