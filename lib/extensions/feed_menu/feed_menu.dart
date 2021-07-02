import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/core/tools/page_helper.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorful_tab/flutter_colorful_tab.dart';

class FeedMenu extends StatefulWidget {
  final FeedMenuModel feedMenuModel;

  FeedMenu(this.feedMenuModel);

  _FeedMenuState createState() => _FeedMenuState();
}

class _FeedMenuState extends State<FeedMenu> with SingleTickerProviderStateMixin {
  _FeedMenuState();

  @override
  Widget build(BuildContext context) {
    var pageContextInfo = PageParamHelper.getPagaContextInfo(context);
    var parameters = pageContextInfo.parameters;
    var theState = AccessBloc.getState(context);
    if (theState is AppLoaded) {
      return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileInitialised) {
          var items = widget.feedMenuModel.menu!.menuItems!;
          var useTheseItems = <String>[];
          var actions = <ActionModel>[];
          var selectedPage = 0;
          var i = 0;
          for (var item in items) {
            if (theState.menuItemHasAccess(item)) {
              var isActive = PageHelper.isActivePage(
                  pageContextInfo.pageId, item.action);
              if (isActive) {
                selectedPage = i;
              }
              if (item.text != null) {
                useTheseItems.add(item.text!);
                actions.add(item.action!);
              }
              i++;
            }
          }

          return FeedMenuItems(useTheseItems, actions, selectedPage, parameters);
        } else {
          return StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context);
        }
      });
    } else {
      return StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context, 'App not loaded');
    }
  }
}

class FeedMenuItems extends StatefulWidget {
  final List<String> items;
  final List<ActionModel> actions;
  final int active;
  final Map<String, dynamic>? parameters;

  FeedMenuItems(this.items, this.actions, this.active, this.parameters);

  _FeedMenuItemsState createState() => _FeedMenuItemsState();
}

class _FeedMenuItemsState extends State<FeedMenuItems> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<TabItem>? tabItems;
  _FeedMenuItemsState();

  @override
  void initState() {
    var size = widget.items.length;
    _tabController = TabController(vsync: this, length: size);
    _tabController!.addListener(_handleTabSelection);
    _tabController!.index = widget.active;

    tabItems = <TabItem>[];
    for (var item in widget.items) {
      tabItems!.add(TabItem(color: Colors.black12, title: StyleRegistry.registry().styleWithContext(context).frontEndStyle().textStyle().text(context,
        item,
      )));
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (tabItems != null) {
      return ColorfulTabBar(
        tabs: tabItems!,
        controller: _tabController,
      );
    } else {
      return Text("No menu");
    }
  }

  void _handleTabSelection() {
    if ((_tabController != null) && (_tabController!.indexIsChanging)) {
        var action = widget.actions[_tabController!.index];
        eliudrouter.Router.navigateTo(context, action, parameters: widget.parameters);
    }
  }
}
