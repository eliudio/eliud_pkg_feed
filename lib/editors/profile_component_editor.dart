import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core_model/model/background_model.dart';
import 'package:eliud_core_model/model/storage_conditions_model.dart';
import 'package:eliud_core_model/style/frontend/has_container.dart';
import 'package:eliud_core_model/style/frontend/has_dialog.dart';
import 'package:eliud_core_model/style/frontend/has_dialog_field.dart';
import 'package:eliud_core_model/style/frontend/has_list_tile.dart';
import 'package:eliud_core_model/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core_model/style/frontend/has_text.dart';
import 'package:eliud_core_model/tools/component/component_spec.dart';
import 'package:eliud_core_model/tools/etc/random.dart';
import 'package:eliud_core/tools/widgets/background_widget.dart';
import 'package:eliud_core/tools/widgets/condition_simple_widget.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_bloc.dart';
import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_event.dart';
import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_state.dart';

import '../model/profile_entity.dart';
import 'feed/select_feed_widget.dart';

class ProfileComponentEditorConstructor extends ComponentEditorConstructor {
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
        ProfileModel(
          appId: app.documentID,
          documentID: newRandomKey(),
          description: 'New profile',
          conditions: StorageConditionsModel(
              privilegeLevelRequired:
                  PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
        ),
        feedback);
  }

  @override
  void updateComponentWithID(AppModel app, BuildContext context, String id,
      EditorFeedback feedback) async {
    var profile = await profileRepository(appId: app.documentID)!.get(id);
    if (profile != null) {
      _openIt(app, context, false, profile, feedback);
    } else {
      openErrorDialog(app, context, '${app.documentID}/_error',
          title: 'Error',
          errorMessage: 'Cannot find notification dashboard with id $id');
    }
  }

  void _openIt(AppModel app, BuildContext context, bool create,
      ProfileModel model, EditorFeedback feedback) {
    openComplexDialog(
      app,
      context,
      '${app.documentID}/notificationdashboard',
      title: create
          ? 'Create Notification Dashboard'
          : 'Update Notification Dashboard',
      includeHeading: false,
      widthFraction: .9,
      child: BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
                app.documentID,
                /*create,
            */
                feedback,
              )..add(EditorBaseInitialise<ProfileModel>(model)),
          child: ProfileComponentEditor(
            app: app,
          )),
    );
  }
}

class ProfileBloc extends EditorBaseBloc<ProfileModel, ProfileEntity> {
  ProfileBloc(String appId, EditorFeedback feedback)
      : super(appId, profileRepository(appId: appId)!, feedback);

  @override
  ProfileModel newInstance(StorageConditionsModel conditions) {
    return ProfileModel(
        appId: appId,
        documentID: newRandomKey(),
        description: 'New feed front',
        conditions: conditions);
  }

  @override
  ProfileModel setDefaultValues(
      ProfileModel t, StorageConditionsModel conditions) {
    return t.copyWith(conditions: t.conditions ?? conditions);
  }
}

class ProfileComponentEditor extends StatefulWidget {
  final AppModel app;

  const ProfileComponentEditor({
    super.key,
    required this.app,
  });

  @override
  State<StatefulWidget> createState() => _ProfileComponentEditorState();
}

class _ProfileComponentEditorState extends State<ProfileComponentEditor> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (aContext, accessState) {
      if (accessState is AccessDetermined) {
        var member = accessState.getMember();
        if (member != null) {
          var memberId = member.documentID;
          return BlocBuilder<ProfileBloc, EditorBaseState<ProfileModel>>(
              builder: (ppContext, profileState) {
            if (profileState is EditorBaseInitialised<ProfileModel>) {
              return ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    HeaderWidget(
                      app: widget.app,
                      title: 'Profile',
                      okAction: () async {
                        await BlocProvider.of<ProfileBloc>(context).save(
                            EditorBaseApplyChanges<ProfileModel>(
                                model: profileState.model));
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
                                  profileState.model.documentID)),
                          getListTile(context, widget.app,
                              leading: Icon(Icons.description),
                              title: dialogField(
                                widget.app,
                                context,
                                initialValue: profileState.model.description,
                                valueChanged: (value) {
                                  profileState.model.description = value;
                                },
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: 'Description',
                                  labelText: 'Description',
                                ),
                              )),
                        ]),
                    selectFeedWidget(
                        context,
                        widget.app,
                        profileState.model.conditions,
                        profileState.model.feed,
                        (feed) => setState(() {
                              profileState.model.feed = feed;
                            })),
                    topicContainer(widget.app, context,
                        title: 'Layout',
                        collapsible: true,
                        collapsed: true,
                        children: [
                          checkboxListTile(
                              widget.app,
                              context,
                              'Background override header?',
                              profileState.model.backgroundOverride != null,
                              (value) {
                            setState(() {
                              if (value!) {
                                profileState.model.backgroundOverride =
                                    BackgroundModel();
                              } else {
                                profileState.model.backgroundOverride = null;
                              }
                            });
                          }),
                          if (profileState.model.backgroundOverride != null)
                            BackgroundWidget(
                                app: widget.app,
                                memberId: memberId,
                                value: profileState.model.backgroundOverride!,
                                label: 'Background Override'),
                        ]),
                    topicContainer(widget.app, context,
                        title: 'Condition',
                        collapsible: true,
                        collapsed: true,
                        children: [
                          getListTile(context, widget.app,
                              leading: Icon(Icons.security),
                              title: ConditionsSimpleWidget(
                                app: widget.app,
                                value: profileState.model.conditions!,
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
}
