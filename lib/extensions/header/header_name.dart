import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderName extends StatefulWidget {
  final SwitchFeedHelper switchFeedHelper;

  HeaderName({Key? key, required this.switchFeedHelper}) : super(key: key);

  @override
  _HeaderNameState createState() => _HeaderNameState();
}

class _HeaderNameState extends State<HeaderName> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          widget.switchFeedHelper.memberOfFeed.name!,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ));
  }
}
