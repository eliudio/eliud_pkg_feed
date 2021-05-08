import 'dart:math';

import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_pkg_feed/tools/grid/photos_view.dart';
import 'package:eliud_pkg_feed/tools/slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class MediumToPresentationData {
  List<StaggeredTile>? tiles;
  List<Widget>? widgets;
}

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
/*
          Navigator.push(context, PageRouteBuilder(
              opaque: true,
              pageBuilder: (_, __, ___) {
                return AlbumSlider(title: "Photos", urls: urls, initialPage: i);
              }));
*/
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AlbumSlider(title: "Photos", urls: urls, initialPage: i);
          }));
/*
          DialogStatefulWidgetHelper.openIt(
              context,
              WidgetDialog(
                  title: 'Photo',
                  widget:
                      AlbumSlider(title: "Photos", urls: urls, initialPage: i),
                  yesFunction: () => Navigator.of(context).pop()));
*/
        },
        // The custom button
        child: image,
      ));
    }
    return PhotoView.extent(
        maxCrossAxisExtent: 100.0, tiles: tiles, widgets: widgets);
  }
}
