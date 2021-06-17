import 'package:eliud_core/core/widgets/progress_indicator.dart';
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
      if (state is ProfileError) return Text("No profile");
      if (state is ProfileInitialised) {
        return EditableWidget(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().topicContainer(context, children:([HtmlWidget(state.html())])),
            button: getEditIcon(onPressed: () {
              RichTextDialog.open(
                  context,
                  widget.appId,
                  state.ownerId(),
                  state.readAccess(),
                  "Profile",
                      (value) => BlocProvider.of<ProfileBloc>(context)
                      .add(ProfileChangedProfileEvent(value)),
                  state.html());
            },)
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
      return Center(child: DelayedCircularProgressIndicator());
    });
  }
}
