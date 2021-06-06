import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/model/rgb_model.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_pkg_feed/extensions/new_post/feed_post_dialog.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:eliud_pkg_feed/platform/medium_platform.dart';
import '../postlist_paged/postlist_paged_bloc.dart';
import '../postlist_paged/postlist_paged_event.dart';
import '../postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import '../post/post_widget.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagedPostsList extends StatefulWidget {
  //final String? parentPageId;
  final FeedModel feedModel;
  final MemberPublicInfoModel memberPublicInfoModel;
  //final bool allowNewPost;
  final SwitchFeedHelper switchFeedHelper;

  const PagedPostsList(
    this.feedModel,
    this.memberPublicInfoModel,
    this.switchFeedHelper, {
    Key? key,
  }) : super(key: key);

  @override
  _PagedPostsListState createState() => _PagedPostsListState();
}

class _PagedPostsListState extends State<PagedPostsList> {
  late PostListPagedBloc _postBloc;
  AppModel? _app;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostListPagedBloc>(context);
    _app = AccessBloc.app(context);
  }

  Widget _button(Widget icon, Widget text, action) {
    return MaterialButton(
        color: Colors.white,
        shape: CircleBorder(),
        onPressed: action,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: icon,
        ));
  }

  Widget _newPostForm() {
    List<Widget> widgets = [];
    widgets.add(Spacer());
    var album = Image.asset("assets/images/segoshvishna.fiverr.com/album.png",
        package: "eliud_pkg_feed");
    var article = Image.asset(
        "assets/images/segoshvishna.fiverr.com/article.png",
        package: "eliud_pkg_feed");
    var audio = Image.asset("assets/images/segoshvishna.fiverr.com/audio.png",
        package: "eliud_pkg_feed");
    var message = Image.asset(
        "assets/images/segoshvishna.fiverr.com/message.png",
        package: "eliud_pkg_feed");
    var photo = Image.asset("assets/images/segoshvishna.fiverr.com/photo.png",
        package: "eliud_pkg_feed");
    var video = Image.asset("assets/images/segoshvishna.fiverr.com/video.png",
        package: "eliud_pkg_feed");

    // Photo
    widgets.add(PostHelper.getFormattedRoundedShape(IconButton(icon: photo, onPressed: () {})));
    widgets.add(Spacer());
/*
        probably needs to go into a seperate dialog

        AbstractMediumPlatform.platform!.takePhoto(context, widget.feedModel.appId, widget.switchFeedHelper.memberCurrent.documentID, widget.switchFeedHelper.
        readAccess, photoFeedbackFunction, photoFeedbackProgress);
*/

    // Video
    widgets.add(PostHelper.getFormattedRoundedShape(IconButton(icon: video, onPressed: () {})));
    widgets.add(Spacer());

    // Message
    widgets.add(PostHelper.getFormattedRoundedShape(IconButton(icon: message, onPressed: () {})));
    widgets.add(Spacer());

    // Audio
    widgets.add(PostHelper.getFormattedRoundedShape(IconButton(icon: audio, onPressed: () {})));
    widgets.add(Spacer());

    // Album
    widgets.add(PostHelper.getFormattedRoundedShape(IconButton(icon: album, onPressed: () => FeedPostDialog.open(
        context, widget.feedModel.documentID!, widget.switchFeedHelper))));
    widgets.add(Spacer());

    // Article
    widgets.add(PostHelper.getFormattedRoundedShape(IconButton(icon: article, onPressed: () {})));
    widgets.add(Spacer());

    return Container(height: 110, child: Row(children: widgets));
//    return FeedPostForm(feedId: widget.feedModel.documentID!, switchFeedHelper: widget.switchFeedHelper, postListPagedBloc: BlocProvider.of<PostListPagedBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    var _accessState = AccessBloc.getState(context);
    return BlocBuilder<PostListPagedBloc, PostListPagedState>(
      builder: (context, state) {
        if (state is PostListPagedState) {
          var theState = state;
          List<Widget> widgets = [];
          if (widget.switchFeedHelper.allowNewPost()) {
            widgets.add(_newPostForm());
          }
          for (int i = 0; i < theState.values.length; i++) {
            widgets.add(post(context, theState.values[i]!));
          }
          widgets.add(_buttonNextPage(!theState.hasReachedMax));
          return ListView(
              shrinkWrap: true, physics: ScrollPhysics(), children: widgets);
        } else {
          return Center(
            child: DelayedCircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget simplePost(BuildContext context, PostModel postModel) {
    return TextButton(
        child: Text(postModel.documentID!),
        onPressed: () => BlocProvider.of<PostListPagedBloc>(context)
            .add(DeletePostPaged(value: postModel)));
  }

  Widget post(BuildContext context, PostDetails postDetails) {
     return PostWidget(
            switchFeedHelper: widget.switchFeedHelper, details: postDetails,
    );
  }

  Widget _buttonNextPage(bool mightHaveMore) {
    if (mightHaveMore) {
      return MyButton(
        buttonColor: _app!.formSubmitButtonColor,
        onClickFunction: _onClick,
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Divider(
                height: 5,
              );
            } else {
              return Center(
                  child: Text(
                "That's all folks",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ));
            }
          });
    }
  }

  void _onClick() {
    _postBloc.add(PostListPagedFetched());
  }
}

typedef OnClickFunction();

class MyButton extends StatefulWidget {
  final RgbModel? buttonColor;
  final OnClickFunction? onClickFunction;

  const MyButton({Key? key, this.buttonColor, this.onClickFunction})
      : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  late bool clicked;

  @override
  void initState() {
    super.initState();
    clicked = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!clicked) {
      return RaisedButton(
          color: RgbHelper.color(rgbo: widget.buttonColor),
          onPressed: () {
            setState(() {
              clicked = true;
            });
            widget.onClickFunction!();
          },
          child: Text('More...'));
    } else {
      return RaisedButton(
          color: RgbHelper.color(rgbo: widget.buttonColor),
          onPressed: () {
            setState(() {
              clicked = true;
            });
            widget.onClickFunction!();
          },
          child: Center(
              child: SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator())));
    }
  }
}
