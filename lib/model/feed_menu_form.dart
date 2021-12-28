/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_menu_form.dart
                       
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

import 'package:eliud_pkg_feed/model/feed_menu_list_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_menu_list_event.dart';
import 'package:eliud_pkg_feed/model/feed_menu_model.dart';
import 'package:eliud_pkg_feed/model/feed_menu_form_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_menu_form_event.dart';
import 'package:eliud_pkg_feed/model/feed_menu_form_state.dart';


class FeedMenuForm extends StatelessWidget {
  final AppModel app;
  FormAction formAction;
  FeedMenuModel? value;
  ActionModel? submitAction;

  FeedMenuForm({Key? key, required this.app, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var appId = app.documentID!;
    if (formAction == FormAction.ShowData) {
      return BlocProvider<FeedMenuFormBloc >(
            create: (context) => FeedMenuFormBloc(appId,
                                       formAction: formAction,

                                                )..add(InitialiseFeedMenuFormEvent(value: value)),
  
        child: MyFeedMenuForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<FeedMenuFormBloc >(
            create: (context) => FeedMenuFormBloc(appId,
                                       formAction: formAction,

                                                )..add(InitialiseFeedMenuFormNoLoadEvent(value: value)),
  
        child: MyFeedMenuForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithApp(app).adminFormStyle().appBarWithString(app, context, title: formAction == FormAction.UpdateAction ? 'Update FeedMenu' : 'Add FeedMenu'),
        body: BlocProvider<FeedMenuFormBloc >(
            create: (context) => FeedMenuFormBloc(appId,
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialiseFeedMenuFormEvent(value: value) : InitialiseNewFeedMenuFormEvent())),
  
        child: MyFeedMenuForm(app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyFeedMenuForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyFeedMenuForm({required this.app, this.formAction, this.submitAction});

  _MyFeedMenuFormState createState() => _MyFeedMenuFormState(this.formAction);
}


class _MyFeedMenuFormState extends State<MyFeedMenuForm> {
  final FormAction? formAction;
  late FeedMenuFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _menuCurrentMember;
  String? _menuOtherMember;
  String? _feed;


  _MyFeedMenuFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<FeedMenuFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _appIdController.addListener(_onAppIdChanged);
    _descriptionController.addListener(_onDescriptionChanged);
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<FeedMenuFormBloc, FeedMenuFormState>(builder: (context, state) {
      if (state is FeedMenuFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context),
      );

      if (state is FeedMenuFormLoaded) {
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
        if (state.value!.menuCurrentMember != null)
          _menuCurrentMember= state.value!.menuCurrentMember!.documentID;
        else
          _menuCurrentMember= "";
        if (state.value!.menuOtherMember != null)
          _menuOtherMember= state.value!.menuOtherMember!.documentID;
        else
          _menuOtherMember= "";
        if (state.value!.feed != null)
          _feed= state.value!.feed!.documentID;
        else
          _feed= "";
      }
      if (state is FeedMenuFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'General')
                ));

        children.add(

                DropdownButtonComponentFactory().createNew(app: widget.app, id: "menuDefs", value: _menuCurrentMember, trigger: _onMenuCurrentMemberSelected, optional: true),
          );

        children.add(

                DropdownButtonComponentFactory().createNew(app: widget.app, id: "menuDefs", value: _menuOtherMember, trigger: _onMenuOtherMemberSelected, optional: true),
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'Document ID', icon: Icons.vpn_key, readOnly: (formAction == FormAction.UpdateAction), textEditingController: _documentIDController, keyboardType: TextInputType.text, validator: (_) => state is DocumentIDFeedMenuFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'App Identifier', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _appIdController, keyboardType: TextInputType.text, validator: (_) => state is AppIdFeedMenuFormError ? state.message : null, hintText: 'field.remark')
          );

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'Description', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _descriptionController, keyboardType: TextInputType.text, validator: (_) => state is DescriptionFeedMenuFormError ? state.message : null, hintText: null)
          );

        children.add(

                DropdownButtonComponentFactory().createNew(app: widget.app, id: "feeds", value: _feed, trigger: _onFeedSelected, optional: false),
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'Icon Colors')
                ));

        children.add(

                RgbField(widget.app, "Text color", state.value!.itemColor, _onItemColorChanged)
          );

        children.add(

                RgbField(widget.app, "Selected Item Color", state.value!.selectedItemColor, _onSelectedItemColorChanged)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'Menu Colors')
                ));


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
                    if (state is FeedMenuFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<FeedMenuListBloc>(context).add(
                          UpdateFeedMenuList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              appId: state.value!.appId, 
                              description: state.value!.description, 
                              menuCurrentMember: state.value!.menuCurrentMember, 
                              menuOtherMember: state.value!.menuOtherMember, 
                              itemColor: state.value!.itemColor, 
                              selectedItemColor: state.value!.selectedItemColor, 
                              feed: state.value!.feed, 
                              conditions: state.value!.conditions, 
                        )));
                      } else {
                        BlocProvider.of<FeedMenuListBloc>(context).add(
                          AddFeedMenuList(value: FeedMenuModel(
                              documentID: state.value!.documentID, 
                              appId: state.value!.appId, 
                              description: state.value!.description, 
                              menuCurrentMember: state.value!.menuCurrentMember, 
                              menuOtherMember: state.value!.menuOtherMember, 
                              itemColor: state.value!.itemColor, 
                              selectedItemColor: state.value!.selectedItemColor, 
                              feed: state.value!.feed, 
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
    _myFormBloc.add(ChangedFeedMenuDocumentID(value: _documentIDController.text));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedFeedMenuAppId(value: _appIdController.text));
  }


  void _onDescriptionChanged() {
    _myFormBloc.add(ChangedFeedMenuDescription(value: _descriptionController.text));
  }


  void _onMenuCurrentMemberSelected(String? val) {
    setState(() {
      _menuCurrentMember = val;
    });
    _myFormBloc.add(ChangedFeedMenuMenuCurrentMember(value: val));
  }


  void _onMenuOtherMemberSelected(String? val) {
    setState(() {
      _menuOtherMember = val;
    });
    _myFormBloc.add(ChangedFeedMenuMenuOtherMember(value: val));
  }


  void _onItemColorChanged(value) {
    _myFormBloc.add(ChangedFeedMenuItemColor(value: value));
    
  }


  void _onSelectedItemColorChanged(value) {
    _myFormBloc.add(ChangedFeedMenuSelectedItemColor(value: value));
    
  }


  void _onFeedSelected(String? val) {
    setState(() {
      _feed = val;
    });
    _myFormBloc.add(ChangedFeedMenuFeed(value: val));
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _appIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, FeedMenuFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner(widget.app.documentID!));
  }
  

}



