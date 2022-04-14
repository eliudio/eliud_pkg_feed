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
import 'package:eliud_core/core/blocs/access/state/logged_in.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/tools/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/style/admin/admin_form_style.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:intl/intl.dart';

import 'package:eliud_core/eliud.dart';

import 'package:eliud_core/model/internal_component.dart';
import 'package:eliud_pkg_feed/model/embedded_component.dart';
import 'package:eliud_pkg_feed/tools/bespoke_formfields.dart';
import 'package:eliud_core/tools/bespoke_formfields.dart';

import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_core/tools/etc.dart';

import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_pkg_feed/model/embedded_component.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/labelled_body_component_list_bloc.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_list_event.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_model.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_form_bloc.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_form_event.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_form_state.dart';


class LabelledBodyComponentForm extends StatelessWidget {
  final AppModel app;
  FormAction formAction;
  LabelledBodyComponentModel? value;
  ActionModel? submitAction;

  LabelledBodyComponentForm({Key? key, required this.app, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var appId = app.documentID!;
    if (formAction == FormAction.ShowData) {
      return BlocProvider<LabelledBodyComponentFormBloc >(
            create: (context) => LabelledBodyComponentFormBloc(appId,
                                       
                                                )..add(InitialiseLabelledBodyComponentFormEvent(value: value)),
  
        child: MyLabelledBodyComponentForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<LabelledBodyComponentFormBloc >(
            create: (context) => LabelledBodyComponentFormBloc(appId,
                                       
                                                )..add(InitialiseLabelledBodyComponentFormNoLoadEvent(value: value)),
  
        child: MyLabelledBodyComponentForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithApp(app).adminFormStyle().appBarWithString(app, context, title: formAction == FormAction.UpdateAction ? 'Update LabelledBodyComponent' : 'Add LabelledBodyComponent'),
        body: BlocProvider<LabelledBodyComponentFormBloc >(
            create: (context) => LabelledBodyComponentFormBloc(appId,
                                       
                                                )..add((formAction == FormAction.UpdateAction ? InitialiseLabelledBodyComponentFormEvent(value: value) : InitialiseNewLabelledBodyComponentFormEvent())),
  
        child: MyLabelledBodyComponentForm(app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyLabelledBodyComponentForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyLabelledBodyComponentForm({required this.app, this.formAction, this.submitAction});

  _MyLabelledBodyComponentFormState createState() => _MyLabelledBodyComponentFormState(this.formAction);
}


class _MyLabelledBodyComponentFormState extends State<MyLabelledBodyComponentForm> {
  final FormAction? formAction;
  late LabelledBodyComponentFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();


  _MyLabelledBodyComponentFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<LabelledBodyComponentFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _labelController.addListener(_onLabelChanged);
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<LabelledBodyComponentFormBloc, LabelledBodyComponentFormState>(builder: (context, state) {
      if (state is LabelledBodyComponentFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context),
      );

      if (state is LabelledBodyComponentFormLoaded) {
        if (state.value!.documentID != null)
          _documentIDController.text = state.value!.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value!.label != null)
          _labelController.text = state.value!.label.toString();
        else
          _labelController.text = "";
      }
      if (state is LabelledBodyComponentFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'General')
                ));


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'Component')
                ));

        children.add(

                ExtensionTypeField(widget.app, state.value!.componentName, _onComponentNameChanged)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'Component spec')
                ));

        children.add(

                ComponentIdField(widget.app, componentName: state.value!.componentName, value: state.value!.componentId, trigger: _onComponentIdChanged)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().button(widget.app, context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is LabelledBodyComponentFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<LabelledBodyComponentListBloc>(context).add(
                          UpdateLabelledBodyComponentList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              label: state.value!.label, 
                              componentName: state.value!.componentName, 
                              componentId: state.value!.componentId, 
                        )));
                      } else {
                        BlocProvider.of<LabelledBodyComponentListBloc>(context).add(
                          AddLabelledBodyComponentList(value: LabelledBodyComponentModel(
                              documentID: state.value!.documentID, 
                              label: state.value!.label, 
                              componentName: state.value!.componentName, 
                              componentId: state.value!.componentId, 
                          )));
                      }
                      if (widget.submitAction != null) {
                        eliudrouter.Router.navigateTo(context, widget.submitAction!);
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                ));

        return StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().container(widget.app, context, Form(
            child: ListView(
              padding: const EdgeInsets.all(8),
              physics: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)) ? NeverScrollableScrollPhysics() : null,
              shrinkWrap: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)),
              children: children as List<Widget>
            ),
          ), formAction!
        );
      } else {
        return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
      }
    });
  }

  void _onDocumentIDChanged() {
    _myFormBloc.add(ChangedLabelledBodyComponentDocumentID(value: _documentIDController.text));
  }


  void _onLabelChanged() {
    _myFormBloc.add(ChangedLabelledBodyComponentLabel(value: _labelController.text));
  }


  void _onComponentNameChanged(value) {
    _myFormBloc.add(ChangedLabelledBodyComponentComponentName(value: value));
    
  }


  void _onComponentIdChanged(value) {
    _myFormBloc.add(ChangedLabelledBodyComponentComponentId(value: value));
    
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, LabelledBodyComponentFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner(widget.app.documentID!));
  }
  

}



