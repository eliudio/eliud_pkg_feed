/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 profile_form.dart
                       
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




import 'package:eliud_core/model/internal_component.dart';

import 'package:eliud_core/tools/enums.dart';

import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';

import 'package:eliud_pkg_feed/model/profile_list_bloc.dart';
import 'package:eliud_pkg_feed/model/profile_list_event.dart';
import 'package:eliud_pkg_feed/model/profile_model.dart';
import 'package:eliud_pkg_feed/model/profile_form_bloc.dart';
import 'package:eliud_pkg_feed/model/profile_form_event.dart';
import 'package:eliud_pkg_feed/model/profile_form_state.dart';


class ProfileForm extends StatelessWidget {
  final AppModel app;
  FormAction formAction;
  ProfileModel? value;
  ActionModel? submitAction;

  ProfileForm({Key? key, required this.app, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var appId = app.documentID;
    if (formAction == FormAction.ShowData) {
      return BlocProvider<ProfileFormBloc >(
            create: (context) => ProfileFormBloc(appId,
                                       formAction: formAction,

                                                )..add(InitialiseProfileFormEvent(value: value)),
  
        child: MyProfileForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<ProfileFormBloc >(
            create: (context) => ProfileFormBloc(appId,
                                       formAction: formAction,

                                                )..add(InitialiseProfileFormNoLoadEvent(value: value)),
  
        child: MyProfileForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithApp(app).adminFormStyle().appBarWithString(app, context, title: formAction == FormAction.UpdateAction ? 'Update Profile' : 'Add Profile'),
        body: BlocProvider<ProfileFormBloc >(
            create: (context) => ProfileFormBloc(appId,
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialiseProfileFormEvent(value: value) : InitialiseNewProfileFormEvent())),
  
        child: MyProfileForm(app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyProfileForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyProfileForm({required this.app, this.formAction, this.submitAction});

  _MyProfileFormState createState() => _MyProfileFormState(this.formAction);
}


class _MyProfileFormState extends State<MyProfileForm> {
  final FormAction? formAction;
  late ProfileFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _feed;


  _MyProfileFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<ProfileFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _appIdController.addListener(_onAppIdChanged);
    _descriptionController.addListener(_onDescriptionChanged);
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<ProfileFormBloc, ProfileFormState>(builder: (context, state) {
      if (state is ProfileFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context),
      );

      if (state is ProfileFormLoaded) {
        if (state.value!.documentID != null)
          _documentIDController.text = state.value!.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value!.appId != null)
          _appIdController.text = state.value!.appId.toString();
        else
          _appIdController.text = "";
        if (state.value!.description != null)
          _descriptionController.text = state.value!.description.toString();
        else
          _descriptionController.text = "";
        if (state.value!.feed != null)
          _feed= state.value!.feed!.documentID;
        else
          _feed= "";
      }
      if (state is ProfileFormInitialized) {
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
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'Document ID', icon: Icons.vpn_key, readOnly: (formAction == FormAction.UpdateAction), textEditingController: _documentIDController, keyboardType: TextInputType.text, validator: (_) => state is DocumentIDProfileFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'App Identifier', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _appIdController, keyboardType: TextInputType.text, validator: (_) => state is AppIdProfileFormError ? state.message : null, hintText: 'field.remark')
          );

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'Description', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _descriptionController, keyboardType: TextInputType.text, validator: (_) => state is DescriptionProfileFormError ? state.message : null, hintText: null)
          );

        children.add(

                DropdownButtonComponentFactory().createNew(app: widget.app, id: "feeds", value: _feed, trigger: (value, privilegeLevel) => _onFeedSelected(value), optional: false),
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'Conditions')
                ));



        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().button(widget.app, context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is ProfileFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<ProfileListBloc>(context).add(
                          UpdateProfileList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              appId: state.value!.appId, 
                              description: state.value!.description, 
                              feed: state.value!.feed, 
                              backgroundOverride: state.value!.backgroundOverride, 
                              conditions: state.value!.conditions, 
                        )));
                      } else {
                        BlocProvider.of<ProfileListBloc>(context).add(
                          AddProfileList(value: ProfileModel(
                              documentID: state.value!.documentID, 
                              appId: state.value!.appId, 
                              description: state.value!.description, 
                              feed: state.value!.feed, 
                              backgroundOverride: state.value!.backgroundOverride, 
                              conditions: state.value!.conditions, 
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
              children: children
            ),
          ), formAction!
        );
      } else {
        return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
      }
    });
  }

  void _onDocumentIDChanged() {
    _myFormBloc.add(ChangedProfileDocumentID(value: _documentIDController.text));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedProfileAppId(value: _appIdController.text));
  }


  void _onDescriptionChanged() {
    _myFormBloc.add(ChangedProfileDescription(value: _descriptionController.text));
  }


  void _onFeedSelected(String? val) {
    setState(() {
      _feed = val;
    });
    _myFormBloc.add(ChangedProfileFeed(value: val));
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _appIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, ProfileFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner(widget.app.documentID));
  }
  

}



