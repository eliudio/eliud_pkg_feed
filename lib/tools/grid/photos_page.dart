import 'dart:math';

import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_pkg_feed/platform/medium_platform.dart';
import 'package:eliud_pkg_feed/tools/slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class MediumToPresentationData {
  List<StaggeredTile>? tiles;
  List<Widget>? widgets;
}

/*
 * Widget to show a grid of photos and allow to open photo in a photoview
 */
class PhotosPage extends StatelessWidget {
  final List<MemberMediumModel>? memberMedia;

  const PhotosPage({Key? key, this.memberMedia}) : super(key: key);

  static int size = 5;
  static double maxCrossAxisExtent = 100;

  @override
  Widget build(BuildContext context) {
    List<StaggeredTile> tiles = [];
    List<Widget> widgets = [];
    for (int i = 0; i < memberMedia!.length; i++) {
      var memberMedium = memberMedia![i];
      var image;
      if (memberMedium.urlThumbnail == null) {
        image = Text("No image");
      } else {
        image = FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: memberMedium.urlThumbnail!,
        );
      }
      var thumbnailWidth = memberMedium.thumbnailWidth;
      var thumbnailHeight = memberMedium.thumbnailHeight;
      var tile;
      var crossAxisCellCount = max(thumbnailWidth! ~/ maxCrossAxisExtent, 1);
      tile =
          StaggeredTile.extent(crossAxisCellCount, thumbnailHeight!.toDouble());
      tiles.add(tile);
      var urls = memberMedia!.map((memberMedium) => memberMedium.url).toList();
      widgets.add(GestureDetector(
        onTap: () {
        if (urls != null) {
          AbstractMediumPlatform.platform!.showPhotosFromUrls(context, urls, i);
        }
        },
        // The custom button
        child: image,
      ));
    }
    return PhotoView.extent(
        maxCrossAxisExtent: 100.0, tiles: tiles, widgets: widgets);
  }
}


class PhotoView extends StatelessWidget {
  const PhotoView.extent(
      {@required this.maxCrossAxisExtent,
        @required this.tiles,
        this.mainAxisSpacing: 4.0,
        this.crossAxisSpacing: 4.0,
        this.widgets})
      : crossAxisCount = null;

  static const EdgeInsetsGeometry padding =
  const EdgeInsets.symmetric(horizontal: 4.0);

  final List<StaggeredTile>? tiles;
  final int? crossAxisCount;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final double? maxCrossAxisExtent;
  final List<Widget>? widgets;

  @override
  Widget build(BuildContext context) {
    if (maxCrossAxisExtent == null) return Text("maxCrossAxisExtent is null");
    if (tiles == null) return Text("tiles is null");
    return StaggeredGridView.extentBuilder(
      primary: false,
      maxCrossAxisExtent: maxCrossAxisExtent!,
      itemCount: tiles!.length,
      itemBuilder: _getChild,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: padding,
      staggeredTileBuilder: _getStaggeredTile,
    );
  }

  StaggeredTile _getStaggeredTile(int i) {
    var tile = i >= tiles!.length ? null : tiles![i];
    return tile!;
  }

  Widget _getChild(BuildContext context, int i) {
    var widget = i >= widgets!.length ? null : widgets![i];
    if (widget == null) return Text("No child");
    return widget;
  }
}
