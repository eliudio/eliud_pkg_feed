import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderImage extends StatefulWidget {
  final SwitchFeedHelper switchFeedHelper;

  HeaderImage({Key? key, required this.switchFeedHelper}) : super(key: key);

  @override
  _HeaderImageState createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  ImageProvider _backgroundPhoto(BuildContext context) {
    return AssetImage(
        'assets/images/pexels.com/pexels-bri-schneiter-346529.jpg',
        package: "eliud_pkg_feed");
  }

  DecorationImage _background(BuildContext context) {
    return DecorationImage(image: _backgroundPhoto(context), fit: BoxFit.cover);
  }

  Widget _container(BuildContext context) {
    return Container(height: 200, child: _profileWidget(context));
  }

  Widget _profileWidget(BuildContext context) {
    var avatar = Align(
        alignment: Alignment.bottomCenter,
        child: widget.switchFeedHelper.getFeedWidget2(context, backgroundColor: Colors.black, backgroundColor2: Colors.white, radius: 45));
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    rows.add(_container(context));
    return PostHelper.getFormattedPost(rows, image: _background(context));
  }
}
