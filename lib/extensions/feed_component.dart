import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_pkg_feed/extensions/widgets/post.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_component.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/feed_repository.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/post_paged_bloc.dart';
import 'bloc/post_paged_event.dart';
import 'bloc/post_paged_state.dart';

class FeedComponentConstructorDefault implements ComponentConstructor {
  Widget createNew({String id, Map<String, Object> parameters}) {
    return FeedComponent(id: id);
  }
}

class FeedComponent extends AbstractFeedComponent {
  FeedComponent({String id}) : super(feedID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }
  
  @override
  Widget yourWidget(BuildContext context, FeedModel feedModel) {
    // if logged on: show this person's feed
    // if not logged on, show public feed only
    // Need to improve generation of list bloc so that we can support multi page (or "load more") type of entries
    // Need to support ordering
    return BlocProvider(
      create: (_) => PostPagedBloc(
        BlocProvider.of<AccessBloc>(context),
        postRepository: postRepository(appId: feedModel.appId),
      )..add(PostPagedFetched()),
      child: PostsList(),
    );
  }

  @override
  FeedRepository getFeedRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .feedRepository(AccessBloc.appId(context));
  }

  Widget post(BuildContext context, PostModel post) {
    return Post(post);
  }
}

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  PostPagedBloc _postBloc;
  AppModel _app;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostPagedBloc>(context);
    _app = AccessBloc.app(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostPagedBloc, PostPagedState>(
      builder: (context, state) {
        switch (state.status) {
          case PostPagedStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PostPagedStatus.success:
            if (state.values.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.values.length
                    ? _buttonNextPage()
                    : Post(state.values[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.values.length
                  : state.values.length + 1,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buttonNextPage() {
    return RaisedButton(
        color: RgbHelper.color(rgbo: _app.formSubmitButtonColor),
        onPressed: () {
          _postBloc.add(PostPagedFetched());
        },
        child: Text('more'));
  }
}
