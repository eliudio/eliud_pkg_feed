import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/member_medium_model.dart';
import 'package:eliud_core_main/model/member_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_container.dart';
import 'package:eliud_core_main/apis/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core_helpers/etc/random.dart';
import 'package:eliud_core_model/model/member_medium_container_model.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed_model/model/feed_model.dart';
import 'package:eliud_pkg_feed_model/model/post_model.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

enum PostType { postPhoto, postVideo }

typedef PostAccessibleProviderFunction
    = Tuple2<PostAccessibleByGroup, List<String>?> Function();

/*
 * PostButton is used to be able to add photos or videos to the feed.
 * It's a photo or video button which allows to do just that.
 */
class PostButton extends StatefulWidget {
  final AppModel app;
  final FeedModel feedModel;
  final PostType postType;
  final PostAccessibleProviderFunction postAccessibleProviderFunction;
  final MemberModel author;

  PostButton(this.app, this.feedModel, this.postType,
      this.postAccessibleProviderFunction, this.author);

  @override
  State<PostButton> createState() => PostButtonState();
}

class PostButtonState extends State<PostButton> {
  double? uploadingProgress;
  PostButtonState();

  @override
  Widget build(BuildContext context) {
    if (widget.postType == PostType.postPhoto) {
      var photo = Image.asset("assets/images/segoshvishna.fiverr.com/photo.png",
          package: "eliud_pkg_feed");
      if (uploadingProgress == null) {
        return MediaButtons.mediaButtons(
            context,
            widget.app,
            () => Tuple2(
                toMemberMediumAccessibleByGroup(
                    widget.postAccessibleProviderFunction().item1.index),
                widget.postAccessibleProviderFunction().item2),
            allowCrop: false,
            tooltip: 'Add photo', photoFeedbackFunction: (photo) {
          if (photo != null) {
            _addPost(postMemberMedia: [
              MemberMediumContainerModel(
                  documentID: newRandomKey(), memberMedium: photo)
            ]);
          }
          uploadingProgress = null;
        }, photoFeedbackProgress: (progress) {
          setState(() {
            uploadingProgress = progress;
          });
        }, icon: _getIcon(photo));
      } else {
        return _getIcon(photo);
      }
    } else {
      var video = Image.asset("assets/images/segoshvishna.fiverr.com/video.png",
          package: "eliud_pkg_feed");
      if (uploadingProgress == null) {
        return MediaButtons.mediaButtons(
            context,
            widget.app,
            () => Tuple2(
                toMemberMediumAccessibleByGroup(
                    widget.postAccessibleProviderFunction().item1.index),
                widget.postAccessibleProviderFunction().item2),
            allowCrop: false,
            tooltip: 'Add video', videoFeedbackFunction: (video) {
          if (video != null) {
            _addPost(postMemberMedia: [
              MemberMediumContainerModel(
                  documentID: newRandomKey(), memberMedium: video)
            ]);
          }
          uploadingProgress = null;
        }, videoFeedbackProgress: (progress) {
          setState(() {
            uploadingProgress = progress;
          });
        }, icon: _getIcon(video));
      } else {
        return _getIcon(video);
      }
    }
  }

  void _addPost(
      {String? html,
      String? description,
      List<MemberMediumContainerModel>? postMemberMedia}) {
    BlocProvider.of<PostListPagedBloc>(context).add(AddPostPaged(
        value: PostModel(
      documentID: newRandomKey(),
      authorId: widget.author.documentID,
      appId: widget.feedModel.appId,
      feedId: widget.feedModel.documentID,
      likes: 0,
      dislikes: 0,
      description: description,
      accessibleByGroup: widget.postAccessibleProviderFunction().item1,
      accessibleByMembers: widget.postAccessibleProviderFunction().item2,
      archived: PostArchiveStatus.active,
      html: html,
      memberMedia: postMemberMedia,
      readAccess: [
        widget.author.documentID
      ], // default readAccess to the owner. The function will expand this based on accessibleByGroup/Members
    )));
  }

  Widget _getIcon(Widget child) {
    if (uploadingProgress == null) {
      return formatIcon(context, widget.app, child);
    } else {
      return Stack(children: [
        formatIcon(context, widget.app, child),
        Container(
            width: 60,
            child: progressIndicatorWithValue(widget.app, context,
                value: uploadingProgress!))
      ]);

/*
      Container(
          width: 45 * photoUploadingProgress!,
          height: 40,
          child: Stack(children: [
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
                                  Colors.black.withOpacity(0.9),
                                  BlendMode.dstATop),
                              child: const DecoratedBox(
                                decoration:
                                    const BoxDecoration(color: Colors.red),
                              )),
                        ))))
          ]));
*/
    }
  }

  static Widget formatIcon(BuildContext context, AppModel app, Widget child,
      {double? width}) {
    return actionContainer(app, context, child: child);
  }
}
