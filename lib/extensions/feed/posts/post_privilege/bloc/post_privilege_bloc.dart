import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_event.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_state.dart';

import 'member_service.dart';

class PostPrivilegeBloc extends Bloc<PostPrivilegeEvent, PostPrivilegeState> {
  final AppModel app;
  final String feedId;
  final String memberId;
  late MemberService memberService;

  PostPrivilegeBloc(this.app, this.feedId, this.memberId) : super(PostPrivilegeUninitialized()) {
    memberService = MemberService(app, feedId, memberId);
  }

  @override
  Stream<PostPrivilegeState> mapEventToState(PostPrivilegeEvent event) async* {
    if (event is InitialisePostPrivilegeEvent) {
      var selectedMembers = await memberService.getFromPostPrivilege(event.postAccessibleByGroup, event.postAccessibleByMembers);
      yield PostPrivilegeInitialized(postAccessibleByGroup: event.postAccessibleByGroup, specificSelectedMembers: selectedMembers);
    } else if (event is ChangedPostPrivilege) {
      var selectedMembers = await memberService.getFromPostPrivilege(event.postAccessibleByGroup, event.postAccessibleByMembers);
      var newState = PostPrivilegeInitialized(postAccessibleByGroup: event.postAccessibleByGroup, specificSelectedMembers: selectedMembers);
      yield newState;
    }
  }
}
