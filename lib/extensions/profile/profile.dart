import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_event.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/util/editable_widget.dart';
import 'package:eliud_pkg_text/platform/text_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class Profile extends StatefulWidget {
  final String appId;

  Profile({Key? key, required this.appId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileError)
        return text(context, 'No profile');
      if (state is ProfileInitialised) {
        var profile = state.watchingThisProfile();
        var html = state.profileHTML();
        var child = topicContainer(context,
            children: ([
              html == null || html.length == 0
                  ? Container(
                  width: double.infinity,
                  height: 50,
                  child: Text("No profile"))
                  : AbstractTextPlatform.platform!.htmlWidget(html)
            ]));
        if (state  is LoggedInProfileInitialized) {
          var ownerId = profile!.authorId!;
          if (state.canEditThisProfile()) {
            var readAccess = state.watchingThisProfile()!.readAccess!;
            return EditableWidget(
                child: child,
                button: getEditIcon(
                  onPressed: () {
                    AbstractTextPlatform.platform!.updateHtmlUsingMemberMedium(context,
                        widget.appId,
                        ownerId,
                        readAccess,
                        "Profile",
                            (value) =>
                            BlocProvider.of<ProfileBloc>(context)
                                .add(ProfileChangedProfileEvent(value)),
                        html);
                  },
                )
            );
          } else {
            return child;
          }
        } else {
          return child;
        }
      }
      return progressIndicator(context);
    });
  }
}
