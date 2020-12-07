import 'feed_package.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_singleton.dart';

import 'model/component_registry.dart';

class FeedMobilePackage extends FeedPackage {
  @override
  void init() {
    AbstractRepositorySingleton.singleton = RepositorySingleton();
    super.init();
  }
}
