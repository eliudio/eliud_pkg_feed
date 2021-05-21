import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_pkg_feed/extensions/post/embedded_page.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
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
      // Photos & videos
      var filterMemberMedia = FilterMemberMedia(widget.postModel!.memberMedia!);
      var photos = filterMemberMedia.getPhotos();
      var videos = filterMemberMedia.getVideos();
    } else if (widget.postModel!.externalLink != null) {
/*
      return WebView(
        initialUrl: state.postModel.externalLink,
        javascriptMode: JavascriptMode.unrestricted,
      );
*/
      return Text("External link not supported yet");
    }
    return Text("Post not supported");
  }
}
