import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_event.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_state.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';

typedef void PostPrivilegeChanged(PostPrivilege postPrivilege);

class PostPrivilegeBloc extends Bloc<PostPrivilegeEvent, PostPrivilegeState> {
  final String appId;
  final PostPrivilegeChanged postPrivilegeCallback;
  final String memberId;

  PostPrivilegeBloc(PostPrivilege postPrivilege, this.appId, this.memberId, this.postPrivilegeCallback) : super(PostPrivilegeInitialized(postPrivilege: postPrivilege));

  @override
  Stream<PostPrivilegeState> mapEventToState(PostPrivilegeEvent event) async* {
    if (event is ChangedPostPrivilege) {
      var postPrivilegeType = toPostPrivilegeType(event.value);
      var postPrivilege = await PostPrivilege.construct1(postPrivilegeType, appId, memberId, specificFollowers: event.specificFollowers);
      postPrivilegeCallback(postPrivilege);
      yield PostPrivilegeInitialized(postPrivilege: postPrivilege);
    }
  }
}
