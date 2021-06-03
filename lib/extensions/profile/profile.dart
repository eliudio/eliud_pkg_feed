import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/profile_helper.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_text/extensions/rich_text_dialog.dart';

class Profile extends StatefulWidget {
  final String appId;
  final ProfileHelper profileHelper;
/*
switchFeedHelper: profileInformation.switchFeedHelper,
              appId: profileModel!.appId!,
              ownerId: profileInformation.switchFeedHelper.feedMember().documentID!,
              readAccess: profileInformation.readAccess, html: profileInformation.memberProfileModel.profile!, feedback: (String value) => profileInformation.updateProfile(value),);
 */

  Profile(
      {Key? key,
      required this.appId,
      required this.profileHelper})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();

  bool canUpdate() {
    return profileHelper.switchFeedHelper.memberOfFeed.documentID ==
        profileHelper.switchFeedHelper.memberCurrent.documentID;
  }

  String ownerId() {
    return profileHelper.switchFeedHelper.feedMember().documentID!;
  }

  RichTextFeedback feedbackFunction() => (String value) => profileHelper.updateProfile(value);

  String html() {
    return profileHelper.memberProfileModel.profile!;
  }

  List<String> readAccess() {
    return profileHelper.readAccess == null ? ['PUBLIC'] : profileHelper.readAccess!;
  }
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    if (widget.canUpdate()) {
      return Stack(
        children: [
          PostHelper.getFormattedPost([HtmlWidget(widget.html())]),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                update();
              },
            ),
          ),
        ],
      );
    } else {
      return PostHelper.getFormattedPost([HtmlWidget(widget.html())]);
    }
  }

  void update() {
    RichTextDialog.open(
        context,
        widget.appId,
        widget.ownerId(),
        widget.readAccess(),
        "Profile",
        widget.feedbackFunction(),
        widget.html());
  }
}
