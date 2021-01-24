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
import 'package:eliud_core/tools/registry.dart';

import '../extensions/feed_component.dart';
import 'package:eliud_pkg_feed/model/internal_component.dart';




class ComponentRegistry {

  void init() {
    Registry.registry().addInternalComponents('eliud_pkg_feed', ["feeds", "posts", "postComments", "postLikes", ]);

    Registry.registry().register(componentName: "eliud_pkg_feed_internalWidgets", componentConstructor: ListComponentFactory());
    Registry.registry().addDropDownSupporter("feeds", DropdownButtonComponentFactory());
    Registry.registry().register(componentName: "feeds", componentConstructor: FeedComponentConstructorDefault());

  }
}


