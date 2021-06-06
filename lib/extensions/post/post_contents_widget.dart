import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/tools/storage/fb_storage_image.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_feed/extensions/post/embedded_page.dart';
import 'package:eliud_pkg_feed/extensions/util/post_media_helper.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/platform/medium_platform.dart';
import 'package:eliud_pkg_feed/tools/filter_member_media.dart';
import 'package:flutter/material.dart';

class PostContentsWidget extends StatefulWidget {
  final String? memberID;
  final PostModel? postModel;
  final AccessBloc? accessBloc;
  final String? parentPageId;

  const PostContentsWidget(
      {Key? key,
      this.memberID,
      this.postModel,
      this.accessBloc,
      this.parentPageId})
      : super(key: key);

  @override
  _PostContentsWidgetState createState() {
    return _PostContentsWidgetState();
  }
}

class _PostContentsWidgetState extends State<PostContentsWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.postModel == null) return Text("No post defined");
    List<Tab> tabs = [];

    if (widget.postModel!.postPageId != null) {
      if (widget.memberID != null) {
        return EmbeddedPageHelper.postDetails(widget.memberID,
            widget.postModel, widget.accessBloc, context, widget.parentPageId!);
      }
    } else if ((widget.postModel!.memberMedia != null) &&
        (widget.postModel!.memberMedia!.length > 0)) {
      if (widget.postModel!.memberMedia!.length == 1) {
        var medium = widget.postModel!.memberMedia![0];
        return Center(child:FbStorageImage(ref: medium.memberMedium!.refThumbnail!));
      } else {
        List<PostMediumModel> memberMedia = widget.postModel!.memberMedia!;
        List<Widget> widgets = [];
        // Photos & videos
        widgets.add(PostMediaHelper.videoAndPhotoDivider(context));
        widgets.add(PostMediaHelper.staggeredMemberMediumModelFromPostMedia(
            memberMedia, viewAction: (index) {
          _action(memberMedia, index);
        }));
        return Column(children: widgets);
      }
    } else if (widget.postModel!.externalLink != null) {
/*
      return WebView(
        initialUrl: state.postModel.externalLink,
        javascriptMode: JavascriptMode.unrestricted,
      );
*/
      return Text("External link not supported yet");
    }
    return Container(height: 1); // nothing
  }

  void _action(List<PostMediumModel> memberMedia, int index) {
    var postMedium = memberMedia[index];
    if (postMedium.memberMedium!.mediumType! == MediumType.Photo) {
      AbstractMediumPlatform.platform!
          .showPhotosFromPostMedia(context, memberMedia, index);
    } else {
      AbstractMediumPlatform.platform!
          .showVideo(context, postMedium.memberMedium!);
    }
  }

/*
  Widget _row2(FeedPostFormInitialized state) {
    return PostMediaHelper.staggeredPhotosWithThumbnail(state.postModelDetails.photoWithThumbnails, (index) {
      var photos = state.postModelDetails.photoWithThumbnails;
      photos.removeAt(index);
      _myFormBloc.add(ChangedFeedPhotos(photoWithThumbnails: photos));
    }, (index) {
      var photos = state.postModelDetails.photoWithThumbnails;
      AbstractMediumPlatform.platform!.showPhotos(context, photos, index);
    });
  }

  Widget _row3(FeedPostFormInitialized state) {
    return PostMediaHelper.staggeredVideosWithThumbnail(state.postModelDetails.videoWithThumbnails, (index) {
      var videos = state.postModelDetails.videoWithThumbnails;
      videos.removeAt(index);
      _myFormBloc.add(ChangedFeedVideos(videoWithThumbnails: videos));
    }, (index) {
      var videos = state.postModelDetails.videoWithThumbnails;
      var medium = videos[index];
      AbstractMediumPlatform.platform!.showVideo(context, medium);
    });
  }
*/

}
