import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core/decoration/decorations.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/feed_front.dart';
import 'package:eliud_pkg_feed/extensions/header/header.dart';
import 'package:eliud_pkg_feed/extensions/profile/profile.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/core/tools/page_helper.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_tabs.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_member.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorful_tab/flutter_colorful_tab.dart';

import '../feed_front_component.dart';

class TabbedFeedMenuItems extends StatefulWidget {
  final AppModel app;
  final FeedFrontModel feedFrontModel;
  final Map<String, dynamic>? parameters;
  List<LabelledBodyComponentModel> bodyComponents;

  TabbedFeedMenuItems(this.app, this.bodyComponents, this.parameters, this.feedFrontModel);

  _TabbedFeedMenuItemsState createState() => _TabbedFeedMenuItemsState();
}

class _TabbedFeedMenuItemsState extends State<TabbedFeedMenuItems>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> newLabels = [];

  _TabbedFeedMenuItemsState();

  @override
  void initState() {
    newLabels.add("Feed");
    newLabels.add("Profile");
    var labels = widget.bodyComponents.map((e) => e.label!).toList();
    newLabels.addAll(labels);
    var size = newLabels.length;
    _tabController = TabController(vsync: this, length: size);
    _tabController.addListener(_handleTabSelection);
    _tabController.index = 0;

    super.initState();
  }

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          tabBar(widget.app, context,
              items: newLabels, tabController: _tabController),
          component(),
        ]);
  }

  Widget component() {
    if (_tabController.index == 0) return FeedFront(widget.app, widget.feedFrontModel);
    if (_tabController.index == 1) return Profile(app: widget.app, backgroundOverride: widget.feedFrontModel.backgroundOverrideProfile);
    var component = widget.bodyComponents[_tabController.index - 2];
    return Registry.registry()!.component(
        context,
        widget.app,
        component.componentName!,
        component.componentId!,
        parameters: widget.parameters);
  }

  void _handleTabSelection() {
    if ((_tabController != null) && (_tabController.indexIsChanging)) {
      setState(() {});
    }
  }
}