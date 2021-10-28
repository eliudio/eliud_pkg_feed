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

import '../extensions/feed_component.dart';
import '../editors/feed_component_editor.dart';
import 'feed_component_selector.dart';
import '../extensions/feed_menu_component.dart';
import '../editors/feed_menu_component_editor.dart';
import 'feed_menu_component_selector.dart';
import '../extensions/header_component.dart';
import '../editors/header_component_editor.dart';
import 'header_component_selector.dart';
import '../extensions/profile_component.dart';
import '../editors/profile_component_editor.dart';
import 'profile_component_selector.dart';
import 'package:eliud_pkg_feed/model/internal_component.dart';




class ComponentRegistry {

  void init() {
    Registry.registry()!.addInternalComponents('eliud_pkg_feed', ["feeds", "feedMenus", "headers", "posts", "postComments", "postLikes", "profiles", ]);

    Registry.registry()!.register(componentName: "eliud_pkg_feed_internalWidgets", componentConstructor: ListComponentFactory());
    Registry.registry()!.addDropDownSupporter("feeds", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "feeds", componentConstructor: FeedComponentConstructorDefault());
    Registry.registry()!.addDropDownSupporter("feedMenus", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "feedMenus", componentConstructor: FeedMenuComponentConstructorDefault());
    Registry.registry()!.addDropDownSupporter("headers", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "headers", componentConstructor: HeaderComponentConstructorDefault());
    Registry.registry()!.addDropDownSupporter("profiles", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "profiles", componentConstructor: ProfileComponentConstructorDefault());
    Registry.registry()!.addComponentSpec('eliud_pkg_feed', [
      ComponentSpec('feeds', FeedComponentConstructorDefault(), FeedComponentSelector(), FeedComponentEditorConstructor(), ), 
      ComponentSpec('feedMenus', FeedMenuComponentConstructorDefault(), FeedMenuComponentSelector(), FeedMenuComponentEditorConstructor(), ), 
      ComponentSpec('headers', HeaderComponentConstructorDefault(), HeaderComponentSelector(), HeaderComponentEditorConstructor(), ), 
      ComponentSpec('profiles', ProfileComponentConstructorDefault(), ProfileComponentSelector(), ProfileComponentEditorConstructor(), ), 
    ]);

  }
}


