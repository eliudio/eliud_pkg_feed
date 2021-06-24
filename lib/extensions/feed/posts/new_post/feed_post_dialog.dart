import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/default_style/frontend/impl/dialog/dialog_helper.dart';
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
  final String photoURL;
  final PageContextInfo pageContextInfo;

  FeedPostDialog(
      {Key? key,
      required this.feedId,
      required this.postListPagedBloc,
      required this.memberId,
      required this.photoURL, required this.pageContextInfo,
      })
      : super(key: key);

  static void open(
      BuildContext context, String feedId, String memberId, String photoURL, PageContextInfo pageContextInfo) {
    var postListPagedBloc = BlocProvider.of<PostListPagedBloc>(context);
        StyleRegistry.registry().styleWithContext(context).frontEndStyle().dialogStyle().openWidgetDialog(
        context,
        child: FeedPostDialog(
          feedId: feedId,
          postListPagedBloc: postListPagedBloc,
          memberId: memberId,
          photoURL: photoURL, pageContextInfo: pageContextInfo,
        ));
  }

  @override
  _FeedPostDialogState createState() => _FeedPostDialogState(postListPagedBloc);
}

class _FeedPostDialogState extends State<FeedPostDialog> {
  final PostListPagedBloc postListPagedBloc;

  _FeedPostDialogState(this.postListPagedBloc);

  @override
  Widget build(BuildContext context) {
    var theState = AccessBloc.getState(context);
    if (theState is LoggedIn) {
      var memberPublicInfoModel = theState.memberPublicInfoModel;
      var app = AccessBloc.app(context);
      if (app == null) return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'No app available');
      return BlocProvider<FeedPostFormBloc>(
          create: (context) => FeedPostFormBloc(app.documentID!,
              postListPagedBloc, memberPublicInfoModel, widget.feedId, theState)
            ..add(InitialiseNewFeedPostFormEvent()),
          child: MyFeedPostForm(
                  widget.feedId,
            widget.memberId,
            widget.photoURL,
            widget.pageContextInfo,
                  ));
    } else {
      return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'Not logged in');
    }
  }
}
