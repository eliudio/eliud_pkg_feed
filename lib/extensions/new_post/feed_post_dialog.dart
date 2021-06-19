import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/tools/widgets/dialog_helper.dart';
import 'package:eliud_pkg_feed/extensions/postlist_paged/postlist_paged_bloc.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_feed_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'bloc/feed_post_form_bloc.dart';
import 'bloc/feed_post_form_event.dart';
import 'feed_post_form.dart';

class FeedPostDialog extends StatefulWidget {
  final String feedId;
  final SwitchFeedHelper switchFeedHelper;
  final PostListPagedBloc postListPagedBloc;

  FeedPostDialog(
      {Key? key,
      required this.switchFeedHelper,
      required this.feedId,
      required this.postListPagedBloc})
      : super(key: key);

  static void open(
      BuildContext context, String feedId, SwitchFeedHelper switchFeedHelper) {
    var postListPagedBloc = BlocProvider.of<PostListPagedBloc>(context);
    DialogStatefulWidgetHelper.openIt(
        context,
        FeedPostDialog(
          feedId: feedId,
          switchFeedHelper: switchFeedHelper,
          postListPagedBloc: postListPagedBloc,
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
      if (app == null) return Text("No app available");
      return BlocProvider<FeedPostFormBloc>(
          create: (context) => FeedPostFormBloc(app.documentID!,
              postListPagedBloc, memberPublicInfoModel, widget.feedId, theState)
            ..add(InitialiseNewFeedPostFormEvent()),
          child: MyFeedPostForm(
                  widget.feedId,
                  widget.switchFeedHelper,
                  ));
    } else {
      return Text("Not logged in");
    }
  }
}
