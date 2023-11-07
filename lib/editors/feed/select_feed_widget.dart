import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/widgets/editor/select_widget.dart';
import 'package:eliud_pkg_feed/editors/feed/feed_dashboard.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_list_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_list_event.dart';
import 'package:eliud_pkg_feed/model/feed_list_state.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';

Widget selectFeedWidget(
    BuildContext context,
    AppModel app,
    StorageConditionsModel? containerStorageConditions,
    FeedModel? feed,
    Function(dynamic selected) selectedCallback) {
  return SelectWidget<FeedModel>(
    app: app,
    currentlySelected: feed,
    title: 'Feed',
    selectTitle: 'Select feed',
    displayItemFunction: (item) =>
        text(app, context, item.documentID + ' ' + (item.description ?? '?')),
    blocProviderProvider: () => BlocProvider<FeedListBloc>(
      create: (context) => FeedListBloc(
        feedRepository: feedRepository(appId: app.documentID)!,
      )..add(LoadFeedList()),
    ),
    blocBuilder: (contentsLoaded, contentsNotLoaded) {
      return BlocBuilder<FeedListBloc, FeedListState>(
          builder: (context, state) {
        if ((state is FeedListLoaded) && (state.values != null)) {
          return contentsLoaded(context, state.values!);
        } else {
          return contentsNotLoaded(
            context,
          );
        }
      });
    },
    selectedCallback: selectedCallback,
    addCallback: () => FeedDashboard.addFeed(app, context),
    deleteCallback: null,
    updateCallback: (item) => FeedDashboard.updateFeed(app, context, item),
  );
}
