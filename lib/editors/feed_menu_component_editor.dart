import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_event.dart';
import 'package:eliud_core/core/editor/ext_editor_base_bloc/ext_editor_base_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/rgb_formfield.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_core/tools/widgets/background_widget.dart';
import 'package:eliud_core/tools/widgets/condition_simple_widget.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_pkg_feed/editors/widgets/labelled_body_component_model_widget.dart';
import 'package:eliud_pkg_feed/editors/widgets/select_feed_front_widget.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/feed_menu_bloc.dart';

class FeedMenuComponentEditorConstructor extends ComponentEditorConstructor {
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
        FeedMenuModel(
          appId: app.documentID,
          documentID: newRandomKey(),
          description: 'New feed menu',
          conditions: StorageConditionsModel(
              privilegeLevelRequired:
                  PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
        ),
        feedback);
  }

  @override
  void updateComponentWithID(AppModel app, BuildContext context, String id,
      EditorFeedback feedback) async {
    var feedMenu = await feedMenuRepository(appId: app.documentID)!.get(id);
    if (feedMenu != null) {
      _openIt(app, context, false, feedMenu, feedback);
    } else {
      openErrorDialog(app, context, app.documentID + '/_error',
          title: 'Error',
          errorMessage: 'Cannot find membership dashboard with id $id');
    }
  }

  void _openIt(AppModel app, BuildContext context, bool create,
      FeedMenuModel model, EditorFeedback feedback) {
    openComplexDialog(
      app,
      context,
      app.documentID + '/membershipdashboard',
      title: create
          ? 'Create Membership Dashboard'
          : 'Update Membership Dashboard',
      includeHeading: false,
      widthFraction: .9,
      child: BlocProvider<FeedMenuBloc>(
          create: (context) => FeedMenuBloc(
                app.documentID,
                /*create,
            */
                feedback,
              )..add(ExtEditorBaseInitialise<FeedMenuModel>(model)),
          child: FeedMenuComponentEditor(
            app: app,
          )),
    );
  }

}

class FeedMenuComponentEditor extends StatefulWidget {
  final AppModel app;

