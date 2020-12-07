import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/js_repository_singleton.dart';

import 'feed_package.dart';

class FundamentalsWebPackage extends FeedPackage {
  @override
  void init() {
    AbstractRepositorySingleton.singleton = JsRepositorySingleton();
    super.init();
  }
}
