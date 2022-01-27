import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/blocs/access/state/logged_in.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliud_router;
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_container_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/frontend/has_dialog_widget.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/frontend/has_text_form_field.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/member_service.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_event.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/post_privilege_widget.dart';
import 'package:eliud_pkg_feed/extensions/util/avatar_helper.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import 'bloc/feed_post_form_bloc.dart';
import 'bloc/feed_post_form_event.dart';
import 'bloc/feed_post_form_state.dart';

class MyFeedPostForm extends StatefulWidget {
  final AppModel app;
  final String feedId;
  final String memberId;
  final String? currentMemberId;
  final String photoURL;
  final eliud_router.PageContextInfo pageContextInfo;
  final bool isNew;

  MyFeedPostForm(this.app, this.feedId, this.memberId, this.currentMemberId,
      this.photoURL, this.pageContextInfo, this.isNew);

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
      return complexAckNackDialog(widget.app, context,
          title: widget.isNew ? 'New Post' : 'Update Post',
          child: _contents(context, widget.pageContextInfo, widget.app, accessState),
          onSelection: (value) {
            if (value == 0) {
              BlocProvider.of<FeedPostFormBloc>(context).add(SubmitPost());
            }
          });
    } else {
      return text(widget.app, context, 'Not logged in');
    }});
  }

  Widget _contents(BuildContext context, eliud_router.PageContextInfo pageContextInfo,
      AppModel app, AccessState theState) {
    return BlocBuilder<FeedPostFormBloc, FeedPostFormState>(
        builder: (context, state) {
          if (state is FeedPostFormLoaded) {
              _descriptionController.text =
                  state.postModelDetails.description.toString();
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
                create: (context) => PostPrivilegeBloc(widget.app, widget.feedId, widget.memberId, _postPrivilegeFeedback)..add(InitialisePostPrivilegeEvent(postAccessibleByGroup: state.postModelDetails.postAccessibleByGroup, postAccessibleByMembers: state.postModelDetails.postAccessibleByMembers)),
              child: PostPrivilegeWidget(widget.app, widget.feedId, widget.memberId, widget.currentMemberId, state.postModelDetails.memberMedia.length == 0)

              ),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rows,
            );
          } else {
            return progressIndicator(app, context);
          }
        });
  }

  void _postPrivilegeFeedback(PostAccessibleByGroup postAccessibleByGroup, List<SelectedMember>? specificSelectedMembers) {
    BlocProvider.of<FeedPostFormBloc>(context).add(
        ChangedFeedPostPrivilege(postAccessibleByGroup: postAccessibleByGroup, postAccessibleByMembers: specificSelectedMembers != null ? specificSelectedMembers.map((e) => e.memberId).toList() : null));
  }

  Widget _row1(String pageId, AppModel app, FeedPostFormInitialized state) {
    return Row(children: [
      Container(
          height: 60, width: 60, child: AvatarHelper.avatar(
        context,
        60,
        pageId,
        widget.memberId,
        widget.currentMemberId,
        app,
        widget.feedId,
      )),
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
    return MediaButtons.mediaButtons(
        context, app, memberId, () => Tuple2(toMemberMediumAccessibleByGroup(state.postModelDetails.postAccessibleByGroup.index),
        state.postModelDetails.postAccessibleByMembers),
        tooltip: 'Add video or photo',
        photoFeedbackFunction: (photo) {
          if (photo != null) {
            var memberMedia = state.postModelDetails.memberMedia;
            memberMedia.add(MemberMediumContainerModel(
                documentID: photo.documentID, memberMedium: photo));
            BlocProvider.of<FeedPostFormBloc>(context)
                .add(ChangedMedia(memberMedia: memberMedia));
          }
        },
        photoFeedbackProgress: _photoUploading,
        videoFeedbackFunction: (video) {
          if (video != null) {
            var memberMedia = state.postModelDetails.memberMedia;
            memberMedia.add(MemberMediumContainerModel(
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
    return MediaHelper.staggeredMemberMediumModel(widget.app, context, media,
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
            AbstractMediumPlatform.platform!.showPhotos(context, widget.app, photos, index);
          } else {
            AbstractMediumPlatform.platform!.showVideo(context, widget.app, medium);
          }
        });
  }

  Widget _textField(
      AppModel app,
      FeedPostFormInitialized state,
      ) {
    return textField(app,
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
