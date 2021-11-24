import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_button.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_widget.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:eliud_pkg_text/platform/text_platform.dart';
import 'new_post/bloc/feed_post_form_event.dart';
import 'new_post/feed_post_dialog.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagedPostsList extends StatefulWidget {
  final FeedModel feedModel;

  const PagedPostsList(
    this.feedModel, {
    Key? key,
  }) : super(key: key);

  @override
  PagedPostsListState createState() => PagedPostsListState();
}

class PagedPostsListState extends State<PagedPostsList> {
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
  }

  Widget _getIcon(Widget child) {
    return Container(
        padding: const EdgeInsets.only(top: 22.5, bottom: 22.5),
        child: actionContainer(context,
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
      required String authorId,
      List<String>? readAccess,
      List<PostMediumModel>? postMemberMedia}) {
    BlocProvider.of<PostListPagedBloc>(context).add(AddPostPaged(
        value: PostModel(
            documentID: newRandomKey(),
            authorId: authorId,
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
      MemberModel author,
      List<String> readAccess,
      LoggedInProfileInitialized profileInitialized,
      eliudrouter.PageContextInfo pageContextInfo) {
    if (profileInitialized is LoggedInWatchingMyProfile) {
      List<Widget> widgets = [];
      widgets.add(Spacer());

      // Photo
      if (widget.feedModel.photoPost!) {
        widgets.add(PostButton(
            widget.feedModel, PostType.PostPhoto, readAccess, author));
        widgets.add(Spacer());
      }

      // Video
      if (widget.feedModel.videoPost != null && widget.feedModel.videoPost!) {
        widgets.add(PostButton(
            widget.feedModel, PostType.PostVideo, readAccess, author));
        widgets.add(Spacer());
      }

      // Message
      if (widget.feedModel.messagePost != null &&
          widget.feedModel.messagePost!) {
        var message = Image.asset(
            "assets/images/segoshvishna.fiverr.com/message.png",
            package: "eliud_pkg_feed");
        widgets.add(actionContainer(context,
            child: iconButton(context, icon: message, tooltip: 'Message',
                onPressed: () {
              openEntryDialog(context, AccessBloc.currentAppId(context) + '/_message', title: 'Say something',
                  onPressed: (value) {
                if (value != null) {
                  _addPost(
                    description: value,
                    authorId: author.documentID!,
                    readAccess: readAccess,
                  );
                }
              });
            })));
        widgets.add(Spacer());
      }

      // Audio
      if (widget.feedModel.audioPost != null && widget.feedModel.audioPost!) {
        var audio = Image.asset(
            "assets/images/segoshvishna.fiverr.com/audio.png",
            package: "eliud_pkg_feed");
        widgets.add(iconButton(context,
            icon: audio, tooltip: 'Audio', onPressed: () {}));
        widgets.add(Spacer());
      }

      // Album
      if (widget.feedModel.albumPost != null && widget.feedModel.albumPost!) {
        var album = Image.asset(
            "assets/images/segoshvishna.fiverr.com/album.png",
            package: "eliud_pkg_feed");
        widgets.add(actionContainer(context,
            child: iconButton(context,
                icon: album,
                tooltip: 'Album',
                onPressed: () => FeedPostDialog.open(
                    context,
                    widget.feedModel.documentID!,
                    profileInitialized.watchingThisProfile()!.authorId!,
                    profileInitialized.memberId(),
                    profileInitialized.profileUrl(),
                    pageContextInfo,
                    InitialiseNewFeedPostFormEvent()))));
        widgets.add(Spacer());
      }

      // Article
      if (widget.feedModel.articlePost != null &&
          widget.feedModel.articlePost!) {
        widgets.add(articleButton(widget.feedModel.appId!, author.documentID!));

        widgets.add(Spacer());
      }

      return Container(height: 110, child: Row(children: widgets));
    } else {
      return Container(height: 0);
    }
  }

  Widget articleButton(String appId, String memberId) {
    var articleIcon = Image.asset(
        "assets/images/segoshvishna.fiverr.com/article.png",
        package: "eliud_pkg_feed");

    var article = PostButtonState.formatIcon(context, articleIcon);

    var items = <PopupMenuItem<int>>[];
    items.add(
      PopupMenuItem<int>(
          child: text(context, 'Publish article for public'), value: 0),
    );
    items.add(
      PopupMenuItem<int>(
          child: text(context, 'Publish article for followers'), value: 1),
    );
    items.add(
      PopupMenuItem<int>(
          child: text(context, 'Publish article for me'), value: 2),
    );
    return PopupMenuButton(
        tooltip: 'Add article',
        padding: EdgeInsets.all(0.0),
        child: article,
        itemBuilder: (_) => items,
        onSelected: (choice) async {
          var postPrivilege;
          var access;
          if (choice == 0) {
            postPrivilege = await PostPrivilege.construct1(
                PostPrivilegeType.Public, appId, memberId);
            access = 'public';
          }
          if (choice == 1) {
            postPrivilege = await PostPrivilege.construct1(
                PostPrivilegeType.Followers, appId, memberId);
            access = 'followers';
          }
          if (choice == 2) {
            postPrivilege = await PostPrivilege.construct1(
                PostPrivilegeType.Public, appId, memberId);
            access = 'just me';
          }

          AbstractTextPlatform.platform!.updateHtmlUsingMemberMedium(
              context, appId, memberId, postPrivilege.readAccess, "Article",
              (newArticle) {
            _addPost(
              html: newArticle,
              authorId: memberId,
              readAccess: postPrivilege.readAccess,
            );
          }, 'Add article for ' + access,
              extraIcons: getAlbumActionIcons(context, access));
        });
  }

  static List<Widget> getAlbumActionIcons(
      BuildContext context, String accessible) {
    return [
      dialogButton(context, label: 'Audience', onPressed: () {
        openMessageDialog(
          context, AccessBloc.currentAppId(context) + '/_accessible',
          title: 'Accessible',
          message: 'Article accessible by: ' + accessible,
        );
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
      if (accessState is AccessDetermined) {
        var pageContextInfo = eliudrouter.Router.getPageContextInfo(context);
        var pageId = pageContextInfo.pageId;
        return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
          if (profileState is ProfileInitialised) {
            var app = accessState.currentApp(context);
            return BlocBuilder<PostListPagedBloc, PostListPagedState>(
              builder: (context, state) {
                if (state is PostListPagedState) {
                  var currentMemberId = profileState.memberId();
                  var photoURL = profileState.profileUrl();
                  List<Widget> widgets = [];
                  if (profileState is LoggedInProfileInitialized) {
                    widgets.add(_newPostForm(
                        profileState.currentMember,
                        profileState.defaultReadAccess,
                        profileState,
                        pageContextInfo));
                  }
                  for (int i = 0; i < state.values.length; i++) {
                    widgets.add(PostWidget(
                      thumbStyle: widget.feedModel.thumbImage,
                      app: app,
                      feedId: widget.feedModel.documentID!,
                      details: state.values[i],
                      pageId: pageId,
                      memberId: state.values[i].postModel.authorId!,
                      currentMemberId: currentMemberId,
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
                  return progressIndicator(context);
                }
              },
            );
          } else {
            return progressIndicator(context);
          }
        });
      } else {
        return progressIndicator(context);
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
                  child: h5(
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
      return button(
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
      return progressIndicator(context);
    }
  }
}
