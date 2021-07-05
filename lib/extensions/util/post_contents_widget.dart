import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_text/platform/text_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/storage/fb_storage_image.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_pkg_feed/extensions/util/post_media_helper.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';

import 'embedded_page.dart';

class PostContentsWidget extends StatefulWidget {
  final String? memberID;
  final PostModel postModel;
  final AccessBloc? accessBloc;
  final String? parentPageId;

  const PostContentsWidget(
      {Key? key,
      this.memberID,
      required this.postModel,
      this.accessBloc,
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
    List<Tab> tabs = [];

    if (postModel.postPageId != null) {
      if (memberID != null) {
        return EmbeddedPageHelper.postDetails(
            context, memberID, postModel, accessBloc, parentPageId!);
      }
    } else if ((postModel.memberMedia != null) &&
        (postModel.memberMedia!.length > 0)) {
      if (postModel.memberMedia!.length == 1) {
        var medium = postModel.memberMedia![0];
        var width;
        if (medium.memberMedium != null) {
          if (medium.memberMedium!.mediumType == MediumType.Photo) {
            width = _width(context) * .7;
          }          return GestureDetector(
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
      } else {
        List<PostMediumModel> memberMedia = postModel.memberMedia!;
        List<Widget> widgets = [];
        // Photos & videos
        //widgets.add(PostMediaHelper.videoAndPhotoDivider(context));
        widgets.add(PostMediaHelper.staggeredMemberMediumModelFromPostMedia(
            context, memberMedia, viewAction: (index) {
          _action(memberMedia, index);
        }));
        return Column(children: widgets);
      }
    } else if (postModel.externalLink != null) {
/*
      return WebView(
        initialUrl: state.postModel.externalLink,
        javascriptMode: JavascriptMode.unrestricted,
      );
*/
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .textStyle()
          .text(context, 'External link not supported yet');
    } else if (postModel.html != null) {
      return AbstractTextPlatform.platform!.htmlWidget(postModel.html!);
    }

    return Container(height: 1); // nothing
  }

  void _action(List<PostMediumModel> memberMedia, int index) {
    var postMedium = memberMedia[index];
    if (postMedium.memberMedium!.mediumType! == MediumType.Photo) {
      showPhotosFromPostMedia(context, memberMedia, index);
    } else {
      AbstractMediumPlatform.platform!
          .showVideo(context, postMedium.memberMedium!);
    }
  }

  void showPhotosFromPostMedia(
      BuildContext context, List<PostMediumModel> postMedia, int initialPage) {
    if (postMedia.length > 0) {
      var photos = postMedia.map((pm) => pm.memberMedium!).toList();
      AbstractMediumPlatform.platform!.showPhotos(context, photos, initialPage);
    }
  }
}
