import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart' as pv;
import 'package:transparent_image/transparent_image.dart';

class AlbumSlider extends StatefulWidget {
  final String? title;
  final List<String?>? urls;
  final int? initialPage;
  final bool? withCloseButton;
  final bool? withNextPrevButton;

  AlbumSlider({Key? key, this.title, this.urls, this.initialPage, this.withCloseButton = true, this.withNextPrevButton = true})
      : super(key: key);

  @override
  _AlbumSliderState createState() => _AlbumSliderState();
}

class _AlbumSliderState extends State<AlbumSlider> {
  bool _isPlaying = false;

  CarouselSliderController? _sliderController;
  
  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
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
                    child: pv.PhotoView(
                        imageProvider: NetworkImage(widget.urls![index]!),
                        backgroundDecoration: BoxDecoration(color: Colors.transparent)
                    ))),
          ],
        );
      },
//      slideTransform: ParallaxTransform(clipAmount: 400),
      slideTransform: BackgroundToForegroundTransform(),
      slideIndicator: SequentialFillIndicator(
        padding: EdgeInsets.only(bottom: 0),
        currentIndicatorColor: Colors.red,
        indicatorBackgroundColor: Colors.white,
        enableAnimation: true,
      ),
      itemCount: widget.urls!.length,
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
            child: Icon(Icons.close, color: Colors.red, size: 50),
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
