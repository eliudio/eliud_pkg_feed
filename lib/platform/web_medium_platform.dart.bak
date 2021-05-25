import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_core/tools/storage/medium_data.dart';
import '../tools/view/video_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'medium_platform.dart';

class WebMediumPlatform extends AbstractMediumPlatform {
  @override
  void showVideo(BuildContext context, VideoWithThumbnail videoWithThumbnail) {
    final blob = html.Blob(videoWithThumbnail.videoData.data);
    final url = html.Url.createObjectUrlFromBlob(blob);
    Navigator.push(context, MaterialPageRoute(builder: (_)
    {
      return VideoView(sourceType: SourceType.Network, source: url);
    }));
  }


  @override
  void takePhoto(BuildContext context, PhotoWithThumbnailAvailable feedbackFunction) {
  }

  @override
  void takeVideo(BuildContext context, VideoWithThumbnailAvailable feedbackFunction) {
  }

  @override
  bool hasCamera() => false;

  Future<void> uploadPhoto(BuildContext context, PhotoWithThumbnailAvailable feedbackFunction) async {
    var _result = await FilePicker.platform.pickFiles(type: FileType.image);
    return processPhotos(_result, feedbackFunction);
  }

  Future<void> uploadVideo(BuildContext context, VideoWithThumbnailAvailable feedbackFunction) async {
    var _result = await FilePicker.platform.pickFiles(type: FileType.video);
    return processVideos(_result, feedbackFunction);
  }

  Future<void> processPhotos(FilePickerResult? result, PhotoWithThumbnailAvailable feedbackFunction,) async {
    if (result != null) {
      for (var aFile in result.files) {
        var baseName = aFile.name!;
        var thumbnailBaseName = aFile.extension!;
        var bytes = aFile.bytes;
        if (bytes != null) {
          var thumbnailInfo = await MediumData.enrichPhoto(
              baseName, thumbnailBaseName, bytes);

          feedbackFunction(thumbnailInfo);
        } else {
          print('bytes is null!');
        }
      }
    }
  }

  Future<void> processVideos(FilePickerResult? result, VideoWithThumbnailAvailable feedbackFunction,) async {
    if (result != null) {
      for (var aFile in result.files) {
        var bytes = aFile.bytes;
        if (bytes == null) throw Exception('Could not process video. Bytes is null');
        var name = aFile.name;
        if (name == null) throw Exception('Could not process video. Name is null');
        var path = aFile.path;
        if (path == null) throw Exception('Could not process video. Path is null');

        var baseName = BaseNameHelper.baseName(path);
        var thumbnailBaseName = BaseNameHelper.thumbnailBaseName(path);
        var thumbnailInfo = await MediumData.enrichVideo(baseName, thumbnailBaseName, aFile.bytes!);

        feedbackFunction(thumbnailInfo);
      }
    }
  }
}
