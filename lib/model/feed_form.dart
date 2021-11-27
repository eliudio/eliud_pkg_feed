/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 feed_form.dart
                       
 This code is generated. This is read only. Don't touch!

*/

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

import 'package:eliud_pkg_feed/model/feed_list_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_list_event.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:eliud_pkg_feed/model/feed_form_bloc.dart';
import 'package:eliud_pkg_feed/model/feed_form_event.dart';
import 'package:eliud_pkg_feed/model/feed_form_state.dart';


class FeedForm extends StatelessWidget {
  FormAction formAction;
  FeedModel? value;
  ActionModel? submitAction;

  FeedForm({Key? key, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var app = AccessBloc.currentApp(context);
    if (app == null) return Text("No app available");
    var appId = app.documentID!;
    if (formAction == FormAction.ShowData) {
      return BlocProvider<FeedFormBloc >(
            create: (context) => FeedFormBloc(appId,
                                       formAction: formAction,

                                                )..add(InitialiseFeedFormEvent(value: value)),
  
        child: MyFeedForm(submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<FeedFormBloc >(
            create: (context) => FeedFormBloc(appId,
                                       formAction: formAction,

                                                )..add(InitialiseFeedFormNoLoadEvent(value: value)),
  
        child: MyFeedForm(submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithContext(context).adminFormStyle().appBarWithString(context, title: formAction == FormAction.UpdateAction ? 'Update Feed' : 'Add Feed'),
        body: BlocProvider<FeedFormBloc >(
            create: (context) => FeedFormBloc(appId,
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialiseFeedFormEvent(value: value) : InitialiseNewFeedFormEvent())),
  
        child: MyFeedForm(submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyFeedForm extends StatefulWidget {
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyFeedForm({this.formAction, this.submitAction});

  _MyFeedFormState createState() => _MyFeedFormState(this.formAction);
}


class _MyFeedFormState extends State<MyFeedForm> {
  final FormAction? formAction;
  late FeedFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int? _thumbImageSelectedRadioTile;
  bool? _photoPostSelection;
  bool? _videoPostSelection;
  bool? _messagePostSelection;
  bool? _audioPostSelection;
  bool? _albumPostSelection;
  bool? _articlePostSelection;


  _MyFeedFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<FeedFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _appIdController.addListener(_onAppIdChanged);
    _descriptionController.addListener(_onDescriptionChanged);
    _thumbImageSelectedRadioTile = 0;
    _photoPostSelection = false;
    _videoPostSelection = false;
    _messagePostSelection = false;
    _audioPostSelection = false;
    _albumPostSelection = false;
    _articlePostSelection = false;
  }

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.currentApp(context);
    if (app == null) return Text('No app available');
    var appId = app.documentID!;
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<FeedFormBloc, FeedFormState>(builder: (context, state) {
      if (state is FeedFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithContext(context).adminListStyle().progressIndicator(context),
      );

      if (state is FeedFormLoaded) {
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
        if (state.value!.thumbImage != null)
          _thumbImageSelectedRadioTile = state.value!.thumbImage!.index;
        else
          _thumbImageSelectedRadioTile = 0;
        if (state.value!.photoPost != null)
        _photoPostSelection = state.value!.photoPost;
        else
        _photoPostSelection = false;
        if (state.value!.videoPost != null)
        _videoPostSelection = state.value!.videoPost;
        else
        _videoPostSelection = false;
        if (state.value!.messagePost != null)
        _messagePostSelection = state.value!.messagePost;
        else
        _messagePostSelection = false;
        if (state.value!.audioPost != null)
        _audioPostSelection = state.value!.audioPost;
        else
        _audioPostSelection = false;
        if (state.value!.albumPost != null)
        _albumPostSelection = state.value!.albumPost;
        else
        _albumPostSelection = false;
        if (state.value!.articlePost != null)
        _articlePostSelection = state.value!.articlePost;
        else
        _articlePostSelection = false;
      }
      if (state is FeedFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().radioListTile(context, 0, _thumbImageSelectedRadioTile, 'Thumbs', 'Thumbs', !accessState.memberIsOwner(AccessBloc.currentAppId(context)) ? null : (dynamic val) => setSelectionThumbImage(val))
          );
        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().radioListTile(context, 0, _thumbImageSelectedRadioTile, 'Banana', 'Banana', !accessState.memberIsOwner(AccessBloc.currentAppId(context)) ? null : (dynamic val) => setSelectionThumbImage(val))
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().checkboxListTile(context, 'Photo Post', _photoPostSelection, _readOnly(accessState, state) ? null : (dynamic val) => setSelectionPhotoPost(val))
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().checkboxListTile(context, 'Video Post', _videoPostSelection, _readOnly(accessState, state) ? null : (dynamic val) => setSelectionVideoPost(val))
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().checkboxListTile(context, 'Message Post', _messagePostSelection, _readOnly(accessState, state) ? null : (dynamic val) => setSelectionMessagePost(val))
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().checkboxListTile(context, 'Audio Post', _audioPostSelection, _readOnly(accessState, state) ? null : (dynamic val) => setSelectionAudioPost(val))
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().checkboxListTile(context, 'Album Post', _albumPostSelection, _readOnly(accessState, state) ? null : (dynamic val) => setSelectionAlbumPost(val))
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().checkboxListTile(context, 'Article Post', _articlePostSelection, _readOnly(accessState, state) ? null : (dynamic val) => setSelectionArticlePost(val))
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Document ID', icon: Icons.vpn_key, readOnly: (formAction == FormAction.UpdateAction), textEditingController: _documentIDController, keyboardType: TextInputType.text, validator: (_) => state is DocumentIDFeedFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'App Identifier', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _appIdController, keyboardType: TextInputType.text, validator: (_) => state is AppIdFeedFormError ? state.message : null, hintText: 'field.remark')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Description', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _descriptionController, keyboardType: TextInputType.text, validator: (_) => state is DescriptionFeedFormError ? state.message : null, hintText: null)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'Conditions')
                ));



        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().button(context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is FeedFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<FeedListBloc>(context).add(
                          UpdateFeedList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              appId: state.value!.appId, 
                              description: state.value!.description, 
                              thumbImage: state.value!.thumbImage, 
                              photoPost: state.value!.photoPost, 
                              videoPost: state.value!.videoPost, 
                              messagePost: state.value!.messagePost, 
                              audioPost: state.value!.audioPost, 
                              albumPost: state.value!.albumPost, 
                              articlePost: state.value!.articlePost, 
                              conditions: state.value!.conditions, 
                        )));
                      } else {
                        BlocProvider.of<FeedListBloc>(context).add(
                          AddFeedList(value: FeedModel(
                              documentID: state.value!.documentID, 
                              appId: state.value!.appId, 
                              description: state.value!.description, 
                              thumbImage: state.value!.thumbImage, 
                              photoPost: state.value!.photoPost, 
                              videoPost: state.value!.videoPost, 
                              messagePost: state.value!.messagePost, 
                              audioPost: state.value!.audioPost, 
                              albumPost: state.value!.albumPost, 
                              articlePost: state.value!.articlePost, 
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
    _myFormBloc.add(ChangedFeedDocumentID(value: _documentIDController.text));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedFeedAppId(value: _appIdController.text));
  }


  void _onDescriptionChanged() {
    _myFormBloc.add(ChangedFeedDescription(value: _descriptionController.text));
  }


  void setSelectionThumbImage(int? val) {
    setState(() {
      _thumbImageSelectedRadioTile = val;
    });
    _myFormBloc.add(ChangedFeedThumbImage(value: toThumbStyle(val)));
  }


  void setSelectionPhotoPost(bool? val) {
    setState(() {
      _photoPostSelection = val;
    });
    _myFormBloc.add(ChangedFeedPhotoPost(value: val));
  }

  void setSelectionVideoPost(bool? val) {
    setState(() {
      _videoPostSelection = val;
    });
    _myFormBloc.add(ChangedFeedVideoPost(value: val));
  }

  void setSelectionMessagePost(bool? val) {
    setState(() {
      _messagePostSelection = val;
    });
    _myFormBloc.add(ChangedFeedMessagePost(value: val));
  }

  void setSelectionAudioPost(bool? val) {
    setState(() {
      _audioPostSelection = val;
    });
    _myFormBloc.add(ChangedFeedAudioPost(value: val));
  }

  void setSelectionAlbumPost(bool? val) {
    setState(() {
      _albumPostSelection = val;
    });
    _myFormBloc.add(ChangedFeedAlbumPost(value: val));
  }

  void setSelectionArticlePost(bool? val) {
    setState(() {
      _articlePostSelection = val;
    });
    _myFormBloc.add(ChangedFeedArticlePost(value: val));
  }


  @override
  void dispose() {
    _documentIDController.dispose();
    _appIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, FeedFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner(AccessBloc.currentAppId(context)));
  }
  

}



