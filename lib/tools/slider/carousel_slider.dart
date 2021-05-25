import 'dart:typed_data';

import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

abstract class SlideImageProvider {
  Widget getImage(int index);
  int count();
}

class FbStorageImage extends StatefulWidget {
  final String ref;
  
  const FbStorageImage({Key? key, required this.ref, }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FbStorageImageState();
  }
}

class _FbStorageImageState extends State<FbStorageImage> {
  Future<Uint8List?>? future;

  @override
  void initState() {
    print("Init");
    future = firebase_storage.FirebaseStorage.instance.ref(widget.ref).getData();
    print("After");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
        future: future,
        builder: (context, snapshot) {
          print("1");
          if (snapshot.hasData) {
            print("2");
            if (snapshot.data != null) {
              print("3");
              return Image.memory(snapshot.data!);
            } else {
              return Image.asset(
                  "assets/images/manypixels.co/404_Page_Not_Found _Flatline.png",
                  package: "eliud_pkg_feed");
            }
          }
          return Center(child: DelayedCircularProgressIndicator());
        });
  }
}

class UrlSlideImageProvider extends SlideImageProvider {
  final List<String> urls;

  UrlSlideImageProvider(this.urls);

  @override
  Widget getImage(int index) {
    String ref = urls[index];
    return FbStorageImage(ref: ref);
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
                onZoomStart: () {},
                onZoomEnd: () {},
              ),
            )),
          ],
        );
      },
      slideTransform: DefaultTransform(),
      slideIndicator: CircularSlideIndicator(
        padding: EdgeInsets.only(bottom: 0),
        currentIndicatorColor: Colors.red,
        indicatorBackgroundColor: Colors.white,
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
