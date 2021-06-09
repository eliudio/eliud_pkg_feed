import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/components/util/page_helper.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_pkg_etc/tools/formatter/format_helpere.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_pkg_feed/extensions/profile/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/profile/bloc/profile_state.dart';
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
                      item!.text!,
                      style: GoogleFonts.annieUseYourTelescope(fontSize: 35),
                    ),
                    value: i),
              );
            }
          }

          return Align(
              alignment: Alignment.center,
              child: FormatHelper.getFormattedRoundedShape(Container(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton(
                      value: selectedPage,
                      items: popupMenuItems,
                      onChanged: (choice) {
                        eliudrouter.Router.navigateTo(
                            context, items[choice as int]!.action!);
                      }))));
        } else {
          return Center(child: DelayedCircularProgressIndicator());
        }
      });
    } else {
      return Text("App not loaded");
    }
  }
}
