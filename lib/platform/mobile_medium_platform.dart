import 'dart:io';
import 'dart:typed_data';

import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'image_crop.dart';
import 'medium_platform.dart';
import 'mobile/eliud_camera.dart';
import 'package:flutter/services.dart' show rootBundle;

class MobileMediumPlatform extends AbstractMediumPlatform {
  @override
  Future<void> takePhoto(
      BuildContext context,
      String appId,
      String ownerId,
      List<String> readAccess,
      MemberMediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      {bool? allowCrop}) async {
    if (feedbackProgress != null) feedbackProgress(-1);
    var _image = await ImagePickerGC.pickImage(
      enableCloseButton: true,
      closeIcon: Icon(
        Icons.close,
        color: Colors.red,
        size: 12,
      ),
      context: context,
      source: ImgSource.Camera,
      barrierDismissible: true,
      cameraIcon: Icon(
        Icons.camera_alt,
        color: Colors.red,
      ),
    );

    if (_image != null) {
      var baseName = BaseNameHelper.baseName(_image.path);
      var thumbnailBaseName = BaseNameHelper.thumbnailBaseName(_image.path);
      var bytes = await _image.readAsBytes();
      if ((allowCrop != null) && (allowCrop)) {
        ImageCropWidget.open(context, (croppedImage) {
          processPhoto(appId, baseName, thumbnailBaseName, ownerId,
              croppedImage, readAccess, feedbackFunction, feedbackProgress);
        }, bytes);
      } else {
        processPhoto(appId, baseName, thumbnailBaseName, ownerId, bytes,
            readAccess, feedbackFunction, feedbackProgress);
      }
    }
  }

  @override
  void takeVideo(
      BuildContext context,
      String appId,
      String ownerId,
      List<String> readAccess,
      MemberMediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress) {
    EliudCamera.openVideoRecorder(context, (video) async {
      var memberMediumModel =
          await MemberMediumHelper.createThumbnailUploadVideoFile(
              appId, video.path, ownerId, readAccess,
              feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    }, (message) {
      print('video error: ' + message);
    });
  }

  @override
  bool hasCamera() => true;

  @override
  Future<void> uploadPhoto(
      BuildContext context,
      String appId,
      String ownerId,
      List<String> readAccess,
      MemberMediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress,
      {bool? allowCrop}) async {
    if (feedbackProgress != null) feedbackProgress(-1);
    var _result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (_result == null) return;
    var path = _result.paths[0];
    if (path == null) return;

    var baseName = BaseNameHelper.baseName(path);
    var thumbnailBaseName = BaseNameHelper.thumbnailBaseName(path);
    var bytes = await File(path).readAsBytes();
    if ((allowCrop != null) && (allowCrop)) {
      ImageCropWidget.open(context, (croppedImage) {
        processPhoto(appId, baseName, thumbnailBaseName, ownerId, croppedImage,
            readAccess, feedbackFunction, feedbackProgress);
      }, bytes);
    } else {
      processPhoto(appId, baseName, thumbnailBaseName, ownerId, bytes,
          readAccess, feedbackFunction, feedbackProgress);
    }
  }

  @override
  Future<void> uploadVideo(
      BuildContext context,
      String appId,
      String ownerId,
      List<String> readAccess,
      MemberMediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress) async {
    var _result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: true);
    return processVideos(appId, ownerId, readAccess, _result, feedbackFunction,
        feedbackProgress);
  }

  Future<void> processVideos(
      String appId,
      String ownerId,
      List<String> readAccess,
      FilePickerResult? result,
      MemberMediumAvailable feedbackFunction,
      FeedbackProgress? feedbackProgress) async {
    if (result != null) {
      for (var aFile in result.files) {
        var path = aFile.path;
        if (path != null) {
          var memberMediumModel =
              await MemberMediumHelper.createThumbnailUploadVideoFile(
                  appId, path, ownerId, readAccess,
                  feedbackProgress: feedbackProgress);
          feedbackFunction(memberMediumModel);
        } else {
          print("Can't read file: path is null");
        }
      }
    }
  }
}
