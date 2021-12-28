/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_medium_form.dart
                       
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

import 'package:eliud_pkg_feed/model/post_medium_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_medium_list_event.dart';
import 'package:eliud_pkg_feed/model/post_medium_model.dart';
import 'package:eliud_pkg_feed/model/post_medium_form_bloc.dart';
import 'package:eliud_pkg_feed/model/post_medium_form_event.dart';
import 'package:eliud_pkg_feed/model/post_medium_form_state.dart';


class PostMediumForm extends StatelessWidget {
  final AppModel app;
  FormAction formAction;
  PostMediumModel? value;
  ActionModel? submitAction;

  PostMediumForm({Key? key, required this.app, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var appId = app.documentID!;
    if (formAction == FormAction.ShowData) {
      return BlocProvider<PostMediumFormBloc >(
            create: (context) => PostMediumFormBloc(appId,
                                       
                                                )..add(InitialisePostMediumFormEvent(value: value)),
  
        child: MyPostMediumForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<PostMediumFormBloc >(
            create: (context) => PostMediumFormBloc(appId,
                                       
                                                )..add(InitialisePostMediumFormNoLoadEvent(value: value)),
  
        child: MyPostMediumForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithApp(app).adminFormStyle().appBarWithString(app, context, title: formAction == FormAction.UpdateAction ? 'Update PostMedium' : 'Add PostMedium'),
        body: BlocProvider<PostMediumFormBloc >(
            create: (context) => PostMediumFormBloc(appId,
                                       
                                                )..add((formAction == FormAction.UpdateAction ? InitialisePostMediumFormEvent(value: value) : InitialiseNewPostMediumFormEvent())),
  
        child: MyPostMediumForm(app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyPostMediumForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyPostMediumForm({required this.app, this.formAction, this.submitAction});

  _MyPostMediumFormState createState() => _MyPostMediumFormState(this.formAction);
}


class _MyPostMediumFormState extends State<MyPostMediumForm> {
  final FormAction? formAction;
  late PostMediumFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  String? _memberMedium;


  _MyPostMediumFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<PostMediumFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<PostMediumFormBloc, PostMediumFormState>(builder: (context, state) {
      if (state is PostMediumFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context),
      );

      if (state is PostMediumFormLoaded) {
        if (state.value!.documentID != null)
          _documentIDController.text = state.value!.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value!.memberMedium != null)
          _memberMedium= state.value!.memberMedium!.documentID;
        else
          _memberMedium= "";
      }
      if (state is PostMediumFormInitialized) {
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
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'Image')
                ));

        children.add(

                DropdownButtonComponentFactory().createNew(app: widget.app, id: "memberMediums", value: _memberMedium, trigger: _onMemberMediumSelected, optional: true),
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().button(widget.app, context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is PostMediumFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<PostMediumListBloc>(context).add(
                          UpdatePostMediumList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              memberMedium: state.value!.memberMedium, 
                        )));
                      } else {
                        BlocProvider.of<PostMediumListBloc>(context).add(
                          AddPostMediumList(value: PostMediumModel(
                              documentID: state.value!.documentID, 
                              memberMedium: state.value!.memberMedium, 
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
    _myFormBloc.add(ChangedPostMediumDocumentID(value: _documentIDController.text));
  }


  void _onMemberMediumSelected(String? val) {
    setState(() {
      _memberMedium = val;
    });
    _myFormBloc.add(ChangedPostMediumMemberMedium(value: val));
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, PostMediumFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner(widget.app.documentID!));
  }
  

}



