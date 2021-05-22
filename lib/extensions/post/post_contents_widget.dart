import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_feed/extensions/post/embedded_page.dart';
import 'package:eliud_pkg_feed/extensions/util/post_media_helper.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/platform/medium_platform.dart';
import 'package:eliud_pkg_feed/tools/filter_member_media.dart';
import 'package:flutter/material.dart';

class PostContentsWidget extends StatefulWidget {
  final MemberModel? member;
  final PostModel? postModel;
  final AccessBloc? accessBloc;
  final String? parentPageId;

  const PostContentsWidget({Key? key, this.member, this.postModel, this.accessBloc, this.parentPageId}) : super(key: key);

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
      if (widget.member != null) {
        return EmbeddedPageHelper.postDetails(widget.member!.documentID, widget.postModel,
                widget.accessBloc, context, widget.parentPageId!);
      }
    } else if (widget.postModel!.memberMedia != null) {
      List<Widget> widgets = [];
      // Photos & videos
      var filterMemberMedia = FilterMemberMedia(widget.postModel!.memberMedia!);
      var photos = filterMemberMedia.getPhotos();
      if (photos != null) {
        var urls = photos.map((memberMedium) => memberMedium.url).toList();
        if (urls.length > 0) {
          widgets.add(PostMediaHelper.videoAndPhotoDivider(context));
          widgets.add(PostMediaHelper.staggeredMemberMediumModel(
              photos, viewAction: (index) {
            AbstractMediumPlatform.platform!.showPhotosFromUrls(
                context, urls, index);
          }));
        }
      };
      var videos = filterMemberMedia.getVideos();
      if (videos != null) {
        if (videos.length > 0) {
          widgets.add(PostMediaHelper.videoAndPhotoDivider(context));
          widgets.add(PostMediaHelper.staggeredMemberMediumModel(
              videos, viewAction: (index) {
            AbstractMediumPlatform.platform!.showVideoFromUrl(
                context, videos[index].url!);
          }));
        }
      }
      return Column(children: widgets);
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
