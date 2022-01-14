import 'package:eliud_pkg_feed/model/post_model.dart';

class AccessGroupHelper {
  static String nameForPostAccessibleByGroup(PostAccessibleByGroup? postAccessibleByGroup) {
    switch (postAccessibleByGroup) {
      case PostAccessibleByGroup.Public: return 'Public';
      case PostAccessibleByGroup.Followers: return 'Followers';
      case PostAccessibleByGroup.Me: return 'Just me';
      case PostAccessibleByGroup.SpecificMembers: return 'Specific members';
    }
    return '?';
  }
}
