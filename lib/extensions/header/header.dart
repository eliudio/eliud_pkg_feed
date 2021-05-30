import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'header_image.dart';
import 'header_name.dart';

class Header extends StatefulWidget {
  final SwitchFeedHelper switchFeedHelper;

  Header({Key? key, required this.switchFeedHelper}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    rows.add(HeaderImage(switchFeedHelper: widget.switchFeedHelper,));
    rows.add(HeaderName(switchFeedHelper: widget.switchFeedHelper,));
    return Column(children: rows);
  }
}
