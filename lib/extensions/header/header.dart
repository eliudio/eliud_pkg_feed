import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_text/extensions/rich_text_dialog.dart';
import 'package:eliud_pkg_text/extensions/rich_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'header_image.dart';
import 'header_name.dart';

class Header extends StatefulWidget {
  final SwitchFeedHelper switchFeedHelper;
  final String appId;
  final String ownerId;

  Header(
      {Key? key,
      required this.switchFeedHelper,
      required this.appId,
      required this.ownerId})
      : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    rows.add(HeaderImage(
      switchFeedHelper: widget.switchFeedHelper,
    ));
    rows.add(HeaderName(
      switchFeedHelper: widget.switchFeedHelper,
    ));
    return Column(children: rows);
  }
}
