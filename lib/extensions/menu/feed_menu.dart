import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/components/util/page_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
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
          var widgets = <Widget>[];
          var items = widget.feedMenuModel.menu!.menuItems!;
          for (int i = 0; i < items.length; i++) {
            var item = items[i];
            if (theState.menuItemHasAccess(item)) {
              var isActive =
                  PageHelper.isActivePage(state.switchFeedHelper.pageId, item.action);
              var _color = isActive
                  ? RgbHelper.color(rgbo: widget.feedMenuModel.selectedItemColor)
                  : RgbHelper.color(rgbo: widget.feedMenuModel.itemColor);
              widgets.add(PostHelper.getFormattedRoundedShape(Container(
                  width: 110,
                  child: IconButton(
                      icon: Center(
                          child: Text('${item.text}',
                              style: GoogleFonts.annieUseYourTelescope(
                                  fontSize: 20, color: _color))),
                      onPressed: !isActive
                          ? () {
                              eliudrouter.Router.navigateTo(
                                  context, item.action!);
                            }
                          : null))));
            }
            if (i != items.length - 1) {
              widgets.add(Container(width: 10));
            }
          }
          return Container(
              height: 60,
              child: ListView(
                  scrollDirection: Axis.horizontal, children: widgets));
        } else {
          return Center(child: DelayedCircularProgressIndicator());
        }
      });
    } else {
      return Text("App not loaded");
    }
  }
}
