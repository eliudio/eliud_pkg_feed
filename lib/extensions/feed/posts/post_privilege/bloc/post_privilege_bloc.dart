import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_event.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_state.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';

import 'member_service.dart';

typedef void PostPrivilegeChanged(PostPrivilege postPrivilege);

class PostPrivilegeBloc extends Bloc<PostPrivilegeEvent, PostPrivilegeState> {
  final AppModel app;
  final String feedId;
  final String memberId;
  late MemberService memberService;

  final PostPrivilegeChanged postPrivilegeCallback;

  PostPrivilegeBloc(this.app, this.feedId, this.memberId, this.postPrivilegeCallback) : super(PostPrivilegeUninitialized()) {
    memberService = MemberService(app, feedId, memberId);
  }

  @override
  Stream<PostPrivilegeState> mapEventToState(PostPrivilegeEvent event) async* {
    if (event is InitialisePostPrivilegeEvent) {
      yield PostPrivilegeInitialized(
          postPrivilege: event.postPrivilege, specificSelectedMembers: await memberService.getFromPostPrivilege(event.postPrivilege));
    } else if (event is ChangedPostPrivilege) {
      var postPrivilegeType = toPostPrivilegeType(event.value);
      var postPrivilege = await PostPrivilege.construct1(
          postPrivilegeType, app, memberId,
          specificFollowers: event.specificFollowers);
      postPrivilegeCallback(postPrivilege);
      var currentState = state;
      var newState = PostPrivilegeInitialized(
          postPrivilege: postPrivilege, specificSelectedMembers: await memberService.getFromPostPrivilege(postPrivilege));
      var equalsState = currentState == newState;
      yield newState;
    }
  }
}
