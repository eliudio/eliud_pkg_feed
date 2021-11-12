import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/blocs/access/state/logged_in.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/frontend/has_dialog_widget.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/frontend/has_text_form_field.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_event.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/post_privilege_widget.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';
import 'package:eliud_pkg_feed/extensions/util/post_media_helper.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/feed_post_form_bloc.dart';
import 'bloc/feed_post_form_event.dart';
import 'bloc/feed_post_form_state.dart';

class MyFeedPostForm extends StatefulWidget {
  final String appId;
  final String feedId;
  final String memberId;
  final String? currentMemberId;
  final String photoURL;
  final PageContextInfo pageContextInfo;

  MyFeedPostForm(this.appId, this.feedId, this.memberId, this.currentMemberId,
      this.photoURL, this.pageContextInfo);

  _MyFeedPostFormState createState() => _MyFeedPostFormState();
}

class _MyFeedPostFormState extends State<MyFeedPostForm> {
  final TextEditingController _descriptionController = TextEditingController();

  _MyFeedPostFormState();

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(_onDescriptionChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
    builder: (context, accessState) {
    if (accessState is LoggedIn) {
      var app = accessState.currentApp;
      return complexAckNackDialog(context,
          title: 'New Album',
          child: _contents(context, widget.pageContextInfo, app, accessState),
          onSelection: (value) {
            if (value == 0) {
              BlocProvider.of<FeedPostFormBloc>(context).add(SubmitPost());
            }
          });
    } else {
      return text(context, 'Not logged in');
    }});
  }

  Widget _contents(BuildContext context, PageContextInfo pageContextInfo,
      AppModel app, AccessState theState) {
    return BlocBuilder<FeedPostFormBloc, FeedPostFormState>(
        builder: (context, state) {
          if (state is FeedPostFormLoaded) {
            if (state.postModelDetails.description != null) {
              _descriptionController.text =
                  state.postModelDetails.description.toString();
            } else {
              _descriptionController.text = "";
            }

          }
          if (state is FeedPostFormInitialized) {
            List<Widget> rows = [];
            rows.add(_row1(pageContextInfo.pageId, app, state));
            if ((state is SubmittableFeedPostFormWithMediumUploading) ||
                ((state.postModelDetails.memberMedia != null) &&
                    (state.postModelDetails.memberMedia.isNotEmpty))) {
              rows.add(_row2(context, state));
              rows.add(MediaHelper.videoAndPhotoDivider(context));
            }

            rows.add(BlocProvider<PostPrivilegeBloc>(
                create: (context) => PostPrivilegeBloc(widget.appId, widget.feedId, widget.memberId, _postPrivilegeChanged)..add(InitialisePostPrivilegeEvent(postPrivilege: state.postModelDetails.postPrivilege)),
              child: PostPrivilegeWidget(
              widget.appId, widget.feedId, widget.memberId, widget.currentMemberId, state.postModelDetails.memberMedia.length == 0)

              ),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rows,
            );
          } else {
            return progressIndicator(context);
          }
        });
  }

  void _postPrivilegeChanged(PostPrivilege postPrivilege) {
    BlocProvider.of<FeedPostFormBloc>(context).add(
        ChangedFeedPostPrivilege(postPrivilege: postPrivilege));
  }

  Widget _row1(String pageId, AppModel app, FeedPostFormInitialized state) {
    var avatar = AvatarHelper.avatar(
      context,
      60,
      pageId,
      widget.memberId,
      widget.currentMemberId,
      app.documentID!,
      widget.feedId,
    );
    return Row(children: [
      Container(
          height: 60, width: 60, child: avatar == null ? Container() : avatar),
      Container(width: 8),
      Flexible(
        child: Container(
            alignment: Alignment.center,
            height: 30,
            child: _textField(app, state)),
      ),
      Container(width: 8),
      _mediaButtons(context, app, state, widget.memberId),
    ]);
  }

  void _photoUploading(double? progress) {
    if (progress != null) {
      BlocProvider.of<FeedPostFormBloc>(context)
          .add(UploadingMedium(progress: progress));
    }
    setState(() {});
  }

  void _videoUploading(double? progress) {
    if (progress != null) {
      BlocProvider.of<FeedPostFormBloc>(context)
          .add(UploadingMedium(progress: progress));
    }
    setState(() {});
  }

  PopupMenuButton _mediaButtons(BuildContext context, AppModel app,
      FeedPostFormInitialized state, String memberId) {
    List<String> readAccess = state.postModelDetails.postPrivilege.readAccess;

    return MediaButtons.mediaButtons(
        context, app.documentID!, memberId, readAccess,
        tooltip: 'Add video or photo',
        photoFeedbackFunction: (photo) {
          if (photo != null) {
            var memberMedia = state.postModelDetails.memberMedia;
            memberMedia.add(PostMediumModel(
                documentID: photo.documentID, memberMedium: photo));
            BlocProvider.of<FeedPostFormBloc>(context)
                .add(ChangedMedia(memberMedia: memberMedia));
          }
        },
        photoFeedbackProgress: _photoUploading,
        videoFeedbackFunction: (video) {
          if (video != null) {
            var memberMedia = state.postModelDetails.memberMedia;
            memberMedia.add(PostMediumModel(
                documentID: video.documentID, memberMedium: video));
            BlocProvider.of<FeedPostFormBloc>(context)
                .add(ChangedMedia(memberMedia: memberMedia));
          }
        },
        videoFeedbackProgress: _videoUploading);
  }

  Widget _row2(BuildContext context, FeedPostFormInitialized state) {
    double? progressValue;
    if (state is SubmittableFeedPostFormWithMediumUploading) {
      progressValue = state.progress;
    }
    var media = <MemberMediumModel>[];
    state.postModelDetails.memberMedia.forEach((medium) {
      if (medium.memberMedium != null) {
        media.add(medium.memberMedium!);
      }
    });
    return MediaHelper.staggeredMemberMediumModel(context, media,
        progressLabel: 'Uploading...',
        progressExtra: progressValue, deleteAction: (index) {
          var memberMedia = state.postModelDetails.memberMedia;
          memberMedia.removeAt(index);
          BlocProvider.of<FeedPostFormBloc>(context)
              .add(ChangedMedia(memberMedia: memberMedia));
        }, viewAction: (index) {
          var medium = media[index];
          if (medium.mediumType == MediumType.Photo) {
            var photos = media;
            AbstractMediumPlatform.platform!.showPhotos(context, photos, index);
          } else {
            AbstractMediumPlatform.platform!.showVideo(context, medium);
          }
        });
  }

  Widget _textField(
      AppModel app,
      FeedPostFormInitialized state,
      ) {
    return textField(
      context,
      readOnly: false,
      textAlign: TextAlign.left,
      textInputAction: TextInputAction.send,
      controller: _descriptionController,
      keyboardType: TextInputType.text,
      hintText: 'Say something...',
      validator: (_) {
        return state is DescriptionFeedPostFormError ? state.message : null;
      },
    );
  }

  void _onDescriptionChanged() {
    BlocProvider.of<FeedPostFormBloc>(context)
        .add(ChangedFeedPostDescription(value: _descriptionController.text));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
