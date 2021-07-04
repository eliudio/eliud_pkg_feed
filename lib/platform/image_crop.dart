import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import '../tools/view/video_view.dart';
import 'package:eliud_pkg_feed/tools/slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void CroppedImage(Uint8List imageBytes);

class ImageCropWidget extends StatefulWidget {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.7;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.7;

  final CroppedImage croppedImage;
  final Uint8List image;

  const ImageCropWidget(
      {Key? key, required this.image, required this.croppedImage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ImageCropState();

  static void open(
    BuildContext context,
    CroppedImage croppedImage,
    Uint8List image,
  ) {
    StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .dialogStyle()
        .openWidgetDialog(context,
            child: ImageCropWidget(
              croppedImage: croppedImage,
              image: image,
            ));
  }
}

class ImageCropState extends State<ImageCropWidget> {
  final _cropController = CropController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .dialogWidgetStyle()
        .flexibleDialog(context,
            title: 'Crop image',
            buttons: [
              Spacer(),
              StyleRegistry.registry()
                  .styleWithContext(context)
                  .frontEndStyle()
                  .buttonStyle()
                  .dialogButton(context, onPressed: () {
                Navigator.pop(context);
              }, label: 'Cancel'),
              StyleRegistry.registry()
                  .styleWithContext(context)
                  .frontEndStyle()
                  .buttonStyle()
                  .dialogButton(context, onPressed: () {
                _cropController.crop();
                Navigator.pop(context);
              }, label: 'Crop'),
            ],
            child: Container(
                height: ImageCropWidget.height(context),
                child: Crop(
                    controller: _cropController,
                    image: widget.image,
                    aspectRatio: 1.0,
                    onCropped: (image) {
                      widget.croppedImage(image);
                    })));
  }
}