  const FeedMenuComponentEditor({
    Key? key,
    required this.app,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeedMenuComponentEditorState();
}

class _FeedMenuComponentEditorState extends State<FeedMenuComponentEditor> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (aContext, accessState) {
      if (accessState is AccessDetermined) {
        var member = accessState.getMember();
        if (member != null) {
          var memberId = member.documentID;
          return BlocBuilder<FeedMenuBloc, ExtEditorBaseState<FeedMenuModel>>(
              builder: (ppContext, feedMenuState) {
            if (feedMenuState
                is ExtEditorBaseInitialised<FeedMenuModel, dynamic>) {
              return ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    HeaderWidget(
                      app: widget.app,
                      title: 'FeedMenu',
                      okAction: () async {
                        await BlocProvider.of<FeedMenuBloc>(context).save(
                            ExtEditorBaseApplyChanges<FeedMenuModel>(
                                model: feedMenuState.model));
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
                                  feedMenuState.model.documentID)),
                          getListTile(context, widget.app,
                              leading: Icon(Icons.description),
                              title: dialogField(
                                widget.app,
                                context,
                                initialValue: feedMenuState.model.description,
                                valueChanged: (value) {
                                  feedMenuState.model.description = value;
                                },
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: 'Description',
                                  labelText: 'Description',
                                ),
                              )),
                        ]),
                    topicContainer(widget.app, context,
                        title: 'Member actions',
                        collapsible: true,
                        collapsed: true,
                        children: [
                          _actions(feedMenuState),
                        ]),
                    topicContainer(widget.app, context,
                        title: 'Layout',
                        collapsible: true,
                        collapsed: true,
                        children: [
                          RgbField(
                              widget.app,
                              'Item Colour',
                              feedMenuState.model.itemColor,
                              (value) => feedMenuState.model.itemColor = value),
                          RgbField(
                              widget.app,
                              'Selected Item Colour',
                              feedMenuState.model.selectedItemColor,
                              (value) => feedMenuState.model.selectedItemColor =
                                  value),
                          topicContainer(widget.app, context,
                              title: 'Background override header',
                              collapsible: true,
                              collapsed: true,
                              children: [
                                checkboxListTile(
                                    widget.app,
                                    context,
                                    'Background override header?',
                                    feedMenuState.model.backgroundOverride !=
                                        null, (value) {
                                  setState(() {
                                    if (value!) {
                                      feedMenuState.model.backgroundOverride =
                                          BackgroundModel();
                                    } else {
                                      feedMenuState.model.backgroundOverride =
                                          null;
                                    }
                                  });
                                }),
                                if (feedMenuState.model.backgroundOverride !=
                                    null)
                                  BackgroundWidget(
                                    withTopicContainer: false,
                                      app: widget.app,
                                      memberId: memberId,
                                      value: feedMenuState
                                          .model.backgroundOverride!,
                                      label: 'Background Override'),
                              ]),
                        ]),
                    selectFeedFrontWidget(
                        context,
                        widget.app,
                        feedMenuState.model.conditions,
                        feedMenuState.model.feedFront,
                        (shop) => setState(() {
                              feedMenuState.model.feedFront = shop;
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
                                value: feedMenuState.model.conditions!,
                              )),
                        ]),
                  ]);
            } else {
              return progressIndicator(widget.app, context);
            }
          });
        } else {
          return progressIndicator(widget.app, context);
        }
      } else {
        return text(widget.app, context, 'No member');
      }
    });
  }

  Widget _actions(ExtEditorBaseInitialised<FeedMenuModel, dynamic> state) {
    List<LabelledBodyComponentModel> items =
        state.model.bodyComponentsCurrentMember != null
            ? state.model.bodyComponentsCurrentMember!
            : [];
    return Container(
      height: 150,
      child: ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
        Container(
            height: 100,
            child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                //separatorBuilder: (context, index) => divider(widget.app, context),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final value = items[index];
                  return getListTile(
                    context,
                    widget.app,
                    title: text(
                        widget.app,
                        context,
                        (value.label ?? 'no label') +
                            ' - ' +
                            (value.componentName ?? ' no component name') +
                            ' - ' +
                            (value.componentId ?? ' no component id')),
                    trailing: popupMenuButton<int>(
                      widget.app, context,
                        child: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              popupMenuItem(
                                widget.app, context,
                                value: 1,
                                label: 'Update'
                              ),
                              popupMenuItem(
                                widget.app, context,
                                value: 2,
                                label: 'Delete',
                              ),
                            ],
                        onSelected: (selectedValue) {
                          if (selectedValue == 1) {
                            open(
                                value,
                                (newItem) =>
                                    BlocProvider.of<FeedMenuBloc>(context).add(
                                        UpdateItemEvent<FeedMenuModel,
                                                LabelledBodyComponentModel>(
                                            oldItem: value, newItem: newItem)),
                                ((state.model.conditions == null) ||
                                        (state.model.conditions!
                                                .privilegeLevelRequired ==
                                            null))
                                    ? 0
                                    : state.model.conditions!
                                        .privilegeLevelRequired!.index);
                          } else if (selectedValue == 2) {
                            BlocProvider.of<FeedMenuBloc>(context).add(
                                DeleteItemEvent<FeedMenuModel,
                                        LabelledBodyComponentModel>(
                                    itemModel: value));
                          }
                        }),
                  );
                })),
        divider(
          widget.app,
          context,
        ),
        Row(children: [
          Spacer(),
          button(
            widget.app,
            context,
            icon: Icon(
              Icons.add,
            ),
            label: 'Add',
            onPressed: () {
              open(
                  LabelledBodyComponentModel(
                    documentID: newRandomKey(),
                    label: 'new action',
                  ),
                  (newItem) => BlocProvider.of<FeedMenuBloc>(context)
                      .add(AddItemEvent(itemModel: newItem)),
                  ((state.model.conditions == null) ||
                          (state.model.conditions!.privilegeLevelRequired ==
                              null))
                      ? 0
                      : state.model.conditions!.privilegeLevelRequired!.index);
            },
          ),
          Spacer(),
        ])
      ]),
    );
  }

  void open(
      LabelledBodyComponentModel value,
      LabelledBodyComponentModelCallback memberActionModelCallback,
      int privilegeContainer) {
    openFlexibleDialog(
      widget.app,
      context,
      widget.app.documentID + '/_memberaction',
      includeHeading: false,
      widthFraction: .8,
      child: LabelledBodyComponentModelWidget.getIt(
          context,
          widget.app,
          false,
          fullScreenWidth(context) * .8,
          fullScreenHeight(context) - 100,
          value,
          memberActionModelCallback,
          privilegeContainer),
    );
  }
}
