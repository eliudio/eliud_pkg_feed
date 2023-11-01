import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'package:eliud_pkg_text/platform/widgets/html_text_dialog.dart';
import 'package:tuple/tuple.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_container_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_button.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_privilege/post_privilege_dialog.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/posts/post_widget.dart';
import 'package:eliud_pkg_feed/extensions/util/access_group_helper.dart';
import 'package:eliud_pkg_text/platform/text_platform.dart';
import '../../../tools/row_widget_builder.dart';
import '../../with_medium/post_medium_components.dart';
import 'new_post/bloc/feed_post_form_event.dart';
import 'new_post/feed_post_dialog.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagedPostsList extends StatefulWidget {
  final FeedFrontModel feedFrontModel;
  final AppModel app;
  final BackgroundModel? backgroundOverride;

  const PagedPostsList(
    this.app,
    this.feedFrontModel, {
    Key? key,
    required this.backgroundOverride,
  }) : super(key: key);

  @override
  PagedPostsListState createState() => PagedPostsListState();
}

class PagedPostsListState extends State<PagedPostsList> {
  static double BUTTONSIZE = 40;
  late PostListPagedBloc _postBloc;
  double? photoUploadingProgress;
  double? videoUploadingProgress;
  late PostAccessibleByGroup currentPostAccessibleByGroup;
  List<String>? currentPostAccessibleByMembers;

  @override
  void initState() {
    super.initState();
    currentPostAccessibleByGroup = PostAccessibleByGroup.Public;
    currentPostAccessibleByMembers = [];
    _postBloc = BlocProvider.of<PostListPagedBloc>(context);
  }

  void _videoUploading(double progress) {
    setState(_) {
      videoUploadingProgress = progress;
    }
  }

  void _addPost(
      {String? html,
      String? description,
      required String authorId,
      required PostAccessibleByGroup postAccessibleByGroup,
      List<String>? postAccessibleByMembers,
      List<MemberMediumContainerModel>? postMemberMedia}) {
    BlocProvider.of<PostListPagedBloc>(context).add(AddPostPaged(
        value: PostModel(
      documentID: newRandomKey(),
      authorId: authorId,
      appId: widget.feedFrontModel.appId,
      feedId: widget.feedFrontModel.feed!.documentID,
      likes: 0,
      dislikes: 0,
      description: description,
      accessibleByGroup: postAccessibleByGroup,
      accessibleByMembers: postAccessibleByMembers,
      archived: PostArchiveStatus.Active,
      html: html,
      memberMedia: postMemberMedia,
      readAccess: [
        authorId
      ], // default readAccess to the owner. The function will expand this based on accessibleByGroup/Members
    )));
  }

  Tuple2<PostAccessibleByGroup, List<String>?> _retrievePostAccessibile() {
    return Tuple2(currentPostAccessibleByGroup, currentPostAccessibleByMembers);
  }

