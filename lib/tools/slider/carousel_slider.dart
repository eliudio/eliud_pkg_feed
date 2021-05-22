import 'dart:typed_data';

import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:photo_view/photo_view.dart' as pv;
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

abstract class SlideImageProvider {
  Widget getImage(int index);
  int count();
}

class UrlSlideImageProvider extends SlideImageProvider {
  final List<String> urls;

  UrlSlideImageProvider(this.urls);

  @override
  Widget getImage(int index) {
    return Image.network(urls[index]);
  }

  @override
  int count() => urls.length;
}

class Uint8ListSlideImageProvider extends SlideImageProvider {
  final List<Uint8List> data;

  Uint8ListSlideImageProvider(this.data);

  @override
  Widget getImage(int index) {
    return Image.memory(data[index]);
  }

  @override
  int count() => data.length;
}

class AlbumSlider extends StatefulWidget {
  final String? title;
  final SlideImageProvider slideImageProvider;
  final int? initialPage;
  final bool? withCloseButton;
  final bool? withNextPrevButton;

  AlbumSlider(
      {Key? key,
      this.title,
      required this.slideImageProvider,
      this.initialPage,
      this.withCloseButton = true,
      this.withNextPrevButton = true})
      : super(key: key);

  @override
  _AlbumSliderState createState() => _AlbumSliderState();
}

class _AlbumSliderState extends State<AlbumSlider> {
  CarouselSliderController? _sliderController;

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }

  Widget getCarousel2() {
    return Image.network((widget.slideImageProvider as UrlSlideImageProvider)
        .urls[widget.initialPage!]);
  }

  Widget getCarousel() {
    var height = kToolbarHeight;
    return CarouselSlider.builder(
      unlimitedMode: true,
      controller: _sliderController,
      slideBuilder: (index) {
        return Stack(
          children: <Widget>[
            Center(child: DelayedCircularProgressIndicator()),
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height - height,
              child: PinchZoom(
                image: widget.slideImageProvider.getImage(index),
                zoomedBackgroundColor: Colors.black.withOpacity(0.5),
                resetDuration: const Duration(milliseconds: 100),
                maxScale: 2.5,
                onZoomStart: () {
                },
                onZoomEnd: () {
                },
              ),
            )),
          ],
        );
      },
      slideTransform: BackgroundToForegroundTransform(),
      slideIndicator: SequentialFillIndicator(
        padding: EdgeInsets.only(bottom: 0),
        currentIndicatorColor: Colors.red,
        indicatorBackgroundColor: Colors.white,
        enableAnimation: true,
      ),
      itemCount: widget.slideImageProvider.count(),
      initialPage: widget.initialPage!,
      enableAutoSlider: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      getCarousel(),
    ];

    if ((widget.withCloseButton != null) && (widget.withCloseButton!)) {
      widgets.add(Align(
          alignment: Alignment.topRight,
          child: TextButton(
            child: Icon(Icons.close, color: Colors.red, size: 30),
            onPressed: () {
              Navigator.maybePop(context);
            },
          )));
    }
    if ((widget.withNextPrevButton != null) && (widget.withNextPrevButton!)) {
      widgets.add(Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            child: Icon(Icons.navigate_next, color: Colors.red, size: 50),
            onPressed: () {
              _sliderController!.nextPage();
            },
          )));
      widgets.add(Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            child: Icon(Icons.navigate_before, color: Colors.red, size: 50),
            onPressed: () {
              _sliderController!.previousPage();
            },
          )));
    }
    return Stack(children: widgets);
  }
}
