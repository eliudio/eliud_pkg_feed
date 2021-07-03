import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/medium_data.dart';
import 'package:eliud_core/tools/storage/member_medium_helper.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'medium_platform.dart';

class WebMediumPlatform extends AbstractMediumPlatform {
  @override
  void takePhoto(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop}) {}

  @override
  void takeVideo(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) {}

  @override
  bool hasCamera() => false;

  Future<void> uploadPhoto(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop}) async {
    var _result = await FilePicker.platform.pickFiles(type: FileType.image);
    return processPhotos(_result, appId, ownerId, readAccess, feedbackFunction, feedbackProgress);
  }

  Future<void> uploadVideo(BuildContext context, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress) async {
    var _result = await FilePicker.platform.pickFiles(type: FileType.video);
    return processVideos(_result, appId, ownerId, readAccess, feedbackFunction, feedbackProgress);
  }

  Future<void> processPhotos(FilePickerResult? result, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress, {bool? allowCrop}) async {
    if (result != null) {
      for (var aFile in result.files) {
        var baseName = aFile.name;
        var thumbnailBaseName = aFile.extension!;
        var bytes = aFile.bytes;

        print("process photos");
        if ((allowCrop != null) && (allowCrop)) {
          print("allow crop");
          var newFile = await ImageCropper.cropImage(
              sourcePath: aFile.path!,
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
          var memberMediumModel = await MemberMediumHelper
              .createThumbnailUploadPhotoFile(
              appId,
              newFile!.path,
              ownerId,
              readAccess,
              feedbackProgress: feedbackProgress
          );
          feedbackFunction(memberMediumModel);
        } else {
          print("do not crop");
          if (bytes != null) {
            var memberMediumModel = await MemberMediumHelper
                .createThumbnailUploadPhotoData(appId,
                bytes,
                baseName,
                thumbnailBaseName,
                ownerId,
                readAccess,
                feedbackProgress: feedbackProgress
            );
            feedbackFunction(memberMediumModel);
          } else {
            print('bytes is null!');
          }
        }
      }
    }
  }

  Future<void> processVideos(
    FilePickerResult? result, String appId, String ownerId, List<String> readAccess, MemberMediumAvailable feedbackFunction, FeedbackProgress? feedbackProgress,
  ) async {
    if (result != null) {
      for (var aFile in result.files) {
        var bytes = aFile.bytes;
        if (bytes == null)
          throw Exception('Could not process video. Bytes is null');
        var name = aFile.name;
        if (name == null)
          throw Exception('Could not process video. Name is null');

        var baseName = name;
        var thumbnailBaseName = BaseNameHelper.thumbnailBaseName(name);

        var memberMediumModel = await MemberMediumHelper.createThumbnailUploadVideoData(appId, bytes, baseName, thumbnailBaseName, ownerId, readAccess, feedbackProgress: feedbackProgress);
        feedbackFunction(memberMediumModel);
      }
    }
  }
}
