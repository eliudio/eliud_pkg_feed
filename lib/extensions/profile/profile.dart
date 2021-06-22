import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_feed/extensions/util/editable_widget.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliud_pkg_text/extensions/rich_text_dialog.dart';
import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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
        return StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle()
            .text(context, 'No profile');
      if (state is ProfileInitialised) {
        String html = state.html();
        return EditableWidget(
            child: StyleRegistry.registry()
                .styleWithContext(context)
                .frontEndStyle()
                .containerStyle()
                .topicContainer(context,
                    children: ([
                      html == null || html.length == 0
                          ? Container(
                              width: double.infinity,
                              height: 50,
                              child: Text("No profile"))
                          : HtmlWidget(html)
                    ])),
            button: getEditIcon(
              onPressed: () {
                RichTextDialog.open(
                    context,
                    widget.appId,
                    state.ownerId(),
                    state.readAccess(),
                    "Profile",
                    (value) => BlocProvider.of<ProfileBloc>(context)
                        .add(ProfileChangedProfileEvent(value)),
                    state.html());
              },
            )
/*
          editFunction: state.allowedToUpdate()
              ? () {
                  RichTextDialog.open(
                      context,
                      widget.appId,
                      state.ownerId(),
                      state.readAccess(),
                      "Profile",
                      (value) => BlocProvider.of<ProfileBloc>(context)
                          .add(ProfileChangedProfileEvent(value)),
                      state.html());
                }
              : null,
*/
            );
      }
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .progressIndicatorStyle()
          .progressIndicator(context);
    });
  }
}
