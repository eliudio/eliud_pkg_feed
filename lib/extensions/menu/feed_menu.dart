import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/core/tools/page_helper.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_feed/extensions/profile/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/profile/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedMenu extends StatefulWidget {
  final FeedMenuModel feedMenuModel;

  FeedMenu(this.feedMenuModel);

  _FeedMenuState createState() => _FeedMenuState();
}

class _FeedMenuState extends State<FeedMenu> {
  _FeedMenuState();

  @override
  Widget build(BuildContext context) {
    var theState = AccessBloc.getState(context);
    if (theState is AppLoaded) {
      return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileInitialised) {
          var popupMenuItems = <DropdownMenuItem<int>>[];
          var items = widget.feedMenuModel.menu!.menuItems!;
          var selectedPage = 0;
          for (int i = 0; i < items.length; i++) {
            var item = items[i];
            if (theState.menuItemHasAccess(item)) {
              var isActive = PageHelper.isActivePage(
                  state.switchFeedHelper.pageId, item.action);
              if (isActive) {
                selectedPage = i;
              }
              popupMenuItems.add(
                DropdownMenuItem<int>(
                    child: Text(
                      item.text!,
                    ),
                    value: i),
              );
            }
          }

          return Align(
              alignment: Alignment.center,
              child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().actionContainer(context, child:Container(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton(
                      value: selectedPage,
                      items: popupMenuItems,
                      onChanged: (choice) {
                        eliudrouter.Router.navigateTo(
                            context, items[choice as int].action!);
                      }))));
        } else {
          return StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicator(context);
        }
      });
    } else {
      return Text("App not loaded");
    }
  }
}
