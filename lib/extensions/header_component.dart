import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_feed/extensions/util/feed_widget_helper.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/header_component.dart';
import 'package:eliud_pkg_feed/model/header_model.dart';
import 'package:eliud_pkg_feed/model/header_repository.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:flutter/material.dart';

import 'header/header.dart';

class HeaderComponentConstructorDefault implements ComponentConstructor {
  HeaderComponentConstructorDefault();

  Widget createNew({String? id, Map<String, dynamic>? parameters}) {
    return HeaderComponent(id: id);
  }
}

class HeaderComponent extends AbstractHeaderComponent {
  HeaderComponent({String? id}) : super(headerID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  Widget yourWidget(BuildContext context, HeaderModel? headerModel) {
    var _accessState = AccessBloc.getState(context);
    return FutureBuilder<List<String>>(
        future: PostFollowersHelper.asPublic(_accessState),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FeedWidgetHelper(widgetProvider: (switchFeedHelper) =>
                Header(switchFeedHelper: switchFeedHelper,
                  appId: headerModel!.appId!,
                  ownerId: switchFeedHelper.feedMember().documentID!,));
          }
          return Center(
            child: DelayedCircularProgressIndicator(),
          );
        }
    );
  }

  @override
  HeaderRepository getHeaderRepository(BuildContext context) {
    return AbstractRepositorySingleton.singleton
        .headerRepository(AccessBloc.appId(context))!;
  }
}
