/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_like_form.dart
                       
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
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/repository_export.dart';
import 'package:eliud_core/model/embedded_component.dart';
import 'package:eliud_pkg_membership/model/embedded_component.dart';
import 'package:eliud_pkg_feed/model/embedded_component.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_feed/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_feed/model/entity_export.dart';

import 'package:eliud_pkg_feed/model/post_like_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_like_list_event.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_like_form_bloc.dart';
import 'package:eliud_pkg_feed/model/post_like_form_event.dart';
import 'package:eliud_pkg_feed/model/post_like_form_state.dart';


class PostLikeForm extends StatelessWidget {
  final AppModel app;
  FormAction formAction;
  PostLikeModel? value;
  ActionModel? submitAction;

  PostLikeForm({Key? key, required this.app, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var appId = app.documentID!;
    if (formAction == FormAction.ShowData) {
      return BlocProvider<PostLikeFormBloc >(
            create: (context) => PostLikeFormBloc(appId,
                                       formAction: formAction,

                                                )..add(InitialisePostLikeFormEvent(value: value)),
  
        child: MyPostLikeForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<PostLikeFormBloc >(
            create: (context) => PostLikeFormBloc(appId,
                                       formAction: formAction,

                                                )..add(InitialisePostLikeFormNoLoadEvent(value: value)),
  
        child: MyPostLikeForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithApp(app).adminFormStyle().appBarWithString(app, context, title: formAction == FormAction.UpdateAction ? 'Update PostLike' : 'Add PostLike'),
        body: BlocProvider<PostLikeFormBloc >(
            create: (context) => PostLikeFormBloc(appId,
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialisePostLikeFormEvent(value: value) : InitialiseNewPostLikeFormEvent())),
  
        child: MyPostLikeForm(app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyPostLikeForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyPostLikeForm({required this.app, this.formAction, this.submitAction});

  _MyPostLikeFormState createState() => _MyPostLikeFormState(this.formAction);
}


class _MyPostLikeFormState extends State<MyPostLikeForm> {
  final FormAction? formAction;
  late PostLikeFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _postIdController = TextEditingController();
  final TextEditingController _postCommentIdController = TextEditingController();
  final TextEditingController _memberIdController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  int? _likeTypeSelectedRadioTile;


  _MyPostLikeFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<PostLikeFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _postIdController.addListener(_onPostIdChanged);
    _postCommentIdController.addListener(_onPostCommentIdChanged);
    _memberIdController.addListener(_onMemberIdChanged);
    _appIdController.addListener(_onAppIdChanged);
    _likeTypeSelectedRadioTile = 0;
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<PostLikeFormBloc, PostLikeFormState>(builder: (context, state) {
      if (state is PostLikeFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context),
      );

      if (state is PostLikeFormLoaded) {
        if (state.value!.documentID != null)
          _documentIDController.text = state.value!.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value!.postId != null)
          _postIdController.text = state.value!.postId.toString();
        else
          _postIdController.text = "";
        if (state.value!.postCommentId != null)
          _postCommentIdController.text = state.value!.postCommentId.toString();
        else
          _postCommentIdController.text = "";
        if (state.value!.memberId != null)
          _memberIdController.text = state.value!.memberId.toString();
        else
          _memberIdController.text = "";
        if (state.value!.appId != null)
          _appIdController.text = state.value!.appId.toString();
        else
          _appIdController.text = "";
        if (state.value!.likeType != null)
          _likeTypeSelectedRadioTile = state.value!.likeType!.index;
        else
          _likeTypeSelectedRadioTile = 0;
      }
      if (state is PostLikeFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().radioListTile(widget.app, context, 0, _likeTypeSelectedRadioTile, 'Like', 'Like', !accessState.memberIsOwner(widget.app.documentID!) ? null : (dynamic val) => setSelectionLikeType(val))
          );
        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().radioListTile(widget.app, context, 0, _likeTypeSelectedRadioTile, 'Dislike', 'Dislike', !accessState.memberIsOwner(widget.app.documentID!) ? null : (dynamic val) => setSelectionLikeType(val))
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'Document ID', icon: Icons.vpn_key, readOnly: (formAction == FormAction.UpdateAction), textEditingController: _documentIDController, keyboardType: TextInputType.text, validator: (_) => state is DocumentIDPostLikeFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'Document ID of the post', icon: Icons.vpn_key, readOnly: _readOnly(accessState, state), textEditingController: _postIdController, keyboardType: TextInputType.text, validator: (_) => state is PostIdPostLikeFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'Document ID of the comment (in case of a like on a comment)', icon: Icons.vpn_key, readOnly: _readOnly(accessState, state), textEditingController: _postCommentIdController, keyboardType: TextInputType.text, validator: (_) => state is PostCommentIdPostLikeFormError ? state.message : null, hintText: null)
          );


        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'App Identifier', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _appIdController, keyboardType: TextInputType.text, validator: (_) => state is AppIdPostLikeFormError ? state.message : null, hintText: 'field.remark')
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'Member')
                ));

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'Member', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _memberIdController, keyboardType: TextInputType.text, validator: (_) => state is MemberIdPostLikeFormError ? state.message : null, hintText: null)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().button(widget.app, context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is PostLikeFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<PostLikeListBloc>(context).add(
                          UpdatePostLikeList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              postId: state.value!.postId, 
                              postCommentId: state.value!.postCommentId, 
                              memberId: state.value!.memberId, 
                              timestamp: state.value!.timestamp, 
                              appId: state.value!.appId, 
                              likeType: state.value!.likeType, 
                        )));
                      } else {
                        BlocProvider.of<PostLikeListBloc>(context).add(
                          AddPostLikeList(value: PostLikeModel(
                              documentID: state.value!.documentID, 
                              postId: state.value!.postId, 
                              postCommentId: state.value!.postCommentId, 
                              memberId: state.value!.memberId, 
                              timestamp: state.value!.timestamp, 
                              appId: state.value!.appId, 
                              likeType: state.value!.likeType, 
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
    _myFormBloc.add(ChangedPostLikeDocumentID(value: _documentIDController.text));
  }


  void _onPostIdChanged() {
    _myFormBloc.add(ChangedPostLikePostId(value: _postIdController.text));
  }


  void _onPostCommentIdChanged() {
    _myFormBloc.add(ChangedPostLikePostCommentId(value: _postCommentIdController.text));
  }


  void _onMemberIdChanged() {
    _myFormBloc.add(ChangedPostLikeMemberId(value: _memberIdController.text));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedPostLikeAppId(value: _appIdController.text));
  }


  void setSelectionLikeType(int? val) {
    setState(() {
      _likeTypeSelectedRadioTile = val;
    });
    _myFormBloc.add(ChangedPostLikeLikeType(value: toLikeType(val)));
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _postIdController.dispose();
    _postCommentIdController.dispose();
    _memberIdController.dispose();
    _appIdController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, PostLikeFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner(widget.app.documentID!));
  }
  

}



