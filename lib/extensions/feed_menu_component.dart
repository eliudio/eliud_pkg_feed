import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eliud_core/core/components/page_helper.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_feed/extensions/util/feed_widget_helper.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_menu_repository.dart';

class FeedMenuComponentConstructorDefault implements ComponentConstructor {
  FeedMenuComponentConstructorDefault();

  Widget createNew({String? id, Map<String, dynamic>? parameters}) {
    return FeedMenuComponent(id: id);
  }
}

class FeedMenuComponent extends AbstractFeedMenuComponent {
  FeedMenuComponent({String? id}) : super(feedMenuID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, FeedMenuModel? feedMenuModel) {
    var theState = AccessBloc.getState(context);
    if (theState is AppLoaded) {
      return FeedWidgetHelper(widgetProvider: (switchFeedHelper) {
        var widgets = <Widget>[];
        var items = feedMenuModel!.menu!.menuItems!;
        for (int i = 0; i < items.length; i++) {
          var item = items[i];
          if (theState.menuItemHasAccess(item)) {
            var isActive =
                PageHelper.isActivePage(switchFeedHelper.pageId, item.action);
            var _color = isActive
                ? RgbHelper.color(rgbo: feedMenuModel!.selectedItemColor)
                : RgbHelper.color(rgbo: feedMenuModel!.itemColor);
            widgets.add(PostHelper.getFormattedRoundedShape(Container(
                width: 110,
                child: IconButton(
                    icon: Center(child: Text('${item.text}',
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
            child: ListView(scrollDirection: Axis.horizontal, children: widgets));
      });
    } else {
      return Text("State is not AppLoaded");
    }
  }

  @override
  FeedMenuRepository getFeedMenuRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .feedMenuRepository(AccessBloc.appId(context))!;
  }
}
