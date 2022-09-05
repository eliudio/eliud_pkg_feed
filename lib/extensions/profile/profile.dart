import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/member_medium_container_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/util/editable_widget.dart';
import 'package:eliud_pkg_text/platform/text_platform.dart';
import 'package:eliud_pkg_text/platform/widgets/html_text_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import '../../model/member_profile_model.dart';

class Profile extends StatefulWidget {
  final AppModel app;
  final BackgroundModel? backgroundOverride;

  Profile({Key? key, required this.app, required this.backgroundOverride})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileError) return text(widget.app, context, 'No profile');
      if (state is ProfileInitialised) {
        var profile = state.watchingThisProfile();
        var html = state.profileHTML();
        var child = topicContainer(widget.app, context,
            backgroundOverride: widget.backgroundOverride,
            children: ([
              html == null || html.length == 0
                  ? Container(
                      width: double.infinity,
                      height: 50,
                      child: Text("No profile"),
                    )
                  : AbstractTextPlatform.platform!
                      .htmlWidget(context, widget.app, html)
            ]));
        if (state is LoggedInProfileInitialized) {
          var ownerId = profile!.authorId!;
          if (state.canEditThisProfile()) {
            var memberProfile = state.watchingThisProfile()!;
            var accessibleByGroup = memberProfile.accessibleByGroup;
            var accessibleByMembers = memberProfile.accessibleByMembers;
            return EditableWidget(
                child: child,
                button: getEditIcon(
                  onPressed: () {
                    List<MemberMediumContainerModel> memberMedia =
                        memberProfile.memberMedia ?? [];
                    AbstractTextPlatform.platform!
                        .updateHtmlWithMemberMediumCallback(
                            context,
                            widget.app,
                            ownerId,
                            (value) => BlocProvider.of<ProfileBloc>(context)
                                .add(ProfileChangedProfileEvent(
                                    value, memberMedia)),
                            (AddMediaHtml addMediaHtml, String html) async {
                      // the PostWithMemberMediumComponents uses (unfortunately) a PostModel, so we create one, just to be able to function, and to capturethe postMediumModels
                      var tempModel = MemberProfileModel(
                          documentID: newRandomKey(),
                          appId: widget.app.documentID,
                          profile: html,
                          memberMedia: memberMedia,
                          accessibleByGroup: memberProfile.accessibleByGroup,
                          accessibleByMembers: memberProfile.accessibleByMembers,
                      );
/*
                          await ProfileWithMemberMediumComponents.openIt(
                              widget.app, context, tempModel, (accepted, model) {
                            if (accepted) {
                              memberMedia = model.htmlMedia;
                            }
                          }, addMediaHtml: addMediaHtml);
*/
                    }, "Profile", html,
                            accessibleByMembers: accessibleByMembers);
                  },
                ));
          } else {
            return child;
          }
        } else {
          return child;
        }
      }
      return progressIndicator(widget.app, context);
    });
  }
}
