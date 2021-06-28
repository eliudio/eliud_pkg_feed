/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_profile_form.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
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

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/embedded_component.dart';
import 'package:eliud_pkg_feed/model/embedded_component.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/member_profile_list_bloc.dart';
import 'package:eliud_pkg_feed/model/member_profile_list_event.dart';
import 'package:eliud_pkg_feed/model/member_profile_model.dart';
import 'package:eliud_pkg_feed/model/member_profile_form_bloc.dart';
import 'package:eliud_pkg_feed/model/member_profile_form_event.dart';
import 'package:eliud_pkg_feed/model/member_profile_form_state.dart';


class MemberProfileForm extends StatelessWidget {
  FormAction formAction;
  MemberProfileModel? value;
  ActionModel? submitAction;

  MemberProfileForm({Key? key, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var app = AccessBloc.app(context);
    if (app == null) return Text("No app available");
    if (formAction == FormAction.ShowData) {
      return BlocProvider<MemberProfileFormBloc >(
            create: (context) => MemberProfileFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialiseMemberProfileFormEvent(value: value)),
  
        child: MyMemberProfileForm(submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<MemberProfileFormBloc >(
            create: (context) => MemberProfileFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialiseMemberProfileFormNoLoadEvent(value: value)),
  
        child: MyMemberProfileForm(submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithContext(context).adminFormStyle().appBarWithString(context, title: formAction == FormAction.UpdateAction ? 'Update MemberProfile' : 'Add MemberProfile'),
        body: BlocProvider<MemberProfileFormBloc >(
            create: (context) => MemberProfileFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialiseMemberProfileFormEvent(value: value) : InitialiseNewMemberProfileFormEvent())),
  
        child: MyMemberProfileForm(submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyMemberProfileForm extends StatefulWidget {
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyMemberProfileForm({this.formAction, this.submitAction});

  _MyMemberProfileFormState createState() => _MyMemberProfileFormState(this.formAction);
}


class _MyMemberProfileFormState extends State<MyMemberProfileForm> {
  final FormAction? formAction;
  late MemberProfileFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _feedIdController = TextEditingController();
  final TextEditingController _authorIdController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();
  String? _profileBackground;
  final TextEditingController _profileOverrideController = TextEditingController();
  final TextEditingController _nameOverrideController = TextEditingController();


  _MyMemberProfileFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<MemberProfileFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _appIdController.addListener(_onAppIdChanged);
    _feedIdController.addListener(_onFeedIdChanged);
    _authorIdController.addListener(_onAuthorIdChanged);
    _profileController.addListener(_onProfileChanged);
    _profileOverrideController.addListener(_onProfileOverrideChanged);
    _nameOverrideController.addListener(_onNameOverrideChanged);
  }

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.app(context);
    if (app == null) return Text('No app available');
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<MemberProfileFormBloc, MemberProfileFormState>(builder: (context, state) {
      if (state is MemberProfileFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithContext(context).adminListStyle().progressIndicator(context),
      );

      if (state is MemberProfileFormLoaded) {
        if (state.value!.documentID != null)
          _documentIDController.text = state.value!.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value!.appId != null)
          _appIdController.text = state.value!.appId.toString();
        else
          _appIdController.text = "";
        if (state.value!.feedId != null)
          _feedIdController.text = state.value!.feedId.toString();
        else
          _feedIdController.text = "";
        if (state.value!.authorId != null)
          _authorIdController.text = state.value!.authorId.toString();
        else
          _authorIdController.text = "";
        if (state.value!.profile != null)
          _profileController.text = state.value!.profile.toString();
        else
          _profileController.text = "";
        if (state.value!.profileBackground != null)
          _profileBackground= state.value!.profileBackground!.documentID;
        else
          _profileBackground= "";
        if (state.value!.profileOverride != null)
          _profileOverrideController.text = state.value!.profileOverride.toString();
        else
          _profileOverrideController.text = "";
        if (state.value!.nameOverride != null)
          _nameOverrideController.text = state.value!.nameOverride.toString();
        else
          _nameOverrideController.text = "";
      }
      if (state is MemberProfileFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Author ID', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _authorIdController, keyboardType: TextInputType.text, validator: (_) => state is AuthorIdMemberProfileFormError ? state.message : null, hintText: null)
          );

        children.add(

                DropdownButtonComponentFactory().createNew(id: "memberMediums", value: _profileBackground, trigger: _onProfileBackgroundSelected, optional: true),
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Profile Override', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _profileOverrideController, keyboardType: TextInputType.text, validator: (_) => state is ProfileOverrideMemberProfileFormError ? state.message : null, hintText: null)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Document ID', icon: Icons.vpn_key, readOnly: (formAction == FormAction.UpdateAction), textEditingController: _documentIDController, keyboardType: TextInputType.text, validator: (_) => state is DocumentIDMemberProfileFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Feed Identifier', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _feedIdController, keyboardType: TextInputType.text, validator: (_) => state is FeedIdMemberProfileFormError ? state.message : null, hintText: 'field.remark')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Profile', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _profileController, keyboardType: TextInputType.text, validator: (_) => state is ProfileMemberProfileFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Name override', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _nameOverrideController, keyboardType: TextInputType.text, validator: (_) => state is NameOverrideMemberProfileFormError ? state.message : null, hintText: null)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'Source')
                ));


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'Photo')
                ));


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().button(context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is MemberProfileFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<MemberProfileListBloc>(context).add(
                          UpdateMemberProfileList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              appId: state.value!.appId, 
                              feedId: state.value!.feedId, 
                              authorId: state.value!.authorId, 
                              profile: state.value!.profile, 
                              profileBackground: state.value!.profileBackground, 
                              profileOverride: state.value!.profileOverride, 
                              nameOverride: state.value!.nameOverride, 
                              readAccess: state.value!.readAccess, 
                        )));
                      } else {
                        BlocProvider.of<MemberProfileListBloc>(context).add(
                          AddMemberProfileList(value: MemberProfileModel(
                              documentID: state.value!.documentID, 
                              appId: state.value!.appId, 
                              feedId: state.value!.feedId, 
                              authorId: state.value!.authorId, 
                              profile: state.value!.profile, 
                              profileBackground: state.value!.profileBackground, 
                              profileOverride: state.value!.profileOverride, 
                              nameOverride: state.value!.nameOverride, 
                              readAccess: state.value!.readAccess, 
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

        return StyleRegistry.registry().styleWithContext(context).adminFormStyle().container(context, Form(
            child: ListView(
              padding: const EdgeInsets.all(8),
              physics: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)) ? NeverScrollableScrollPhysics() : null,
              shrinkWrap: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)),
              children: children as List<Widget>
            ),
          ), formAction!
        );
      } else {
        return StyleRegistry.registry().styleWithContext(context).adminListStyle().progressIndicator(context);
      }
    });
  }

  void _onDocumentIDChanged() {
    _myFormBloc.add(ChangedMemberProfileDocumentID(value: _documentIDController.text));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedMemberProfileAppId(value: _appIdController.text));
  }


  void _onFeedIdChanged() {
    _myFormBloc.add(ChangedMemberProfileFeedId(value: _feedIdController.text));
  }


  void _onAuthorIdChanged() {
    _myFormBloc.add(ChangedMemberProfileAuthorId(value: _authorIdController.text));
  }


  void _onProfileChanged() {
    _myFormBloc.add(ChangedMemberProfileProfile(value: _profileController.text));
  }


  void _onProfileBackgroundSelected(String? val) {
    setState(() {
      _profileBackground = val;
    });
    _myFormBloc.add(ChangedMemberProfileProfileBackground(value: val));
  }


  void _onProfileOverrideChanged() {
    _myFormBloc.add(ChangedMemberProfileProfileOverride(value: _profileOverrideController.text));
  }


  void _onNameOverrideChanged() {
    _myFormBloc.add(ChangedMemberProfileNameOverride(value: _nameOverrideController.text));
  }


  void _onReadAccessChanged(value) {
    _myFormBloc.add(ChangedMemberProfileReadAccess(value: value));
    setState(() {});
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _appIdController.dispose();
    _feedIdController.dispose();
    _authorIdController.dispose();
    _profileController.dispose();
    _profileOverrideController.dispose();
    _nameOverrideController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, MemberProfileFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner());
  }
  

}



