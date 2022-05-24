import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_privilege/bloc/member_service.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_privilege/bloc/post_privilege_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_privilege/bloc/post_privilege_event.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_privilege/post_privilege_widget.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef PostPrivilegeFeedback(PostAccessibleByGroup postAccessibleByGroup,
    List<String>? postAccessibleByMembers);

class PostPrivilegeDialog {
  static void openIt(
    AppModel app,
    BuildContext context,
    String title,
    String feedId,
    String memberId,
    String currentMemberId,
    PostAccessibleByGroup initialPostAccessibleByGroup,
    List<String>? initialPostAccessibleByMembers,
    PostPrivilegeFeedback feedback,
  ) {
    PostAccessibleByGroup currentPostAccessibleByGroup =
        initialPostAccessibleByGroup;
    List<String>? currentPostAccessibleByMembers =
        initialPostAccessibleByMembers;

    openFlexibleDialog(app, context, app.documentID + '/chat',
        title: 'Select visibility of your next post',
        child: BlocProvider<PostPrivilegeBloc>(
            create: (context) => PostPrivilegeBloc(app, feedId, memberId,
                    (PostAccessibleByGroup postAccessibleByGroup,
                        List<SelectedMember>? specificSelectedMembers) {
                  currentPostAccessibleByGroup = postAccessibleByGroup;
                  currentPostAccessibleByMembers = (specificSelectedMembers !=
                          null)
                      ? specificSelectedMembers.map((e) => e.memberId).toList()
                      : null;
                })
                  ..add(InitialisePostPrivilegeEvent(
                      postAccessibleByGroup: currentPostAccessibleByGroup,
                      postAccessibleByMembers: currentPostAccessibleByMembers)),
            child: PostPrivilegeWidget(
                app, feedId, memberId, currentMemberId, true)),
        buttons: [
          dialogButton(app, context,
              label: 'Cancel', onPressed: () => Navigator.of(context).pop()),
          dialogButton(app, context, label: 'Select', onPressed: () {
            feedback(
                currentPostAccessibleByGroup, currentPostAccessibleByMembers);
            Navigator.of(context).pop();
          }),
        ]);
  }
}
