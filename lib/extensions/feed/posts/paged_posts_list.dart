import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_button.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_widget.dart';
import 'new_post/feed_post_dialog.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_text/extensions/rich_text_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PagedPostsList extends StatefulWidget {
  final FeedModel feedModel;

  const PagedPostsList(
    this.feedModel, {
    Key? key,
  }) : super(key: key);

  @override
  _PagedPostsListState createState() => _PagedPostsListState();
}

class _PagedPostsListState extends State<PagedPostsList> {
  late PostListPagedBloc _postBloc;
  double? photoUploadingProgress;
  double? videoUploadingProgress;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostListPagedBloc>(context);
  }

  void _videoUploading(double progress) {
    setState(_) {
      videoUploadingProgress = progress;
    }

    ;
  }

  Widget _getIcon(Widget child) {
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
                        width: 45,
                        height: 40,
                        child: child))));
  }

  void _addPost(
      {String? html,
      String? description,
      MemberPublicInfoModel? author,
      List<String>? readAccess,
      List<PostMediumModel>? postMemberMedia}) {
    BlocProvider.of<PostListPagedBloc>(context).add(AddPostPaged(
        value: PostModel(
            documentID: newRandomKey(),
            author: author,
            appId: widget.feedModel.appId!,
            feedId: widget.feedModel.documentID!,
            likes: 0,
            dislikes: 0,
            description: description,
            readAccess: readAccess,
            archived: PostArchiveStatus.Active,
            html: html,
            memberMedia: postMemberMedia)));
  }

  Widget _newPostForm(
    MemberPublicInfoModel author,
    List<String> readAccess,
      LoggedInProfileInitialized profileInitialized,
      PageContextInfo pageContextInfo
  ) {
    List<Widget> widgets = [];
    widgets.add(Spacer());

    // Photo
    if (widget.feedModel.photoPost!) {
      widgets.add(
          PostButton(widget.feedModel, PostType.PostPhoto, readAccess, author));
      widgets.add(Spacer());
    }

    // Video
    if (widget.feedModel.videoPost != null && widget.feedModel.videoPost!) {
      widgets.add(
          PostButton(widget.feedModel, PostType.PostVideo, readAccess, author));
      widgets.add(Spacer());
    }

    // Message
    if (widget.feedModel.messagePost != null && widget.feedModel.messagePost!) {
      var message = Image.asset(
          "assets/images/segoshvishna.fiverr.com/message.png",
          package: "eliud_pkg_feed");
      widgets.add(StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .buttonStyle()
          .iconButton(context, icon: message, tooltip: 'Message',
              onPressed: () {
        StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .dialogStyle()
            .openEntryDialog(context, title: 'Same something',
                onPressed: (value) {
          if (value != null) {
            _addPost(description: value);
          }
        });
      }));
      widgets.add(Spacer());
    }

    // Audio
    if (widget.feedModel.audioPost != null && widget.feedModel.audioPost!) {
      var audio = Image.asset("assets/images/segoshvishna.fiverr.com/audio.png",
          package: "eliud_pkg_feed");
      widgets.add(StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .buttonStyle()
          .iconButton(context,
              icon: audio, tooltip: 'Audio', onPressed: () {}));
      widgets.add(Spacer());
    }

    // Album
    if (widget.feedModel.albumPost != null && widget.feedModel.albumPost!) {
      var album = Image.asset("assets/images/segoshvishna.fiverr.com/album.png",
          package: "eliud_pkg_feed");
      widgets.add(StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .buttonStyle()
          .iconButton(context,
              icon: album,
              tooltip: 'Album',
              onPressed: () =>
                  FeedPostDialog.open(context, widget.feedModel.documentID!, profileInitialized.watchingThisProfile()!.author!.documentID!, profileInitialized.profileUrl(), pageContextInfo)));
      widgets.add(Spacer());
    }

    // Article
    if (widget.feedModel.articlePost != null && widget.feedModel.articlePost!) {
      var article = Image.asset(
          "assets/images/segoshvishna.fiverr.com/article.png",
          package: "eliud_pkg_feed");
      widgets.add(StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .buttonStyle()
          .iconButton(context, icon: article, tooltip: 'Article',
              onPressed: () {
        RichTextDialog.open(context, widget.feedModel.appId!,
            author.documentID!, readAccess, "Article", (newArticle) {
          _addPost(html: newArticle);
        }, 'Add article');
      }));
      widgets.add(Spacer());
    }

    return Container(height: 110, child: Row(children: widgets));
  }

  @override
  Widget build(BuildContext context) {
    var pageContextInfo = PageParamHelper.getPagaContextInfo(context);
    var pageId = pageContextInfo.pageId;
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileState) {
      if (profileState is ProfileInitialised) {
        var appId = profileState.appId;
        return BlocBuilder<PostListPagedBloc, PostListPagedState>(
          builder: (context, state) {
            if (state is PostListPagedState) {
              var memberId = profileState.memberId();
              var photoURL = profileState.profileUrl();
              List<Widget> widgets = [];
              if (profileState is LoggedInProfileInitialized) {
                widgets.add(_newPostForm(profileState.currentPublicMemberInfo,
                    profileState.defaultReadAccess, profileState, pageContextInfo));
              }
              for (int i = 0; i < state.values.length; i++) {
                widgets.add(PostWidget(
                  thumbStyle: widget.feedModel.thumbImage,
                  appId: appId,
                  feedId: widget.feedModel.documentID!,
                  details: state.values[i],
                  pageId: pageId,
                  memberId: memberId,
                  isEditable: profileState.canEditThisProfile(),
                  photoURL: photoURL,
                ));
              }
              widgets.add(_buttonNextPage(!state.hasReachedMax));
              return ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: widgets);
            } else {
              return StyleRegistry.registry()
                  .styleWithContext(context)
                  .frontEndStyle()
                  .progressIndicatorStyle()
                  .progressIndicator(context);
            }
          },
        );
      } else {
        return StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .progressIndicatorStyle()
            .progressIndicator(context);
      }
    });
  }

  Widget _buttonNextPage(bool mightHaveMore) {
    if (mightHaveMore) {
      return MyButton(
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
                  child: StyleRegistry.registry()
                      .styleWithContext(context)
                      .frontEndStyle()
                      .textStyle()
                      .h5(
                        context,
                        "That's all folks",
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
  //final RgbModel? buttonColor;
  final OnClickFunction? onClickFunction;

  const MyButton({Key? key, /*this.buttonColor, */ this.onClickFunction})
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
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .buttonStyle()
          .button(
        context,
        label: 'More...',
        onPressed: () {
          setState(() {
            clicked = true;
          });
          widget.onClickFunction!();
        },
      );
    } else {
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .progressIndicatorStyle()
          .progressIndicator(context);
    }
  }
}