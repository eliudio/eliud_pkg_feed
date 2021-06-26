import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/util/media_buttons.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum PostType { PostPhoto, PostVideo }

/*
 * PostButton is used to be able to add photos or videos to the feed.
 * It's a photo or video button which allows to do just that.
 */
class PostButton extends StatefulWidget {
  final FeedModel feedModel;
  final PostType postType;
  List<String> readAccess;
  MemberModel author;

  PostButton(this.feedModel, this.postType, this.readAccess, this.author);

  _PostButtonState createState() => _PostButtonState();
}

class _PostButtonState extends State<PostButton> {
  double? photoUploadingProgress;
  _PostButtonState();

  @override
  Widget build(BuildContext context) {
    if (widget.postType == PostType.PostPhoto) {
      var _photo = Image.asset(
          "assets/images/segoshvishna.fiverr.com/photo.png",
          package: "eliud_pkg_feed");
      return MediaButtons.mediaButtons(
          context,
          widget.feedModel.appId!,
          widget.author.documentID!,
          widget.readAccess,
          allowCrop: false,
          tooltip: 'Add photo', photoFeedbackFunction: (photo) {
        _addPost(postMemberMedia: [
          PostMediumModel(documentID: newRandomKey(), memberMedium: photo)
        ]);
        photoUploadingProgress = null;
      }, photoFeedbackProgress: (progress) {
        setState(() {
          photoUploadingProgress = progress;
        });
      }, icon: _getIcon(_photo));
    } else {
      var _video = Image.asset(
          "assets/images/segoshvishna.fiverr.com/video.png",
          package: "eliud_pkg_feed");
      return MediaButtons.mediaButtons(
          context,
          widget.feedModel.appId!,
          widget.author.documentID!,
          widget.readAccess,
          allowCrop: false,
          tooltip: 'Add video', videoFeedbackFunction: (photo) {
        _addPost(postMemberMedia: [
          PostMediumModel(documentID: newRandomKey(), memberMedium: photo)
        ]);
        photoUploadingProgress = null;
      }, videoFeedbackProgress: (progress) {
        setState(() {
          photoUploadingProgress = progress;
        });
      }, icon: _getIcon(_video));
    }
  }

  void _addPost(
      {String? html,
      String? description,
      List<PostMediumModel>? postMemberMedia}) {
    BlocProvider.of<PostListPagedBloc>(context).add(AddPostPaged(
        value: PostModel(
            documentID: newRandomKey(),
            authorId: widget.author.documentID,
            appId: widget.feedModel.appId!,
            feedId: widget.feedModel.documentID!,
            likes: 0,
            dislikes: 0,
            description: description,
            readAccess: widget.readAccess,
            archived: PostArchiveStatus.Active,
            html: html,
            memberMedia: postMemberMedia)));
  }

  Widget _getIcon(Widget child) {
    if (photoUploadingProgress == null) {
      return _getOriginalIcon(child);
    } else {
      return Stack(children: [
        _getOriginalIcon(child),
        Container(
            padding: const EdgeInsets.only(top: 22.5, bottom: 22.5),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    margin: EdgeInsets.all(7.0),
                    padding: EdgeInsets.all(2.0),
                    child: SizedBox(
                      width: 45 * photoUploadingProgress!,
                      height: 5,
                      child: ColorFiltered(
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.9), BlendMode.dstATop),
                          child: const DecoratedBox(
                            decoration: const BoxDecoration(color: Colors.red),
                          )),
                    ))))
      ]);
    }
  }

  Widget _getOriginalIcon(Widget child, {double? width}) {
    return Container(
        padding: const EdgeInsets.only(top: 22.5, bottom: 22.5),
        child: StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .containerStyle()
            .actionContainer(context,
                child: Center(
                    child: Container(
                        padding: EdgeInsets.all(2.0),
                        width: width == null ? 45 : width,
                        height: 40,
                        child: child))));
  }
}
