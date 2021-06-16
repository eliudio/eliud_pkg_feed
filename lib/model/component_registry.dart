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

import '../extensions/album_component.dart';
import '../extensions/feed_component.dart';
import '../extensions/feed_menu_component.dart';
import '../extensions/header_component.dart';
import '../extensions/profile_component.dart';
import 'package:eliud_pkg_feed/model/internal_component.dart';




class ComponentRegistry {

  void init() {
    Registry.registry()!.addInternalComponents('eliud_pkg_feed', ["albums", "feeds", "feedMenus", "headers", "posts", "postComments", "postLikes", "profiles", ]);

    Registry.registry()!.register(componentName: "eliud_pkg_feed_internalWidgets", componentConstructor: ListComponentFactory());
    Registry.registry()!.addDropDownSupporter("albums", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "albums", componentConstructor: AlbumComponentConstructorDefault());
    Registry.registry()!.addDropDownSupporter("feeds", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "feeds", componentConstructor: FeedComponentConstructorDefault());
    Registry.registry()!.addDropDownSupporter("feedMenus", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "feedMenus", componentConstructor: FeedMenuComponentConstructorDefault());
    Registry.registry()!.addDropDownSupporter("headers", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "headers", componentConstructor: HeaderComponentConstructorDefault());
    Registry.registry()!.addDropDownSupporter("profiles", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "profiles", componentConstructor: ProfileComponentConstructorDefault());

  }
}


