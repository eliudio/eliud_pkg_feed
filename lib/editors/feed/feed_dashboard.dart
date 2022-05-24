import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_event.dart';
import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_pkg_feed/editors/widgets/thumb_style_widget.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/feed_bloc.dart';

class FeedDashboard {
  static void updateFeed(
      AppModel app, BuildContext context, model) {
    _openIt(app, context, false, model.copyWith());
  }

  static void deleteFeed(
      AppModel app, BuildContext context, model) {
    // ask for confirmation. Very dangerous
  }

  static void addFeed(
      AppModel app, BuildContext context) {
    _openIt(
        app,
        context,
        true,
        FeedModel(
          appId: app.documentID,
          documentID: newRandomKey(),
        ),);
  }

  static void _openIt(AppModel app, BuildContext context, bool create,
      FeedModel model) {
    openComplexDialog(
      app,
      context,
      app.documentID + '/feed',
      title: create
          ? 'Create Feed'
          : 'Update Feed',
      includeHeading: false,
      widthFraction: .9,
      child: BlocProvider<FeedDashboardBloc>(
          create: (context) => FeedDashboardBloc(
                app.documentID,
                (_) {},
              )..add(EditorBaseInitialise<FeedModel>(model)),
          child: FeedDashboardWidget(
            app: app,
          )),
    );
  }
}

class FeedDashboardWidget extends StatefulWidget {
  final AppModel app;

  const FeedDashboardWidget({
    Key? key,
    required this.app,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _FeedDashboardWidgetState();
}

class _FeedDashboardWidgetState
    extends State<FeedDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (aContext, accessState) {
      if (accessState is AccessDetermined) {
        return BlocBuilder<FeedDashboardBloc,
            EditorBaseState<FeedModel>>(
            builder: (ppContext, feedState) {
          if (feedState
              is EditorBaseInitialised<FeedModel>) {
            return ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  HeaderWidget(
                    app: widget.app,
                    title: 'Feed',
                    okAction: () async {
                      await BlocProvider.of<FeedDashboardBloc>(context)
                          .save(EditorBaseApplyChanges<FeedModel>(
                              model: feedState.model));
                      return true;
                    },
                    cancelAction: () async {
                      return true;
                    },
                  ),
                  topicContainer(widget.app, context,
                      title: 'General',
                      collapsible: true,
                      collapsed: true,
                      children: [
                        getListTile(context, widget.app,
                            leading: Icon(Icons.vpn_key),
                            title: text(widget.app, context,
                                feedState.model.documentID)),
                        getListTile(context, widget.app,
                            leading: Icon(Icons.description),
                            title: dialogField(
                              widget.app,
                              context,
                              initialValue:
                              feedState.model.description,
                              valueChanged: (value) {
                                feedState.model.description =
                                    value;
                              },
                              maxLines: 1,
                              decoration: const InputDecoration(
                                hintText: 'Description',
                                labelText: 'Description',
                              ),
                            )),
                      ]),
                  topicContainer(widget.app, context,
                      title: 'Style thumb',
                      collapsible: true,
                      collapsed: true,
                      children: [
                        ThumbStyleWidget(app: widget.app, thumbStyle: feedState.model.thumbImage ?? ThumbStyle.Banana, thumbStyleCallback: (ThumbStyle thumbStyle) {
                          setState(() {
                            feedState.model.thumbImage = thumbStyle;
                          });
                        }, )
                      ]),
                  topicContainer(widget.app, context,
                      title: 'Feed allowed',
                      collapsible: true,
                      collapsed: true,
                      children: [
                        checkboxListTile(widget.app, context, 'Post photo',
                            feedState.model.photoPost, (value) {
                              setState(() {
                                feedState.model.photoPost = value ?? false;
                              });
                            }),
                        checkboxListTile(widget.app, context, 'Post video',
                            feedState.model.videoPost, (value) {
                              setState(() {
                                feedState.model.videoPost = value ?? false;
                              });
                            }),
                        checkboxListTile(widget.app, context, 'Post message',
                            feedState.model.messagePost, (value) {
                              setState(() {
                                feedState.model.messagePost = value ?? false;
                              });
                            }),
/*
                        not implemented yet
                        checkboxListTile(widget.app, context, 'Audio message',
                            feedState.model.audioPost, (value) {
                              setState(() {
                                feedState.model.audioPost = value ?? false;
                              });
                            }),
*/
                        checkboxListTile(widget.app, context, 'Post album',
                            feedState.model.albumPost, (value) {
                              setState(() {
                                feedState.model.albumPost = value ?? false;
                              });
                            }),
                        checkboxListTile(widget.app, context, 'Post article',
                            feedState.model.articlePost, (value) {
                              setState(() {
                                feedState.model.articlePost = value ?? false;
                              });
                            }),

                      ]),
                ]);
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
