import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/blocs/access/state/logged_in.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliud_router;
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'bloc/feed_post_form_bloc.dart';
import 'bloc/feed_post_form_event.dart';
import 'feed_post_form.dart';

class FeedPostDialog extends StatefulWidget {
  final String feedId;
  final PostListPagedBloc postListPagedBloc;
  final String memberId;
  final String? currentMemberId;
  final String photoURL;
  final eliud_router.PageContextInfo pageContextInfo;
  final FeedPostFormEvent initialiseEvent;

  FeedPostDialog(
      {Key? key,
      required this.feedId,
      required this.postListPagedBloc,
      required this.memberId,
      required this.currentMemberId,
      required this.photoURL,
      required this.pageContextInfo,
      required this.initialiseEvent})
      : super(key: key);

  static void open(
      BuildContext context,
      String feedId,
      String memberId,
      String? currentMemberId,
      String photoURL,
      eliud_router.PageContextInfo pageContextInfo,
      FeedPostFormEvent initialiseEvent) {
    var postListPagedBloc = BlocProvider.of<PostListPagedBloc>(context);
    openWidgetDialog(context,
        child: FeedPostDialog(
            feedId: feedId,
            postListPagedBloc: postListPagedBloc,
            memberId: memberId,
            currentMemberId: currentMemberId,
            photoURL: photoURL,
            pageContextInfo: pageContextInfo,
            initialiseEvent: initialiseEvent));
  }

  @override
  _FeedPostDialogState createState() => _FeedPostDialogState(postListPagedBloc);
}

class _FeedPostDialogState extends State<FeedPostDialog> {
  final PostListPagedBloc postListPagedBloc;

  _FeedPostDialogState(this.postListPagedBloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
      if (accessState is LoggedIn) {
        var app = accessState.currentApp(context);
        if (app == null)
          return StyleRegistry.registry()
              .styleWithContext(context)
              .frontEndStyle()
              .textStyle()
              .text(context, 'No app available');
        return BlocProvider<FeedPostFormBloc>(
            create: (context) => FeedPostFormBloc(
                app.documentID!,
                postListPagedBloc,
                accessState.member.documentID!,
                widget.feedId,
                accessState)
              ..add(widget.initialiseEvent),
            child: MyFeedPostForm(
              accessState.currentAppId(context),
              widget.feedId,
              widget.memberId,
              widget.currentMemberId,
              widget.photoURL,
              widget.pageContextInfo,
            ));
      } else {
        return StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle()
            .text(context, 'Not logged in');
      }
    });
  }
}
