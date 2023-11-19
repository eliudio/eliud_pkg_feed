import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_pkg_feed/extensions/feed_front/feed_front.dart';
import 'package:eliud_pkg_feed/extensions/profile/profile.dart';
import 'package:eliud_pkg_feed/model/feed_front_model.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_model.dart';
import 'package:eliud_core_model/style/frontend/has_tabs.dart';
import 'package:flutter/material.dart';

class TabbedFeedMenuItems extends StatefulWidget {
  final AppModel app;
  final FeedFrontModel feedFrontModel;
  final Map<String, dynamic>? parameters;
  final List<LabelledBodyComponentModel> bodyComponents;

  TabbedFeedMenuItems(
      this.app, this.bodyComponents, this.parameters, this.feedFrontModel);

  @override
  State<TabbedFeedMenuItems> createState() => _TabbedFeedMenuItemsState();
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
      tabBar(widget.app, context,
          items: newLabels, tabController: _tabController),
      component(),
    ]);
  }

  Widget component() {
    if (_tabController.index == 0) {
      return FeedFront(widget.app, widget.feedFrontModel);
    }
    if (_tabController.index == 1) {
      return Profile(
          app: widget.app,
          backgroundOverride: widget.feedFrontModel.backgroundOverrideProfile);
    }
    var component = widget.bodyComponents[_tabController.index - 2];
    return Apis.apis().component(
        context, widget.app, component.componentName!, component.componentId!,
        parameters: widget.parameters);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }
}
