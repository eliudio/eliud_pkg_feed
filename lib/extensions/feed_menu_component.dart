import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_menu_component.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_menu_repository.dart';

import 'feed_menu/feed_menu.dart';

class FeedMenuComponentConstructorDefault implements ComponentConstructor {
  FeedMenuComponentConstructorDefault();

  Widget createNew({Key? key, required String id, Map<String, dynamic>? parameters}) {
    return FeedMenuComponent(key: key, id: id);
  }
}

class FeedMenuComponent extends AbstractFeedMenuComponent {
  FeedMenuComponent({Key? key, required String id}) : super(key: key, feedMenuID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, FeedMenuModel? feedMenuModel) {
    return FeedMenu(feedMenuModel!);
  }

  @override
  FeedMenuRepository getFeedMenuRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .feedMenuRepository(AccessBloc.appId(context))!;
  }
}
