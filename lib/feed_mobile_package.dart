import 'package:eliud_pkg_feed/platform/medium_platform.dart';
import 'package:eliud_pkg_feed/platform/mobile_medium_platform.dart';

import 'feed_package.dart';

class FeedMobilePackage extends FeedPackage {
  @override
  void init() {
    super.init();
    // initialise the platform
    AbstractMediumPlatform.platform = MobileMediumPlatform();
  }
}
