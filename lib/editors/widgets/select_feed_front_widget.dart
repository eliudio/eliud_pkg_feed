import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core_model/model/storage_conditions_model.dart';
import 'package:eliud_core_model/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/update_component.dart';
import 'package:eliud_core_model/tools/query/query_tools.dart';
import 'package:eliud_core/tools/widgets/editor/select_widget.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_front_list_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_front_list_event.dart';
import 'package:eliud_pkg_feed/model/feed_front_list_state.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

Widget selectFeedFrontWidget(
    BuildContext context,
    AppModel app,
    StorageConditionsModel? containerStorageConditions,
    FeedFrontModel? feedFront,
    Function(dynamic selected) selectedCallback) {
  return SelectWidget<FeedFrontModel>(
      app: app,
      currentlySelected: feedFront,
      title: 'Feed Front',
      selectTitle: 'Select feed front',
      displayItemFunction: (item) =>
          text(app, context, item.documentID + ' ' + (item.description ?? '?')),
      blocProviderProvider: () => BlocProvider<FeedFrontListBloc>(
            create: (context) => FeedFrontListBloc(
              eliudQuery: getComponentSelectorQuery(0, app.documentID),
              feedFrontRepository: feedFrontRepository(appId: app.documentID)!,
            )..add(LoadFeedFrontList()),
          ),
      blocBuilder: (contentsLoaded, contentsNotLoaded) {
        return BlocBuilder<FeedFrontListBloc, FeedFrontListState>(
            builder: (context, state) {
          if ((state is FeedFrontListLoaded) && (state.values != null)) {
            return contentsLoaded(context, state.values!);
          } else {
            return contentsNotLoaded(
              context,
            );
          }
        });
      },
      addCallback: () {
        addComponent(context, app, 'feedFronts', (_, __) {});
      },
      deleteCallback: null,
      updateCallback: (item) {
        updateComponent(
            context, app, 'feedFronts', item.documentID, (_, __) {});
      },
      selectedCallback: selectedCallback,
      changePrivilegeEventCallback:
          (BuildContext newContext, int privilegeLevel) {
        BlocProvider.of<FeedFrontListBloc>(newContext).add(FeedFrontChangeQuery(
            newQuery:
                getComponentSelectorQuery(privilegeLevel, app.documentID)));
      },
      containerPrivilege: containerStorageConditions == null ||
              containerStorageConditions.privilegeLevelRequired == null
          ? 0
          : containerStorageConditions.privilegeLevelRequired!.index);
}
