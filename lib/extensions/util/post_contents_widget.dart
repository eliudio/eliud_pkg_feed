import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_container_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/storage/member_image_model_widget.dart';
import 'package:eliud_pkg_feed/extensions/util/post_type_helper.dart';
import 'package:eliud_pkg_text/platform/text_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_pkg_feed/extensions/util/post_media_helper.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';

class PostContentsWidget extends StatefulWidget {
  final AppModel app;
  final String? memberID;
  final PostModel postModel;
  final AccessBloc accessBloc;
  final String? parentPageId;

  const PostContentsWidget(
      {Key? key,
      required this.app,
      this.memberID,
      required this.postModel,
      required this.accessBloc,
      this.parentPageId})
      : super(key: key);

  @override
  _PostContentsWidgetState createState() {
    return _PostContentsWidgetState();
  }
}

class _PostContentsWidgetState extends State<PostContentsWidget> {
  static double _width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return _contents(
        memberID: widget.memberID,
        postModel: widget.postModel,
        accessBloc: widget.accessBloc,
        parentPageId: widget.parentPageId);
  }

  Widget _contents(
      {String? memberID,
      required PostModel postModel,
      AccessBloc? accessBloc,
      String? parentPageId}) {
    PostType postType = PostTypeHelper.determineType(postModel);
    switch (postType) {
      case PostType.EmbeddedPage:
/*
        I comment this out resulting in actually making this feature "embedded page" to stop to work.
        The reason for this is because it seems to cause a lot of overhead in init apps being sent to appbloc.
        The implementation of the embedded page is poor and hence this should be reviewed before use.

        if (memberID != null) {
          return EmbeddedPageHelper.postDetails(
              context, memberID, postModel, accessBloc, parentPageId!);
        }
*/
        break;
      case PostType.SinglePhoto:
      case PostType.SingleVideo:
        var medium = postModel.memberMedia![0];
        var width;
        if (medium.memberMedium != null) {
          if (medium.memberMedium!.mediumType == MediumType.Photo) {
            width = _width(context) * .7;
          }
          return GestureDetector(
              child: Center(
                  child: MemberImageModelWidget(
                    memberMediumModel: medium.memberMedium!,
                    width: width,
                    showThumbnail:
                    medium.memberMedium!.mediumType != MediumType.Photo,
                  )),
              onTap: () {
                _action([medium], 0);
              });
        } else {
          print('postmodel with id ' +
              postModel.documentID! +
              ' has memberMedia with no details');
        }
        break;
      case PostType.Album:
        List<MemberMediumContainerModel> memberMedia = postModel.memberMedia!;
        List<Widget> widgets = [];
        // Photos & videos
        //widgets.add(PostMediaHelper.videoAndPhotoDivider(context));
        widgets.add(PostMediaHelper.staggeredMemberMediumModelFromPostMedia(
            context, widget.app, memberMedia, viewAction: (index) {
          _action(memberMedia, index);
        }));
        return Column(children: widgets);
      case PostType.ExternalLink:
        return text(widget.app, context, 'External link not supported yet');
      case PostType.Html:
        return AbstractTextPlatform.platform!.htmlWidget(postModel.html!);
      case PostType.Unknown:
        return text(widget.app, context, 'Type not determined');
      case PostType.OnlyDescription:
        return Container(height: 1);
    }

    return Container(height: 1); // nothing
  }

  void _action(List<MemberMediumContainerModel> memberMedia, int index) {
    var postMedium = memberMedia[index];
    if (postMedium.memberMedium!.mediumType! == MediumType.Photo) {
      showPhotosFromPostMedia(context, memberMedia, index);
    } else {
      Registry.registry()!.getMediumApi()
          .showVideo(context, widget.app, postMedium.memberMedium!);
    }
  }

  void showPhotosFromPostMedia(
      BuildContext context, List<MemberMediumContainerModel> postMedia, int initialPage) {
    if (postMedia.length > 0) {
      var photos = postMedia.map((pm) => pm.memberMedium!).toList();
      Registry.registry()!.getMediumApi().showPhotos(context, widget.app, photos, initialPage);
    }
  }
}
