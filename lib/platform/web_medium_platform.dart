import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/storage/basename_helper.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_core/tools/storage/medium_data.dart';
import 'package:eliud_core/tools/storage/upload_info.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_core/tools/widgets/error_dialog.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import '../tools/view/video_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'medium_platform.dart';

class WebMediumPlatform extends AbstractMediumPlatform {
  @override
  Future<void> showVideo(
      BuildContext context, VideoWithThumbnail videoWithThumbnail) async {
    // unfortunately I don't have a video view which can show Uint8List,
    // so for the time being I upload the data to storage to view from URL.
    // I have tried this, but without success:
    //       import 'dart:html' as html;
    //       final blob = html.Blob(videoWithThumbnail.videoData.data);
    //       url = html.Url.createObjectUrlFromBlob(blob);
    var state = AccessBloc.getState(context);
    if (state is LoggedIn) {
      var member = state.member;
      var memberId = member.documentID!;
      var app = state.app;
      print("1");

      UploadInfo? uploadData = await UploadInfo.uploadTempData(
          videoWithThumbnail.videoData.data,
          app.documentID!,
          memberId,
          PostFollowersHelper.asMe(memberId));
      print("2");
      if (uploadData != null) {
        print("3");
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          print("4");
          return VideoView(
              sourceType: SourceType.Network, source: uploadData.url);
        }));
      } else {
        DialogStatefulWidgetHelper.openIt(
            context,
            ErrorDialog.errorDialog(
              message: "An error occured whilst processing the video",
            ));
      }
    } else {
      DialogStatefulWidgetHelper.openIt(
          context,
          ErrorDialog.errorDialog(
            message: "Can't play video: Your status is not logged on",
          ));
    }
  }

  @override
  void takePhoto(
      BuildContext context, PhotoWithThumbnailAvailable feedbackFunction) {}

  @override
  void takeVideo(
      BuildContext context, VideoWithThumbnailAvailable feedbackFunction) {}

  @override
  bool hasCamera() => false;

  Future<void> uploadPhoto(BuildContext context,
      PhotoWithThumbnailAvailable feedbackFunction) async {
    var _result = await FilePicker.platform.pickFiles(type: FileType.image);
    return processPhotos(_result, feedbackFunction);
  }

  Future<void> uploadVideo(BuildContext context,
      VideoWithThumbnailAvailable feedbackFunction) async {
    var _result = await FilePicker.platform.pickFiles(type: FileType.video);
    return processVideos(_result, feedbackFunction);
  }

  Future<void> processPhotos(
    FilePickerResult? result,
    PhotoWithThumbnailAvailable feedbackFunction,
  ) async {
    if (result != null) {
      for (var aFile in result.files) {
        var baseName = aFile.name!;
        var thumbnailBaseName = aFile.extension!;
        var bytes = aFile.bytes;
        if (bytes != null) {
          var thumbnailInfo =
              await MediumData.enrichPhoto(baseName, thumbnailBaseName, bytes);

          feedbackFunction(thumbnailInfo);
        } else {
          print('bytes is null!');
        }
      }
    }
  }

  Future<void> processVideos(
    FilePickerResult? result,
    VideoWithThumbnailAvailable feedbackFunction,
  ) async {
    if (result != null) {
      for (var aFile in result.files) {
        var bytes = aFile.bytes;
        if (bytes == null)
          throw Exception('Could not process video. Bytes is null');
        var name = aFile.name;
        if (name == null)
          throw Exception('Could not process video. Name is null');
/*
        var path = aFile.path;
        if (path == null) throw Exception('Could not process video. Path is null');
*/

        var baseName = name;
        var thumbnailBaseName = BaseNameHelper.thumbnailBaseName(name);
        var thumbnailInfo = await MediumData.enrichVideo(
            baseName, thumbnailBaseName, aFile.bytes!);

        feedbackFunction(thumbnailInfo);
      }
    }
  }
}
