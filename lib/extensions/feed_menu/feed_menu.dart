import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/core/navigate/page_param_helper.dart';
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

class FeedMenu extends StatefulWidget {
  final FeedMenuModel feedMenuModel;

  FeedMenu(this.feedMenuModel);

  _FeedMenuState createState() => _FeedMenuState();
}

class _FeedMenuState extends State<FeedMenu>
    with SingleTickerProviderStateMixin {
  _FeedMenuState();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
          if (accessState is AccessDetermined) {
            var pageContextInfo = PageParamHelper.getPagaContextInfo(context, accessState.currentApp);
            var parameters = pageContextInfo.parameters;
            var theState = AccessBloc.getState(context);
            bool otherMember = false;
            if (parameters != null) {
              var openingForMemberId =
              parameters[SwitchMember.switchMemberFeedPageParameter];
              if (openingForMemberId != theState.getMember()!.documentID!) {
                otherMember = true;
              }
            }
            return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
              if (state is ProfileInitialised) {
                var items;
                if (otherMember) {
                  items = widget.feedMenuModel.menuOtherMember!.menuItems!;
                } else {
                  items = widget.feedMenuModel.menuCurrentMember!.menuItems!;
                }
                var useTheseItems = <String>[];
                var actions = <ActionModel>[];
                var selectedPage = 0;
                var i = 0;
                for (var item in items) {
                  if (accessState.menuItemHasAccess(item)) {
                    var isActive =
                    PageHelper.isActivePage(pageContextInfo.pageId, item.action);
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

                return FeedMenuItems(
                    useTheseItems, actions, selectedPage, parameters);
              } else {
                return progressIndicator(context);
              }
            });
          } else {
            return progressIndicator(context);
          }
        });
  }
}

class FeedMenuItems extends StatefulWidget {
  final List<String> items;
  final List<ActionModel> actions;
  final int active;
  final Map<String, dynamic>? parameters;

  FeedMenuItems(this.items, this.actions, this.active, this.parameters);

  _FeedMenuItemsState createState() =>
      _FeedMenuItemsState(items, active, actions, parameters);
}

class _FeedMenuItemsState extends State<FeedMenuItems>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final List<String> items;
  final int active;
  final List<ActionModel> actions;
  final Map<String, dynamic>? parameters;

  _FeedMenuItemsState(this.items, this.active, this.actions, this.parameters);

  @override
  void initState() {
    var size = items.length;
    _tabController = TabController(vsync: this, length: size);
    _tabController!.addListener(_handleTabSelection);
    _tabController!.index = active;

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
    if (_tabController != null) {
      return tabBar(context, items: items, tabController: _tabController!);
    } else {
      return Text('No controller');
    }
  }

  void _handleTabSelection() {
    if ((_tabController != null) && (_tabController!.indexIsChanging)) {
      var action = actions[_tabController!.index];
      eliudrouter.Router.navigateTo(context, action, parameters: parameters);
    }
  }
}
