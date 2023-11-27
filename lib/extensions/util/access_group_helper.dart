import 'package:eliud_pkg_feed_model/model/post_model.dart';

class AccessGroupHelper {
  static String nameForPostAccessibleByGroup(
      PostAccessibleByGroup? postAccessibleByGroup) {
    switch (postAccessibleByGroup) {
      case PostAccessibleByGroup.public:
        return 'Public';
      case PostAccessibleByGroup.followers:
        return 'Followers';
      case PostAccessibleByGroup.me:
        return 'Just me';
      case PostAccessibleByGroup.specificMembers:
        return 'Specific members';
      case PostAccessibleByGroup.unknown:
        break;
      case null:
        break;
    }
    return '?';
  }
}
