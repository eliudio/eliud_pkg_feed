import 'package:eliud_core/access/access_bloc.dart';
import 'package:eliud_core/access/state/access_state.dart';
import 'package:eliud_core/access/state/logged_in.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliud_router;
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_dialog.dart';
import 'package:eliud_core_main/apis/style/style_registry.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/postlist_paged/postlist_paged_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/feed_post_form_bloc.dart';
import 'bloc/feed_post_form_event.dart';
import 'feed_post_form.dart';

class FeedPostDialog extends StatefulWidget {
  final AppModel app;
  final String feedId;
  final PostListPagedBloc postListPagedBloc;
  final String memberId;
  final String? currentMemberId;
  final String? photoURL;
  final eliud_router.PageContextInfo pageContextInfo;
  final FeedPostFormEvent initialiseEvent;

  FeedPostDialog(
      {super.key,
      required this.app,
      required this.feedId,
      required this.postListPagedBloc,
      required this.memberId,
      required this.currentMemberId,
      required this.photoURL,
      required this.pageContextInfo,
      required this.initialiseEvent});

  static void open(
      AppModel app,
      BuildContext context,
      String feedId,
      String memberId,
      String? currentMemberId,
      String? photoURL,
      eliud_router.PageContextInfo pageContextInfo,
      FeedPostFormEvent initialiseEvent) {
    var postListPagedBloc = BlocProvider.of<PostListPagedBloc>(context);
    openWidgetDialog(app, context, '${app.documentID}/_feed',
        child: FeedPostDialog(
            app: app,
            feedId: feedId,
            postListPagedBloc: postListPagedBloc,
            memberId: memberId,
            currentMemberId: currentMemberId,
            photoURL: photoURL,
            pageContextInfo: pageContextInfo,
            initialiseEvent: initialiseEvent));
  }

  @override
  State<FeedPostDialog> createState() =>
      _FeedPostDialogState(postListPagedBloc);
}

class _FeedPostDialogState extends State<FeedPostDialog> {
  final PostListPagedBloc postListPagedBloc;

  _FeedPostDialogState(this.postListPagedBloc);

  @override
  Widget build(BuildContext context) {
    var app = widget.app;
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
      if (accessState is LoggedIn) {
        return BlocProvider<FeedPostFormBloc>(
            create: (context) => FeedPostFormBloc(app, postListPagedBloc,
                accessState.member.documentID, widget.feedId, accessState)
              ..add(widget.initialiseEvent),
            child: MyFeedPostForm(
                app,
                widget.feedId,
                widget.memberId,
                widget.currentMemberId,
                widget.photoURL,
                widget.pageContextInfo,
                widget.initialiseEvent is InitialiseNewFeedPostFormEvent));
      } else {
        return StyleRegistry.registry()
            .styleWithApp(app)
            .frontEndStyle()
            .textStyle()
            .text(app, context, 'Not logged in');
      }
    });
  }
}
