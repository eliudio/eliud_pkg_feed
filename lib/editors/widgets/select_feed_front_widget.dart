import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/update_component.dart';
import 'package:eliud_core/tools/widgets/editor/select_widget.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_front_list_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_front_list_event.dart';
import 'package:eliud_pkg_feed/model/feed_front_list_state.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

Widget selectFeedFrontWidget(BuildContext context, AppModel app, FeedFrontModel? feedFront, Function (dynamic selected) selectedCallback) {
  return SelectWidget<FeedFrontModel>(
      app: app,
      currentlySelected: feedFront,
      title: 'Feed Front',
      selectTitle: 'Select feed front',
      displayItemFunction: (item) => text(app, context,
          item.documentID! + ' ' + (item.description ?? '?')),
      blocProviderProvider: () => BlocProvider<FeedFrontListBloc>(
        create: (context) => FeedFrontListBloc(
          feedFrontRepository: feedFrontRepository(appId: app.documentID!)!,
        )..add(LoadFeedFrontList()),
      ),
      blocBuilder: (contentsLoaded, contentsNotLoaded) {
        return BlocBuilder<FeedFrontListBloc, FeedFrontListState>(
            builder: (context, state) {
              if ((state is FeedFrontListLoaded) && (state.values != null)) {
                return contentsLoaded(state.values!);
              } else {
                return contentsNotLoaded();
              }
            });
      },
      addCallback: () {
        addComponent(context, app, 'feedFronts', (_){});
      },
      deleteCallback: null,
      updateCallback: (item) {
        updateComponent(context, app, 'feedFronts', item.documentID, (_) {});
      },
      selectedCallback: selectedCallback
    );
}