import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_core/tools/storage/medium_data.dart';
import 'package:eliud_pkg_feed/tools/slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
 * I asssume we want a member storage section on firebase storage. A bucket / directory.
 * I assume we want a model representation of these files which we can use
 * to reference from within a feed, from a gallery, etc...
 * I assume these photos are stored in /appId/memberId/...
 * I assume we might want to have a ui to allow to organise photos in a user image repository
 */
typedef void PhotoWithThumbnailAvailable(PhotoWithThumbnail photoWithThumbnail);
typedef void VideoWithThumbnailAvailable(VideoWithThumbnail videoWithThumbnail);

abstract class AbstractMediumPlatform {
  static AbstractMediumPlatform? platform;

  void showPhotos(BuildContext context, List<PhotoWithThumbnail> photoWithThumbnails, int initialPage) {
    var photos = photoWithThumbnails.map((medium) => medium.photoData.data).toList();
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return AlbumSlider(title: "Photos",
          slideImageProvider: Uint8ListSlideImageProvider(ListHelper.getUint8List(photos)),
          initialPage: initialPage);
    }));
  }

  void showPhotosFromUrls(BuildContext context, List<String?> urls, int initialPage) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return AlbumSlider(title: "Photos",
          slideImageProvider: UrlSlideImageProvider(ListHelper.getStringList(urls)),
          initialPage: initialPage);
    }));
  }

  void showVideo(BuildContext context, VideoWithThumbnail videoWithThumbnail);

  /*
   * Allows the user to take a photo
   * When photo is selected feedbackFunction is triggered
   */
  void takePhoto(BuildContext context, PhotoWithThumbnailAvailable feedbackFunction);

  /*
   * Allows the user to take a photo
   * When photo is selected feedbackFunction is triggered
   */
  void takeVideo(BuildContext context, VideoWithThumbnailAvailable feedbackFunction);

  void uploadPhoto(BuildContext context, PhotoWithThumbnailAvailable feedbackFunction);

  /*
   * Allows the user to select a photo from library
   * When photo is selected feedbackFunction is triggered
   */
  void uploadVideo(BuildContext context, VideoWithThumbnailAvailable feedbackFunction);

  bool hasCamera();
}
