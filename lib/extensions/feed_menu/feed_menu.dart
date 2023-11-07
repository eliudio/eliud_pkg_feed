import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_pkg_feed/extensions/feed_menu/tabbed_feed_menu_items.dart';
import 'package:eliud_pkg_feed/extensions/header/header.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_bloc.dart';
import 'package:eliud_pkg_feed/extensions/bloc/profile_state.dart';
import 'package:eliud_pkg_feed/extensions/util/switch_member.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeedMenu extends StatefulWidget {
  final AppModel app;
  final FeedMenuModel feedMenuModel;

  FeedMenu(this.app, this.feedMenuModel);

  @override
  State<FeedMenu> createState() => _FeedMenuState();
}

class _FeedMenuState extends State<FeedMenu>
    with SingleTickerProviderStateMixin {
  _FeedMenuState();

  @override
  Widget build(BuildContext context) {
    if (widget.feedMenuModel.feedFront == null) {
      return text(widget.app, context, "feedMenuModel.feedFront == null");
    }
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
      if (accessState is AccessDetermined) {
        var pageContextInfo = eliudrouter.Router.getPageContextInfo(
          context,
        );
        var parameters = pageContextInfo.parameters;
        bool otherMember = false;
        if (parameters != null) {
          var openingForMemberId =
              parameters[SwitchMember.switchMemberFeedPageParameter];
          if (openingForMemberId != accessState.getMember()!.documentID) {
            otherMember = true;
          }
        }
        return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
          if (state is ProfileInitialised) {
            List<LabelledBodyComponentModel>? items;
            if (otherMember) {
              items = widget.feedMenuModel.bodyComponentsOtherMember;
            } else {
              items = widget.feedMenuModel.bodyComponentsCurrentMember;
            }

            // add feed and profile
            if (items != null) {
              return ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    Header(
                        app: widget.app,
                        backgroundOverride:
                            widget.feedMenuModel.backgroundOverride),
                    TabbedFeedMenuItems(widget.app, items, parameters,
                        widget.feedMenuModel.feedFront!),
                  ]);
            } else {
              return Container();
            }
//                return FeedMenuItems(widget.app, items, labels, parameters);
          } else {
            return progressIndicator(widget.app, context);
          }
        });
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }
}
