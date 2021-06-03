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
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  ImageProvider _backgroundPhoto(BuildContext context) {
    return AssetImage(
        'assets/images/pexels.com/pexels-bri-schneiter-346529.jpg',
        package: "eliud_pkg_feed");
  }

  DecorationImage _background(BuildContext context) {
    return DecorationImage(image: _backgroundPhoto(context), fit: BoxFit.cover);
  }

  Widget _container(BuildContext context) {
    return Container(height: height(context) / 3, child: _profileWidget(context));
  }

  Widget _profileWidget(BuildContext context) {
    var avatar = Align(
        alignment: Alignment.bottomCenter,
        child: widget.switchFeedHelper.getFeedWidget2(context, 45, backgroundColor: Colors.black, backgroundColor2: Colors.white));
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    rows.add(_container(context));
    return PostHelper.getFormattedPost(rows, image: _background(context));
  }
}
