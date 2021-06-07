import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:camera/camera.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_core/tools/storage/medium_data.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import '../tools/view/video_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'medium_platform.dart';
import 'mobile/eliud_camera.dart';

class MobileMediumPlatform extends AbstractMediumPlatform {
  Future<void> _pickImage(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, ImgSource source, {bool? allowCrop}) async {
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

    if (_image != null) {
      if ((allowCrop != null) && (allowCrop)) {
        _image = await ImageCropper.cropImage(
            sourcePath: _image.path,
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: 'Crop image',
                toolbarColor: Colors.black,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: true),
            iosUiSettings: IOSUiSettings(
              minimumAspectRatio: 1.0,
            )
        );
      }
    }

    if (_image != null) {
      var baseName = BaseNameHelper.baseName(_image.path);
      var thumbnailBaseName = BaseNameHelper.thumbnailBaseName(_image.path);
      var bytes = await _image.readAsBytes();
      var memberMediumModel = await MemberMediumHelper
          .createThumbnailUploadPhotoData(
          appId, bytes, baseName, thumbnailBaseName, ownerId, readAccess,
          feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    }
  }
  @override
  void takePhoto(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop}) {
    _pickImage(context, appId, ownerId, readAccess, feedbackFunction, feedbackProgress, ImgSource.Camera, allowCrop: allowCrop);
  }

  @override
  void takeVideo(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) {
    EliudCamera.openVideoRecorder(context, (video) async {
      var memberMediumModel = await MemberMediumHelper.createThumbnailUploadVideoFile(appId, video.path, ownerId, readAccess, feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    }, (message) {
      print('video error: ' + message);
    });
  }

  @override
  bool hasCamera() => true;

  @override
  Future<void> uploadPhoto(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop}) async {
    var _result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);
    if (_result != null) {
      if ((allowCrop != null) && (allowCrop)) {
        var path = _result!.paths[0];
        if (path == null) return;
        var _image = await ImageCropper.cropImage(
            sourcePath: path,
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: 'Crop image',
                toolbarColor: Colors.black,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: true),
            iosUiSettings: IOSUiSettings(
              minimumAspectRatio: 1.0,
            )
        );
        if (_image != null) {
          processPhoto(
              appId, ownerId, readAccess, _image.path, feedbackFunction,
              feedbackProgress);
        }
        return;
      }
    }
    return processPhotos(appId, ownerId, readAccess, _result, feedbackFunction, feedbackProgress);
  }

  @override
  Future<void> uploadVideo(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) async {
    var _result = await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: true);
    return processVideos(appId, ownerId, readAccess, _result, feedbackFunction, feedbackProgress);
  }

  Future<void> processPhoto(String appId, String ownerId, List<String> readAccess, String? path, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) async {
    if (path != null) {
      var memberMediumModel = await MemberMediumHelper.createThumbnailUploadPhotoFile(appId, path, ownerId, readAccess, feedbackProgress: feedbackProgress);
      feedbackFunction(memberMediumModel);
    } else {
      print("Can't read file: path is null");
    }
 }

  Future<void> processPhotos(String appId, String ownerId, List<String> readAccess, FilePickerResult? result, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) async {
    if (result != null) {
      for (var aFile in result.files) {
        var path = aFile.path;
        processPhoto(appId, ownerId, readAccess, path, feedbackFunction, feedbackProgress);
      }
    }
  }

  Future<void> processVideos(String appId, String ownerId, List<String> readAccess, FilePickerResult? result, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) async {
    if (result != null) {
      for (var aFile in result.files) {
        var path = aFile.path;
        if (path != null) {
          var memberMediumModel = await MemberMediumHelper.createThumbnailUploadVideoFile(appId, path, ownerId, readAccess, feedbackProgress: feedbackProgress);
          feedbackFunction(memberMediumModel);
        } else {
          print("Can't read file: path is null");
        }
      }
    }
  }
}
