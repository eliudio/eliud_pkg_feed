import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/storage/fb_storage_image.dart';
import 'package:eliud_core/tools/storage/medium_base.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

typedef PostMediumAction = void Function(int index);

class PostMediaHelper {
  static int POPUP_MENU_DELETE_VALUE = 0;
  static int POPUP_MENU_VIEW = 1;

  static Widget videoAndPhotoDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.black,
      indent: MediaQuery.of(context).size.width * 0.1,
      endIndent: MediaQuery.of(context).size.width * 0.1,
    );
  }

  static Widget staggeredPhotosWithThumbnail(List<PhotoWithThumbnail> photos,
      {PostMediumAction? deleteAction, PostMediumAction? viewAction}) {
    List<Widget> widgets = [];
    for (int i = 0; i < photos.length; i++) {
      var medium = photos[i];
      var image, name;
      image = Image.memory(medium.thumbNailData.data);
      name = medium.photoData.baseName;

      widgets
          .add(_getPopupMenuButton(name, image, i, deleteAction, viewAction));
    }
    return _getContainer(widgets);
  }

  static Widget staggeredVideosWithThumbnail(List<VideoWithThumbnail> videos,
      {PostMediumAction? deleteAction, PostMediumAction? viewAction}) {
    List<Widget> widgets = [];
    for (int i = 0; i < videos.length; i++) {
      var medium = videos[i];
      var image, name;
      image = Image.memory(medium.thumbNailData.data);
      name = medium.videoData.baseName;

      widgets
          .add(_getPopupMenuButton(name, image, i, deleteAction, viewAction));
    }
    return _getContainer(widgets);
  }

  static Widget staggeredMemberMediumModelFromPostMedia(List<PostMediumModel> media,
      {PostMediumAction? deleteAction, PostMediumAction? viewAction}) {
    var mmm = media.map((pm) => pm.memberMedium!).toList();
    return staggeredMemberMediumModel(mmm,
        deleteAction: deleteAction, viewAction: viewAction);
  }

  static Widget staggeredMemberMediumModel(List<MemberMediumModel> media,
      {PostMediumAction? deleteAction, PostMediumAction? viewAction, double? progressExtra, String? progressLabel}) {
    List<Widget> widgets = [];
    for (int i = 0; i < media.length; i++) {
      var medium = media[i];
      var image, name;
      image = MemberImageModelWidget(memberMediumModel: medium, showThumbnail: true,);
      name = medium.urlThumbnail!;

      widgets
          .add(_getPopupMenuButton(name, image, i, deleteAction, viewAction));
    }
    if (progressExtra != null) {
      widgets.add(Center(child:/*CircularProgressIndicator(
        value: progressExtra,
        semanticsLabel: progressLabel,
      )*/
      CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 5.0,
        percent: progressExtra,
        center: new Text("100%"),
//        progressColor: Colors.green,
      )
      ));
    }
    return _getContainer(widgets);
  }

  static Widget _getPopupMenuButton(String name, Widget image, int index,
      PostMediumAction? deleteAction, PostMediumAction? viewAction) {
    if (deleteAction == null) {
      if (viewAction == null) {
        return image;
      } else {
        return GestureDetector(
            onTap: () {
              viewAction(index);
            },
            child: image);
      }
    } else {
      List<PopupMenuItem<int>> menuItems = [];
      if (viewAction != null) {
        menuItems.add(new PopupMenuItem<int>(
            child: const Text('View'), value: POPUP_MENU_VIEW));
      }
      menuItems.add(new PopupMenuItem<int>(
          child: const Text('Delete'), value: POPUP_MENU_DELETE_VALUE));

      return PopupMenuButton(
          color: Colors.red,
          tooltip: name,
          child: image,
          itemBuilder: (_) => menuItems,
          onSelected: (choice) {
            if (choice == POPUP_MENU_DELETE_VALUE) {
              deleteAction(index);
            }
            if ((choice == POPUP_MENU_VIEW) && (viewAction != null)) {
              viewAction(index);
            }
          });
    }
  }

  static Widget _getContainer(List<Widget> widgets) {
    return Container(
        height: 200,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: SliverGrid.extent(
                  maxCrossAxisExtent: 200,
                  children: widgets,
                  mainAxisSpacing: 10),
            ),
          ],
        ));
  }
}
