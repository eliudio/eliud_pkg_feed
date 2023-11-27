import 'package:eliud_core_helpers/query/query_tools.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_pkg_feed_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed_model/model/member_profile_model.dart';
import 'package:eliud_pkg_feed_model/model/post_model.dart';

/// MemberService
class MemberService {
  final AppModel app;
  final String feedId;
  final String memberId;

  MemberService(this.app, this.feedId, this.memberId);

  Future<List<SelectedMember>?> getFromPostPrivilege(
      PostAccessibleByGroup postAccessibleByGroup,
      List<String>? postAccessibleByMembers) async {
    if (postAccessibleByGroup == PostAccessibleByGroup.specificMembers) {
      return getFromIDs(postAccessibleByMembers);
    } else {
      return Future.value(null);
    }
  }

  Future<List<SelectedMember>?> getFromIDs(List<String>? ids) async {
    if (ids == null) return Future.value(null);

    var values2 = <SelectedMember>[];
    for (var id in ids) {
      var value = await memberProfileRepository(appId: app.documentID)!
          .get('$id-$feedId');
      var selectedMember = SelectedMember(
          memberId: value!.authorId != null ? value.authorId! : 'no author id',
          name: value.nameOverride != null ? value.nameOverride! : 'no name',
          imageURL: value.profile);
      values2.add(selectedMember);
    }

    return values2;
  }

  Future<List<SelectedMember>> getMembers(String? query) async {
    var membersValues = await memberProfileRepository(appId: app.documentID)!
        .valuesList(
            eliudQuery: EliudQuery()
                .withCondition(EliudQueryCondition('feedId', isEqualTo: feedId))
                .withCondition(EliudQueryCondition('readAccess',
                    arrayContainsAny: [memberId, 'PUBLIC'])));

    if ((query != null) && (query.isNotEmpty)) {
      var values2 = <SelectedMember>[];
      var lowerQuery = query.toLowerCase();
      for (var value in membersValues) {
        if (value!.nameOverride != null) {
          if (value.nameOverride!.toLowerCase().contains(lowerQuery)) {
            var selectedMember = SelectedMember(
                memberId:
                    value.authorId != null ? value.authorId! : 'no author id',
                name: value.nameOverride != null
                    ? value.nameOverride!
                    : 'no name');
            values2.add(selectedMember);
          }
        }
      }
      return values2;
    } else {
      return mapAll(membersValues);
    }
  }

  List<SelectedMember> mapAll(List<MemberProfileModel?> membersValues) {
    var values2 = <SelectedMember>[];
    for (var value in membersValues) {
      var selectedMember = SelectedMember(
          memberId: value!.authorId != null ? value.authorId! : 'no author id',
          name: value.nameOverride != null ? value.nameOverride! : 'no name');
      values2.add(selectedMember);
    }
    return values2;
  }
}

class SelectedMember /*extends Taggable */ {
  final String memberId;
  final String name;
  final String? imageURL;

  SelectedMember({required this.memberId, required this.name, this.imageURL});

  List<Object> get props => [memberId, name, imageURL ?? ''];
}
