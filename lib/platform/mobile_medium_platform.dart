import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_core/tools/storage/medium_data.dart';
import 'package:eliud_pkg_feed/tools/grid/videos_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'medium_platform.dart';
import 'mobile/eliud_camera.dart';

class MobileMediumPlatform extends AbstractMediumPlatform {
  @override
  Future<void> showVideo(BuildContext context, VideoWithThumbnail videoWithThumbnail) async {
    final appDir = await syspaths.getTemporaryDirectory();
    var path = '${appDir.path}/sth.jpg';
    File file = File(path);

    await file.writeAsBytes(videoWithThumbnail.videoData.data);
    Navigator.push(context, MaterialPageRoute(builder: (_)
    {
      return VideoView(sourceType: SourceType.File, source: path);
    }));
  }

  Future<void> pickImage(BuildContext context, PhotoWithThumbnailAvailable feedbackFunction, ImgSource source) async {
    var _image = await ImagePickerGC.pickImage(
      enableCloseButton: true,
      closeIcon: Icon(
        Icons.close,
        color: Colors.red,
        size: 12,
      ),
      context: context,
      source: source,
      barrierDismissible: true,
      cameraIcon: Icon(
        Icons.camera_alt,
        color: Colors.red,
      ),
    );
    var baseName = BaseNameHelper.baseName(_image.path);
    var thumbnailBaseName = BaseNameHelper.thumbnailBaseName(_image.path);
    var bytes = await _image.readAsBytes();
    var thumbnailInfo = await MediumData.enrichPhoto(baseName, thumbnailBaseName, bytes);
    feedbackFunction(thumbnailInfo);
  }

  @override
  void takePhoto(BuildContext context, PhotoWithThumbnailAvailable feedbackFunction) {
    pickImage(context, feedbackFunction, ImgSource.Camera);
  }

  Future<void> _videoSaved(XFile file, VideoWithThumbnailAvailable feedbackFunction) async {
    var thumbnailInfo = await MediumData.enrichVideoWithPath(file.path);
    feedbackFunction(thumbnailInfo);
  }

  void _videoError(String message) {
    print('video error: ' + message);
  }

  @override
  void takeVideo(BuildContext context, VideoWithThumbnailAvailable feedbackFunction) {
    EliudCamera.openVideoRecorder(context, (video) => (_videoSaved(video, feedbackFunction)), _videoError);
  }

  @override
  bool hasCamera() => true;

  @override
  Future<void> uploadPhoto(BuildContext context, PhotoWithThumbnailAvailable feedbackFunction) async {
    var _result = await FilePicker.platform.pickFiles(type: FileType.image);
    return processPhotos(_result, feedbackFunction);
  }

  @override
  Future<void> uploadVideo(BuildContext context, VideoWithThumbnailAvailable feedbackFunction) async {
    var _result = await FilePicker.platform.pickFiles(type: FileType.video);
    return processVideos(_result, feedbackFunction);
  }

  Future<void> processPhotos(FilePickerResult? result, PhotoWithThumbnailAvailable feedbackFunction,) async {
    if (result != null) {
      for (var aFile in result.files) {
        var path = aFile.path;
        if (path != null) {
          var thumbnailInfo = await MediumData.enrichPhotoWithPath(path);
          feedbackFunction(thumbnailInfo);
        } else {
          print("Can't read file: path is null");
        }
      }
    }
  }

  Future<void> processVideos(FilePickerResult? result, VideoWithThumbnailAvailable feedbackFunction,) async {
    if (result != null) {
      for (var aFile in result.files) {
        var path = aFile.path;
        if (path != null) {
          var enrichedVideo = await MediumData.enrichVideoWithPath(path);
          feedbackFunction(enrichedVideo);
        } else {
          print("Can't read file: path is null");
        }
      }
    }
  }
}
