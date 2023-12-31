import 'package:eliud_core/access/state/access_determined.dart';
import 'package:eliud_core/access/state/access_state.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/background_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_container.dart';
import 'package:eliud_core_main/apis/style/frontend/has_dialog.dart';
import 'package:eliud_core_main/apis/style/frontend/has_dialog_field.dart';
import 'package:eliud_core_main/apis/style/frontend/has_list_tile.dart';
import 'package:eliud_core_main/apis/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core_main/apis/style/frontend/has_text.dart';
import 'package:eliud_core_main/apis/registryapi/component/component_spec.dart';
import 'package:eliud_core_helpers/etc/random.dart';
import 'package:eliud_core/core/widgets/background_widget.dart';
import 'package:eliud_core/core/widgets/helper_widgets/condition_simple_widget.dart';
import 'package:eliud_core/core/widgets/helper_widgets/header_widget.dart';
import 'package:eliud_pkg_feed_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed_model/model/feed_front_entity.dart';
import 'package:eliud_pkg_feed_model/model/feed_front_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/access/access_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eliud_core_main/editor/editor_base_bloc/editor_base_bloc.dart';
import 'package:eliud_core_main/editor/editor_base_bloc/editor_base_event.dart';
import 'package:eliud_core_main/editor/editor_base_bloc/editor_base_state.dart';

import 'feed/select_feed_widget.dart';

class FeedFrontComponentEditorConstructor extends ComponentEditorConstructor {
  @override
  void updateComponent(
      AppModel app, BuildContext context, model, EditorFeedback feedback) {
    _openIt(app, context, false, model.copyWith(), feedback);
  }

  @override
  void createNewComponent(
      AppModel app, BuildContext context, EditorFeedback feedback) {
    _openIt(
        app,
        context,
        true,
        FeedFrontModel(
          appId: app.documentID,
          documentID: newRandomKey(),
          description: 'New feed front',
          conditions: StorageConditionsModel(
              privilegeLevelRequired:
                  PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
        ),
        feedback);
  }

  @override
  void updateComponentWithID(AppModel app, BuildContext context, String id,
      EditorFeedback feedback) async {
    var feedFront = await feedFrontRepository(appId: app.documentID)!.get(id);
    if (feedFront != null) {
      _openIt(app, context, false, feedFront, feedback);
    } else {
      openErrorDialog(app, context, '${app.documentID}/_error',
          title: 'Error',
          errorMessage: 'Cannot find notification dashboard with id $id');
    }
  }

  void _openIt(AppModel app, BuildContext context, bool create,
      FeedFrontModel model, EditorFeedback feedback) {
    openComplexDialog(
      app,
      context,
      '${app.documentID}/notificationdashboard',
      title: create
          ? 'Create Notification Dashboard'
          : 'Update Notification Dashboard',
      includeHeading: false,
      widthFraction: .9,
      child: BlocProvider<FeedFrontBloc>(
          create: (context) => FeedFrontBloc(
                app.documentID,
                /*create,
            */
                feedback,
              )..add(EditorBaseInitialise<FeedFrontModel>(model)),
          child: FeedFrontComponentEditor(
            app: app,
          )),
    );
  }
}

class FeedFrontBloc extends EditorBaseBloc<FeedFrontModel, FeedFrontEntity> {
  FeedFrontBloc(String appId, EditorFeedback feedback)
      : super(appId, feedFrontRepository(appId: appId)!, feedback);

  @override
  FeedFrontModel newInstance(StorageConditionsModel conditions) {
    return FeedFrontModel(
        appId: appId,
        documentID: newRandomKey(),
        description: 'New feed front',
        conditions: conditions);
  }

  @override
  FeedFrontModel setDefaultValues(
      FeedFrontModel t, StorageConditionsModel conditions) {
    return t.copyWith(conditions: t.conditions ?? conditions);
  }
}

class FeedFrontComponentEditor extends StatefulWidget {
  final AppModel app;

  const FeedFrontComponentEditor({
    super.key,
    required this.app,
  });

