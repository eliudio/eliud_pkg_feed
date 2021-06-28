import 'package:eliud_pkg_feed/platform/medium_platform.dart';
import 'package:eliud_pkg_feed/platform/web_medium_platform.dart';

import 'feed_package.dart';

class FeedWebPackage extends FeedPackage {
  @override
  void init() {
    super.init();
    // initialise the platform
    AbstractMediumPlatform.platform = WebMediumPlatform();
  }

  @override
  List<Object?> get props => [
  ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is FeedWebPackage &&
              runtimeType == other.runtimeType;
}
