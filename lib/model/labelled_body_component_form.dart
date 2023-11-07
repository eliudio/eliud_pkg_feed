/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 labelled_body_component_form.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'package:eliud_core/tools/bespoke_formfields.dart';

import 'package:eliud_core/tools/enums.dart';

import 'package:eliud_pkg_feed/model/model_export.dart';

import 'package:eliud_pkg_feed/model/labelled_body_component_list_bloc.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_list_event.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_model.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_form_bloc.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_form_event.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_form_state.dart';

class LabelledBodyComponentForm extends StatelessWidget {
  final AppModel app;
  final FormAction formAction;
  final LabelledBodyComponentModel? value;
  final ActionModel? submitAction;

  LabelledBodyComponentForm(
      {super.key,
      required this.app,
      required this.formAction,
      required this.value,
      this.submitAction});

  /// Build the LabelledBodyComponentForm
  @override
  Widget build(BuildContext context) {
    //var accessState = AccessBloc.getState(context);
    var appId = app.documentID;
    if (formAction == FormAction.showData) {
      return BlocProvider<LabelledBodyComponentFormBloc>(
        create: (context) => LabelledBodyComponentFormBloc(
          appId,
        )..add(InitialiseLabelledBodyComponentFormEvent(value: value)),
        child: MyLabelledBodyComponentForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    }
    if (formAction == FormAction.showPreloadedData) {
      return BlocProvider<LabelledBodyComponentFormBloc>(
        create: (context) => LabelledBodyComponentFormBloc(
          appId,
        )..add(InitialiseLabelledBodyComponentFormNoLoadEvent(value: value)),
        child: MyLabelledBodyComponentForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    } else {
      return Scaffold(
          appBar: StyleRegistry.registry()
              .styleWithApp(app)
              .adminFormStyle()
              .appBarWithString(app, context,
                  title: formAction == FormAction.updateAction
                      ? 'Update LabelledBodyComponent'
                      : 'Add LabelledBodyComponent'),
          body: BlocProvider<LabelledBodyComponentFormBloc>(
            create: (context) => LabelledBodyComponentFormBloc(
              appId,
            )..add((formAction == FormAction.updateAction
                ? InitialiseLabelledBodyComponentFormEvent(value: value)
                : InitialiseNewLabelledBodyComponentFormEvent())),
            child: MyLabelledBodyComponentForm(
                app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}

class MyLabelledBodyComponentForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyLabelledBodyComponentForm(
      {required this.app, this.formAction, this.submitAction});

  @override
  State<MyLabelledBodyComponentForm> createState() =>
      _MyLabelledBodyComponentFormState(formAction);
}

class _MyLabelledBodyComponentFormState
    extends State<MyLabelledBodyComponentForm> {
  final FormAction? formAction;
  late LabelledBodyComponentFormBloc _myFormBloc;

  _MyLabelledBodyComponentFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<LabelledBodyComponentFormBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<LabelledBodyComponentFormBloc,
        LabelledBodyComponentFormState>(builder: (context, state) {
      if (state is LabelledBodyComponentFormUninitialized) {
        return Center(
          child: StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminListStyle()
              .progressIndicator(widget.app, context),
        );
      }

      if (state is LabelledBodyComponentFormLoaded) {}
      if (state is LabelledBodyComponentFormInitialized) {
        List<Widget> children = [];
        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'General')));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'Component')));

        children.add(ExtensionTypeField(
            widget.app, state.value!.componentName, _onComponentNameChanged));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'Component spec')));

        children.add(ComponentIdField(widget.app,
            componentName: state.value!.componentName,
            originalValue: state.value!.componentId,
            trigger: (value, _) => _onComponentIdChanged(value)));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        if ((formAction != FormAction.showData) &&
            (formAction != FormAction.showPreloadedData)) {
          children.add(StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminFormStyle()
              .button(
                widget.app,
                context,
                label: 'Submit',
                onPressed: _readOnly(accessState, state)
                    ? null
                    : () {
                        if (state is LabelledBodyComponentFormError) {
                          return;
                        } else {
                          if (formAction == FormAction.updateAction) {
                            BlocProvider.of<LabelledBodyComponentListBloc>(
                                    context)
                                .add(UpdateLabelledBodyComponentList(
                                    value: state.value!.copyWith(
                              documentID: state.value!.documentID,
                              label: state.value!.label,
                              componentName: state.value!.componentName,
                              componentId: state.value!.componentId,
                            )));
                          } else {
                            BlocProvider.of<LabelledBodyComponentListBloc>(
                                    context)
                                .add(AddLabelledBodyComponentList(
                                    value: LabelledBodyComponentModel(
                              documentID: state.value!.documentID,
                              label: state.value!.label,
                              componentName: state.value!.componentName,
                              componentId: state.value!.componentId,
                            )));
                          }
                          if (widget.submitAction != null) {
                            eliudrouter.Router.navigateTo(
                                context, widget.submitAction!);
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
              ));
        }

        return StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .container(
                widget.app,
                context,
                Form(
                  child: ListView(
                      padding: const EdgeInsets.all(8),
                      physics: ((formAction == FormAction.showData) ||
                              (formAction == FormAction.showPreloadedData))
                          ? NeverScrollableScrollPhysics()
                          : null,
                      shrinkWrap: ((formAction == FormAction.showData) ||
                          (formAction == FormAction.showPreloadedData)),
                      children: children),
                ),
                formAction!);
      } else {
        return StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminListStyle()
            .progressIndicator(widget.app, context);
      }
    });
  }

  void _onComponentNameChanged(value) {
    _myFormBloc.add(ChangedLabelledBodyComponentComponentName(value: value));
  }

  void _onComponentIdChanged(value) {
    _myFormBloc.add(ChangedLabelledBodyComponentComponentId(value: value));
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Is the form read-only?
  bool _readOnly(
      AccessState accessState, LabelledBodyComponentFormInitialized state) {
    return (formAction == FormAction.showData) ||
        (formAction == FormAction.showPreloadedData) ||
        (!accessState.memberIsOwner(widget.app.documentID));
  }
}
