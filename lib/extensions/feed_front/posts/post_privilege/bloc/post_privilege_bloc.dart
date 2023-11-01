import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_privilege/bloc/post_privilege_event.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_privilege/bloc/post_privilege_state.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';

import 'member_service.dart';

typedef PostPrivilegeFeedback(PostAccessibleByGroup postAccessibleByGroup, List<SelectedMember>? specificSelectedMembers);

class PostPrivilegeBloc extends Bloc<PostPrivilegeEvent, PostPrivilegeState> {
  final AppModel app;
  final String feedId;
  final String memberId;
  late MemberService memberService;
  final PostPrivilegeFeedback postPrivilegeFeedback;

  PostPrivilegeBloc(this.app, this.feedId, this.memberId, this.postPrivilegeFeedback) : super(PostPrivilegeUninitialized()) {
    memberService = MemberService(app, feedId, memberId);

    on <InitialisePostPrivilegeEvent> ((event, emit) async {
      var selectedMembers = await memberService.getFromPostPrivilege(event.postAccessibleByGroup, event.postAccessibleByMembers);
      postPrivilegeFeedback(event.postAccessibleByGroup, selectedMembers);
      emit (PostPrivilegeInitialized(postAccessibleByGroup: event.postAccessibleByGroup, specificSelectedMembers: selectedMembers));
    });

    on  <ChangedPostPrivilege> ((event, emit) async {
      var selectedMembers = await memberService.getFromPostPrivilege(event.postAccessibleByGroup, event.postAccessibleByMembers);
      postPrivilegeFeedback(event.postAccessibleByGroup, selectedMembers);
      var newState = PostPrivilegeInitialized(postAccessibleByGroup: event.postAccessibleByGroup, specificSelectedMembers: selectedMembers);
      emit (newState);
    });
  }
}
