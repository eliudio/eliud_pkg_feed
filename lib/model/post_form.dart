/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_form.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/widgets/progress_indicator.dart';
import 'package:eliud_core/core/global_data.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/tools/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:eliud_core/tools/common_tools.dart';

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
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_storage/model/repository_export.dart';
import 'package:eliud_pkg_storage/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/embedded_component.dart';
import 'package:eliud_pkg_membership/model/embedded_component.dart';
import 'package:eliud_pkg_storage/model/embedded_component.dart';
import 'package:eliud_pkg_feed/model/embedded_component.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import 'package:eliud_pkg_storage/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import 'package:eliud_pkg_storage/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/post_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_list_event.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/model/post_form_bloc.dart';
import 'package:eliud_pkg_feed/model/post_form_event.dart';
import 'package:eliud_pkg_feed/model/post_form_state.dart';


class PostForm extends StatelessWidget {
  FormAction formAction;
  PostModel value;
  ActionModel submitAction;

  PostForm({Key key, @required this.formAction, @required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var app = AccessBloc.app(context);
    if (formAction == FormAction.ShowData) {
      return BlocProvider<PostFormBloc >(
            create: (context) => PostFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialisePostFormEvent(value: value)),
  
        child: MyPostForm(submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<PostFormBloc >(
            create: (context) => PostFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialisePostFormNoLoadEvent(value: value)),
  
        child: MyPostForm(submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: formAction == FormAction.UpdateAction ?
                AppBar(
                    title: Text("Update Post", style: TextStyle(color: RgbHelper.color(rgbo: app.formAppBarTextColor))),
                    flexibleSpace: Container(
                        decoration: BoxDecorationHelper.boxDecoration(accessState, app.formAppBarBackground)),
                  ) :
                AppBar(
                    title: Text("Add Post", style: TextStyle(color: RgbHelper.color(rgbo: app.formAppBarTextColor))),
                    flexibleSpace: Container(
                        decoration: BoxDecorationHelper.boxDecoration(accessState, app.formAppBarBackground)),
                ),
        body: BlocProvider<PostFormBloc >(
            create: (context) => PostFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialisePostFormEvent(value: value) : InitialiseNewPostFormEvent())),
  
        child: MyPostForm(submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyPostForm extends StatefulWidget {
  final FormAction formAction;
  final ActionModel submitAction;

  MyPostForm({this.formAction, this.submitAction});

  _MyPostFormState createState() => _MyPostFormState(this.formAction);
}


class _MyPostFormState extends State<MyPostForm> {
  final FormAction formAction;
  PostFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  String _author;
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _postAppIdController = TextEditingController();
  final TextEditingController _postPageIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _likesController = TextEditingController();
  final TextEditingController _dislikesController = TextEditingController();
  int _archivedSelectedRadioTile;
  final TextEditingController _externalLinkController = TextEditingController();


  _MyPostFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<PostFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _appIdController.addListener(_onAppIdChanged);
    _postAppIdController.addListener(_onPostAppIdChanged);
    _postPageIdController.addListener(_onPostPageIdChanged);
    _descriptionController.addListener(_onDescriptionChanged);
    _likesController.addListener(_onLikesChanged);
    _dislikesController.addListener(_onDislikesChanged);
    _archivedSelectedRadioTile = 0;
    _externalLinkController.addListener(_onExternalLinkChanged);
  }

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.app(context);
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<PostFormBloc, PostFormState>(builder: (context, state) {
      if (state is PostFormUninitialized) return Center(
        child: DelayedCircularProgressIndicator(),
      );

      if (state is PostFormLoaded) {
        if (state.value.documentID != null)
          _documentIDController.text = state.value.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value.author != null)
          _author= state.value.author.documentID;
        else
          _author= "";
        if (state.value.appId != null)
          _appIdController.text = state.value.appId.toString();
        else
          _appIdController.text = "";
        if (state.value.postAppId != null)
          _postAppIdController.text = state.value.postAppId.toString();
        else
          _postAppIdController.text = "";
        if (state.value.postPageId != null)
          _postPageIdController.text = state.value.postPageId.toString();
        else
          _postPageIdController.text = "";
        if (state.value.description != null)
          _descriptionController.text = state.value.description.toString();
        else
          _descriptionController.text = "";
        if (state.value.likes != null)
          _likesController.text = state.value.likes.toString();
        else
          _likesController.text = "";
        if (state.value.dislikes != null)
          _dislikesController.text = state.value.dislikes.toString();
        else
          _dislikesController.text = "";
        if (state.value.archived != null)
          _archivedSelectedRadioTile = state.value.archived.index;
        else
          _archivedSelectedRadioTile = 0;
        if (state.value.externalLink != null)
          _externalLinkController.text = state.value.externalLink.toString();
        else
          _externalLinkController.text = "";
      }
      if (state is PostFormInitialized) {
        List<Widget> children = List();
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text('General',
                      style: TextStyle(
                          color: RgbHelper.color(rgbo: app.formGroupTitleColor), fontWeight: FontWeight.bold)),
                ));


        children.add(

                RadioListTile(
                    value: 0,
                    activeColor: RgbHelper.color(rgbo: app.formFieldTextColor),
                    groupValue: _archivedSelectedRadioTile,
                    title: Text("Active", style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor))),
                    subtitle: Text("Active", style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor))),
                    onChanged: !accessState.memberIsOwner() ? null : (val) {
                      setSelectionArchived(val);
                    },
                ),
          );
        children.add(

                RadioListTile(
                    value: 1,
                    activeColor: RgbHelper.color(rgbo: app.formFieldTextColor),
                    groupValue: _archivedSelectedRadioTile,
                    title: Text("Archived", style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor))),
                    subtitle: Text("Archived", style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor))),
                    onChanged: !accessState.memberIsOwner() ? null : (val) {
                      setSelectionArchived(val);
                    },
                ),
          );


        children.add(Container(height: 20.0));
        children.add(Divider(height: 1.0, thickness: 1.0, color: RgbHelper.color(rgbo: app.dividerColor)));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text('General',
                      style: TextStyle(
                          color: RgbHelper.color(rgbo: app.formGroupTitleColor), fontWeight: FontWeight.bold)),
                ));

        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: (formAction == FormAction.UpdateAction),
                  controller: _documentIDController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.vpn_key, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'Document ID',
                  ),
                  keyboardType: TextInputType.text,
                  autovalidate: true,
                  validator: (_) {
                    return state is DocumentIDPostFormError ? state.message : null;
                  },
                ),
          );


        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: _readOnly(accessState, state),
                  controller: _appIdController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.text_format, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'App Identifier',
                    hintText: "This is the identifier of the app to which this feed belongs",
                  ),
                  keyboardType: TextInputType.text,
                  autovalidate: true,
                  validator: (_) {
                    return state is AppIdPostFormError ? state.message : null;
                  },
                ),
          );

        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: _readOnly(accessState, state),
                  controller: _postAppIdController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.text_format, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'Post App Identifier',
                    hintText: "This is the identifier of the app to where this feed points to",
                  ),
                  keyboardType: TextInputType.text,
                  autovalidate: true,
                  validator: (_) {
                    return state is PostAppIdPostFormError ? state.message : null;
                  },
                ),
          );

        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: _readOnly(accessState, state),
                  controller: _postPageIdController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.text_format, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'Post Page Identifier',
                    hintText: "This is the identifier of the page to where this feed points to",
                  ),
                  keyboardType: TextInputType.text,
                  autovalidate: true,
                  validator: (_) {
                    return state is PostPageIdPostFormError ? state.message : null;
                  },
                ),
          );

        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: _readOnly(accessState, state),
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.text_format, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'Description',
                  ),
                  keyboardType: TextInputType.text,
                  autovalidate: true,
                  validator: (_) {
                    return state is DescriptionPostFormError ? state.message : null;
                  },
                ),
          );

        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: _readOnly(accessState, state),
                  controller: _likesController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.text_format, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'Likes',
                  ),
                  keyboardType: TextInputType.number,
                  autovalidate: true,
                  validator: (_) {
                    return state is LikesPostFormError ? state.message : null;
                  },
                ),
          );

        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: _readOnly(accessState, state),
                  controller: _dislikesController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.text_format, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'Dislikes',
                  ),
                  keyboardType: TextInputType.number,
                  autovalidate: true,
                  validator: (_) {
                    return state is DislikesPostFormError ? state.message : null;
                  },
                ),
          );

        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: _readOnly(accessState, state),
                  controller: _externalLinkController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.text_format, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'externalLink',
                  ),
                  keyboardType: TextInputType.text,
                  autovalidate: true,
                  validator: (_) {
                    return state is ExternalLinkPostFormError ? state.message : null;
                  },
                ),
          );


        children.add(Container(height: 20.0));
        children.add(Divider(height: 1.0, thickness: 1.0, color: RgbHelper.color(rgbo: app.dividerColor)));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text('Member',
                      style: TextStyle(
                          color: RgbHelper.color(rgbo: app.formGroupTitleColor), fontWeight: FontWeight.bold)),
                ));

        children.add(

                DropdownButtonComponentFactory().createNew(id: "memberPublicInfos", value: _author, trigger: _onAuthorSelected, optional: false),
          );


        children.add(Container(height: 20.0));
        children.add(Divider(height: 1.0, thickness: 1.0, color: RgbHelper.color(rgbo: app.dividerColor)));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text('Media',
                      style: TextStyle(
                          color: RgbHelper.color(rgbo: app.formGroupTitleColor), fontWeight: FontWeight.bold)),
                ));

        children.add(

                new Container(
                    height: (fullScreenHeight(context) / 2.5), 
                    child: memberMediumsList(context, state.value.memberMedia, _onMemberMediaChanged)
                )
          );


        children.add(Container(height: 20.0));
        children.add(Divider(height: 1.0, thickness: 1.0, color: RgbHelper.color(rgbo: app.dividerColor)));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(RaisedButton(
                  color: RgbHelper.color(rgbo: app.formSubmitButtonColor),
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is PostFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<PostListBloc>(context).add(
                          UpdatePostList(value: state.value.copyWith(
                              documentID: state.value.documentID, 
                              author: state.value.author, 
                              timestamp: state.value.timestamp, 
                              appId: state.value.appId, 
                              postAppId: state.value.postAppId, 
                              postPageId: state.value.postPageId, 
                              pageParameters: state.value.pageParameters, 
                              description: state.value.description, 
                              likes: state.value.likes, 
                              dislikes: state.value.dislikes, 
                              readAccess: state.value.readAccess, 
                              archived: state.value.archived, 
                              externalLink: state.value.externalLink, 
                              memberMedia: state.value.memberMedia, 
                        )));
                      } else {
                        BlocProvider.of<PostListBloc>(context).add(
                          AddPostList(value: PostModel(
                              documentID: state.value.documentID, 
                              author: state.value.author, 
                              timestamp: state.value.timestamp, 
                              appId: state.value.appId, 
                              postAppId: state.value.postAppId, 
                              postPageId: state.value.postPageId, 
                              pageParameters: state.value.pageParameters, 
                              description: state.value.description, 
                              likes: state.value.likes, 
                              dislikes: state.value.dislikes, 
                              readAccess: state.value.readAccess, 
                              archived: state.value.archived, 
                              externalLink: state.value.externalLink, 
                              memberMedia: state.value.memberMedia, 
                          )));
                      }
                      if (widget.submitAction != null) {
                        eliudrouter.Router.navigateTo(context, widget.submitAction);
                      } else {
                        Navigator.pop(context);
                      }
                      return true;
                    }
                  },
                  child: Text('Submit', style: TextStyle(color: RgbHelper.color(rgbo: app.formSubmitButtonTextColor))),
                ));

        return Container(
          color: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)) ? Colors.transparent : null,
          decoration: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)) ? null : BoxDecorationHelper.boxDecoration(accessState, app.formBackground),
          padding:
          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            child: Form(
            child: ListView(
              padding: const EdgeInsets.all(8),
              physics: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)) ? NeverScrollableScrollPhysics() : null,
              shrinkWrap: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)),
              children: children
            ),
          )
        );
      } else {
        return DelayedCircularProgressIndicator();
      }
    });
  }

  void _onDocumentIDChanged() {
    _myFormBloc.add(ChangedPostDocumentID(value: _documentIDController.text));
  }


  void _onAuthorSelected(String val) {
    setState(() {
      _author = val;
    });
    _myFormBloc.add(ChangedPostAuthor(value: val));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedPostAppId(value: _appIdController.text));
  }


  void _onPostAppIdChanged() {
    _myFormBloc.add(ChangedPostPostAppId(value: _postAppIdController.text));
  }


  void _onPostPageIdChanged() {
    _myFormBloc.add(ChangedPostPostPageId(value: _postPageIdController.text));
  }


  void _onDescriptionChanged() {
    _myFormBloc.add(ChangedPostDescription(value: _descriptionController.text));
  }


  void _onLikesChanged() {
    _myFormBloc.add(ChangedPostLikes(value: _likesController.text));
  }


  void _onDislikesChanged() {
    _myFormBloc.add(ChangedPostDislikes(value: _dislikesController.text));
  }


  void _onReadAccessChanged(value) {
    _myFormBloc.add(ChangedPostReadAccess(value: value));
    setState(() {});
  }


  void setSelectionArchived(int val) {
    setState(() {
      _archivedSelectedRadioTile = val;
    });
    _myFormBloc.add(ChangedPostArchived(value: toPostArchiveStatus(val)));
  }


  void _onExternalLinkChanged() {
    _myFormBloc.add(ChangedPostExternalLink(value: _externalLinkController.text));
  }


  void _onMemberMediaChanged(value) {
    _myFormBloc.add(ChangedPostMemberMedia(value: value));
    setState(() {});
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _appIdController.dispose();
    _postAppIdController.dispose();
    _postPageIdController.dispose();
    _descriptionController.dispose();
    _likesController.dispose();
    _dislikesController.dispose();
    _externalLinkController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, PostFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner());
  }
  

}



