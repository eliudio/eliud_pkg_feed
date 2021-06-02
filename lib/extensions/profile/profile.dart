import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_text/extensions/rich_text_dialog.dart';
import 'package:eliud_pkg_text/extensions/rich_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final SwitchFeedHelper switchFeedHelper;
  final String appId;
  final String ownerId;
  final List<String>? readAccess;
  final String html;
  final RichTextFeedback feedback;

  Profile(
      {Key? key,
      required this.switchFeedHelper,
      required this.appId,
      required this.ownerId,
      required this.readAccess, required this.html, required this.feedback})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    // Change this and make the profile available as a widget and allow to edit it if it belongs to the current member
    rows.add(FlatButton(
        child: Text("Update profile"),
        onPressed: () {
          RichTextDialog.open(
              context,
              widget.appId,
              widget.ownerId,
              widget.readAccess == null ? ['PUBLIC'] : widget.readAccess!,
              "Profile", widget.feedback,
              "widget.html");
        }));
    rows.add(FlatButton(
        child: Text("View profile"),
        onPressed: () {
          RichTextView.open(
              context,
              widget.html
          );
        }));
    return Column(children: rows);
  }
}