  Widget _newPostForm(
      MemberModel author,
      LoggedInProfileInitialized profileInitialized,
      eliudrouter.PageContextInfo pageContextInfo) {
    if (profileInitialized is LoggedInWatchingMyProfile) {
      var rwb = RowWidgetBuilder(rowHeight: 100, rowSpace: 10, widgetHeight: 70, widgetWidth: 100, minSpace: 10);

      List<Widget> widgets = [];
      widgets.add(Spacer());

      // Photo
      if (widget.feedFrontModel.feed!.photoPost!) {
        rwb.add(PostButton(widget.app, widget.feedFrontModel.feed!,
                PostType.PostPhoto, _retrievePostAccessibile, author));
      }

      // Video
      if (widget.feedFrontModel.feed!.videoPost != null &&
          widget.feedFrontModel.feed!.videoPost!) {
        rwb.add(PostButton(widget.app, widget.feedFrontModel.feed!,
                PostType.PostVideo, _retrievePostAccessibile, author));
      }

      // Message
      if (widget.feedFrontModel.feed!.messagePost != null &&
          widget.feedFrontModel.feed!.messagePost!) {
        var message = Image.asset(
            "assets/images/segoshvishna.fiverr.com/message.png",
            package: "eliud_pkg_feed");
        rwb.add(actionContainer(widget.app, context,
                child: iconButton(widget.app, context,
                    icon: message, tooltip: 'Message', onPressed: () {
                  openEntryDialog(
                      widget.app, context, widget.app.documentID + '/_message',
                      title: 'Say something', onPressed: (value) {
                    if (value != null) {
                      _addPost(
                          description: value,
                          authorId: author.documentID,
                          postAccessibleByGroup: currentPostAccessibleByGroup,
                          postAccessibleByMembers:
                              currentPostAccessibleByMembers);
                    }
                  });
                })));
      }

      // Audio
      if (widget.feedFrontModel.feed!.audioPost != null &&
          widget.feedFrontModel.feed!.audioPost!) {
        var audio = Image.asset(
            "assets/images/segoshvishna.fiverr.com/audio.png",
            package: "eliud_pkg_feed");
        rwb.add(iconButton(widget.app, context,
                icon: audio, tooltip: 'Audio', onPressed: () {}));
      }

      // Album
      if (widget.feedFrontModel.feed!.albumPost != null &&
          widget.feedFrontModel.feed!.albumPost!) {
        var album = Image.asset(
            "assets/images/segoshvishna.fiverr.com/album.png",
            package: "eliud_pkg_feed");
        rwb.add(actionContainer(widget.app, context,
                child: iconButton(widget.app, context,
                    icon: album,
                    tooltip: 'Album',
                    onPressed: () => FeedPostDialog.open(
                        widget.app,
                        context,
                        widget.feedFrontModel.feed!.documentID,
                        profileInitialized.watchingThisProfile()!.authorId!,
                        profileInitialized.memberId(),
                        profileInitialized.profileUrl(),
                        pageContextInfo,
                        InitialiseNewFeedPostFormEvent(
                            currentPostAccessibleByGroup,
                            currentPostAccessibleByMembers)))));
      }

      // Article
      if (widget.feedFrontModel.feed!.articlePost != null &&
          widget.feedFrontModel.feed!.articlePost!) {
        var articleIcon = Image.asset(
            "assets/images/segoshvishna.fiverr.com/article.png",
            package: "eliud_pkg_feed");

        rwb.add(actionContainer(widget.app, context,
                child: iconButton(widget.app, context,
                    icon: articleIcon, tooltip: 'Article', onPressed: () {
                  List<MemberMediumContainerModel> postMediumModels = [];
                  AbstractTextPlatform.platform!
                      .updateHtmlWithMemberMediumCallback(
                          context,
                          widget.app,
                          author.documentID,
                          (newArticle) {
                            _addPost(
                                html: newArticle,
                                authorId: author.documentID,
                                postAccessibleByGroup:
                                    currentPostAccessibleByGroup,
                                postAccessibleByMembers:
                                    currentPostAccessibleByMembers,
                                postMemberMedia: postMediumModels);
                          },
                          (AddMediaHtml addMediaHtml, String html) async {
                            // the PostWithMemberMediumComponents uses (unfortunately) a PostModel, so we create one, just to be able to function, and to capturethe postMediumModels
                            var tempModel = PostModel(documentID: newRandomKey(), authorId: author.documentID, appId: widget.app.documentID, html: html, memberMedia: postMediumModels,
                              accessibleByGroup: currentPostAccessibleByGroup,
                              accessibleByMembers: currentPostAccessibleByMembers,
                            );
                            await PostWithMemberMediumComponents.openIt(
                                widget.app, context, tempModel,
                                (accepted, model) {
                              if (accepted) {
                                postMediumModels = model.memberMedia;
                              }
                            }, addMediaHtml: addMediaHtml);
                          },
                          "Article",
                          'Add article for ' +
                              AccessGroupHelper.nameForPostAccessibleByGroup(
                                  currentPostAccessibleByGroup),
                          extraIcons: getAlbumActionIcons(
                              widget.app,
                              context,
                              AccessGroupHelper.nameForPostAccessibleByGroup(
                                  currentPostAccessibleByGroup)),
                          accessibleByMembers: currentPostAccessibleByMembers);
                })));
      }

      var accessIcon = Image.asset(
          "assets/images/icons8.com/icons8-eye-100.png",
          package: "eliud_pkg_feed");
      rwb.add(actionContainer(widget.app, context,
              child: iconButton(widget.app, context,
                  icon: accessIcon, tooltip: 'Visibility', onPressed: () {
                PostPrivilegeDialog.openIt(
                    widget.app,
                    context,
                    'Visibility',
                    widget.feedFrontModel.feed!.documentID,
                    author.documentID,
                    author.documentID,
                    currentPostAccessibleByGroup,
                    currentPostAccessibleByMembers,
                    (postAccessibleByGroup, postAccessibleByMembers) {
                  currentPostAccessibleByGroup = postAccessibleByGroup;
                  currentPostAccessibleByMembers = postAccessibleByMembers;
                });
              })));

      return rwb.constructWidgets(context);
    } else {
      return Container(height: 0);
    }
  }


  static List<Widget> getAlbumActionIcons(
      AppModel app, BuildContext context, String accessible) {
    return [
      dialogButton(app, context, label: 'Audience', onPressed: () {
        openMessageDialog(
          app,
          context,
          app.documentID + '/_accessible',
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
            return BlocBuilder<PostListPagedBloc, PostListPagedState>(
              builder: (context, state) {
                if (state is PostListPagedState) {
                  var currentMemberId = profileState.memberId();
                  var photoURL = profileState.profileUrl()??
                      (profileState.app.anonymousProfilePhoto != null
                          ? profileState.app.anonymousProfilePhoto!.url
                          : null);
                  List<Widget> widgets = [];
                  if (profileState is LoggedInProfileInitialized) {
                    widgets.add(_newPostForm(profileState.currentMember,
                        profileState, pageContextInfo));
                  }
                  for (int i = 0; i < state.values.length; i++) {
                    widgets.add(PostWidget(
                      backgroundOverride: widget.backgroundOverride,
                      thumbStyle: widget.feedFrontModel.feed!.thumbImage,
                      app: widget.app,
                      feedId: widget.feedFrontModel.feed!.documentID,
                      details: state.values[i],
                      pageId: pageId,
                      memberId: state.values[i].postModel.authorId,
                      currentMemberId: currentMemberId,
                      isEditable: profileState.canEditThisProfile(),
                      photoURL: photoURL,
                      canBlock: state.canBlock,
                    ));
                  }
                  widgets.add(_buttonNextPage(!state.hasReachedMax));
                  return ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: widgets);
                } else {
                  return progressIndicator(widget.app, context);
                }
              },
            );
          } else {
            return progressIndicator(widget.app, context);
          }
        });
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }

  Widget _buttonNextPage(bool mightHaveMore) {
    if (mightHaveMore) {
      return MyButton(
        app: widget.app,
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
                widget.app,
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
  final AppModel app;
  //final RgbModel? buttonColor;
  final OnClickFunction? onClickFunction;

  const MyButton(
      {Key? key,
      required this.app,
      /*this.buttonColor, */ this.onClickFunction})
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
        widget.app,
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
      return progressIndicator(widget.app, context);
    }
  }
}