  @override
  State<StatefulWidget> createState() => _FeedFrontComponentEditorState();
}

class _FeedFrontComponentEditorState extends State<FeedFrontComponentEditor> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (aContext, accessState) {
      if (accessState is AccessDetermined) {
        var member = accessState.getMember();
        if (member != null) {
          var memberId = member.documentID;
          return BlocBuilder<FeedFrontBloc, EditorBaseState<FeedFrontModel>>(
              builder: (ppContext, feedFrontState) {
            if (feedFrontState is EditorBaseInitialised<FeedFrontModel>) {
              return ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    HeaderWidget(
                      app: widget.app,
                      title: 'FeedFront',
                      okAction: () async {
                        await BlocProvider.of<FeedFrontBloc>(context).save(
                            EditorBaseApplyChanges<FeedFrontModel>(
                                model: feedFrontState.model));
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
                                  feedFrontState.model.documentID)),
                          getListTile(context, widget.app,
                              leading: Icon(Icons.description),
                              title: dialogField(
                                widget.app,
                                context,
                                initialValue: feedFrontState.model.description,
                                valueChanged: (value) {
                                  feedFrontState.model.description = value;
                                },
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: 'Description',
                                  labelText: 'Description',
                                ),
                              )),
                        ]),
                    topicContainer(widget.app, context,
                        title: 'Backgrounds',
                        collapsible: true,
                        collapsed: true,
                        children: [
                          topicContainer(widget.app, context,
                              title: 'Background override profile',
                              collapsible: true,
                              collapsed: true,
                              children: [
                                checkboxListTile(
                                    widget.app,
                                    context,
                                    'Background override profile?',
                                    feedFrontState
                                            .model.backgroundOverrideProfile !=
                                        null, (value) {
                                  setState(() {
                                    if (value!) {
                                      feedFrontState
                                              .model.backgroundOverrideProfile =
                                          BackgroundModel();
                                    } else {
                                      feedFrontState.model
                                          .backgroundOverrideProfile = null;
                                    }
                                  });
                                }),
                                if (feedFrontState
                                        .model.backgroundOverrideProfile !=
                                    null)
                                  BackgroundWidget(
                                      app: widget.app,
                                      memberId: memberId,
                                      value: feedFrontState
                                          .model.backgroundOverrideProfile!,
                                      label: 'Background Override Profile'),
                              ]),
                          topicContainer(widget.app, context,
                              title: 'Background override posts',
                              collapsible: true,
                              collapsed: true,
                              children: [
                                checkboxListTile(
                                    widget.app,
                                    context,
                                    'Background override posts?',
                                    feedFrontState
                                            .model.backgroundOverridePosts !=
                                        null, (value) {
                                  setState(() {
                                    if (value!) {
                                      feedFrontState
                                              .model.backgroundOverridePosts =
                                          BackgroundModel();
                                    } else {
                                      feedFrontState
                                          .model.backgroundOverridePosts = null;
                                    }
                                  });
                                }),
                                if (feedFrontState
                                        .model.backgroundOverridePosts !=
                                    null)
                                  BackgroundWidget(
                                      withTopicContainer: false,
                                      app: widget.app,
                                      memberId: memberId,
                                      value: feedFrontState
                                          .model.backgroundOverridePosts!,
                                      label: 'Background Override Posts'),
                              ]),
                        ]),
                    selectFeedWidget(
                        context,
                        widget.app,
                        feedFrontState.model.conditions,
                        feedFrontState.model.feed,
                        (feed) => setState(() {
                              feedFrontState.model.feed = feed;
                            })),
                    topicContainer(widget.app, context,
                        title: 'Condition',
                        collapsible: true,
                        collapsed: true,
                        children: [
                          getListTile(context, widget.app,
                              leading: Icon(Icons.security),
                              title: ConditionsSimpleWidget(
                                app: widget.app,
                                value: feedFrontState.model.conditions!,
                              )),
                        ]),
                  ]);
            } else {
              return progressIndicator(widget.app, context);
            }
          });
        } else {
          return text(widget.app, context, 'Member not logged on');
        }
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }
}
