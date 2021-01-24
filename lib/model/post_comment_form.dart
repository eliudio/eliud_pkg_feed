/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 post_comment_form.dart
                       
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

import 'package:eliud_pkg_feed/model/post_comment_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_comment_list_event.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_comment_form_bloc.dart';
import 'package:eliud_pkg_feed/model/post_comment_form_event.dart';
import 'package:eliud_pkg_feed/model/post_comment_form_state.dart';


class PostCommentForm extends StatelessWidget {
  FormAction formAction;
  PostCommentModel value;
  ActionModel submitAction;

  PostCommentForm({Key key, @required this.formAction, @required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var app = AccessBloc.app(context);
    if (formAction == FormAction.ShowData) {
      return BlocProvider<PostCommentFormBloc >(
            create: (context) => PostCommentFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialisePostCommentFormEvent(value: value)),
  
        child: MyPostCommentForm(submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<PostCommentFormBloc >(
            create: (context) => PostCommentFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialisePostCommentFormNoLoadEvent(value: value)),
  
        child: MyPostCommentForm(submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: formAction == FormAction.UpdateAction ?
                AppBar(
                    title: Text("Update PostComment", style: TextStyle(color: RgbHelper.color(rgbo: app.formAppBarTextColor))),
                    flexibleSpace: Container(
                        decoration: BoxDecorationHelper.boxDecoration(accessState, app.formAppBarBackground)),
                  ) :
                AppBar(
                    title: Text("Add PostComment", style: TextStyle(color: RgbHelper.color(rgbo: app.formAppBarTextColor))),
                    flexibleSpace: Container(
                        decoration: BoxDecorationHelper.boxDecoration(accessState, app.formAppBarBackground)),
                ),
        body: BlocProvider<PostCommentFormBloc >(
            create: (context) => PostCommentFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialisePostCommentFormEvent(value: value) : InitialiseNewPostCommentFormEvent())),
  
        child: MyPostCommentForm(submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyPostCommentForm extends StatefulWidget {
  final FormAction formAction;
  final ActionModel submitAction;

  MyPostCommentForm({this.formAction, this.submitAction});

  _MyPostCommentFormState createState() => _MyPostCommentFormState(this.formAction);
}


class _MyPostCommentFormState extends State<MyPostCommentForm> {
  final FormAction formAction;
  PostCommentFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _postIdController = TextEditingController();
  final TextEditingController _memberIdController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();


  _MyPostCommentFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<PostCommentFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _postIdController.addListener(_onPostIdChanged);
    _memberIdController.addListener(_onMemberIdChanged);
    _appIdController.addListener(_onAppIdChanged);
    _commentController.addListener(_onCommentChanged);
  }

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.app(context);
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<PostCommentFormBloc, PostCommentFormState>(builder: (context, state) {
      if (state is PostCommentFormUninitialized) return Center(
        child: DelayedCircularProgressIndicator(),
      );

      if (state is PostCommentFormLoaded) {
        if (state.value.documentID != null)
          _documentIDController.text = state.value.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value.postId != null)
          _postIdController.text = state.value.postId.toString();
        else
          _postIdController.text = "";
        if (state.value.memberId != null)
          _memberIdController.text = state.value.memberId.toString();
        else
          _memberIdController.text = "";
        if (state.value.appId != null)
          _appIdController.text = state.value.appId.toString();
        else
          _appIdController.text = "";
        if (state.value.comment != null)
          _commentController.text = state.value.comment.toString();
        else
          _commentController.text = "";
      }
      if (state is PostCommentFormInitialized) {
        List<Widget> children = List();
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
                    return state is DocumentIDPostCommentFormError ? state.message : null;
                  },
                ),
          );

        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: _readOnly(accessState, state),
                  controller: _postIdController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.vpn_key, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'Document ID of the post',
                  ),
                  keyboardType: TextInputType.text,
                  autovalidate: true,
                  validator: (_) {
                    return state is PostIdPostCommentFormError ? state.message : null;
                  },
                ),
          );

        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: _readOnly(accessState, state),
                  controller: _memberIdController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.text_format, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'Member',
                  ),
                  keyboardType: TextInputType.text,
                  autovalidate: true,
                  validator: (_) {
                    return state is MemberIdPostCommentFormError ? state.message : null;
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
                    return state is AppIdPostCommentFormError ? state.message : null;
                  },
                ),
          );

        children.add(

                TextFormField(
                style: TextStyle(color: RgbHelper.color(rgbo: app.formFieldTextColor)),
                  readOnly: _readOnly(accessState, state),
                  controller: _commentController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldTextColor))),                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: RgbHelper.color(rgbo: app.formFieldFocusColor))),                    icon: Icon(Icons.text_format, color: RgbHelper.color(rgbo: app.formFieldHeaderColor)),
                    labelText: 'Comment',
                  ),
                  keyboardType: TextInputType.text,
                  autovalidate: true,
                  validator: (_) {
                    return state is CommentPostCommentFormError ? state.message : null;
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


        children.add(Container(height: 20.0));
        children.add(Divider(height: 1.0, thickness: 1.0, color: RgbHelper.color(rgbo: app.dividerColor)));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(RaisedButton(
                  color: RgbHelper.color(rgbo: app.formSubmitButtonColor),
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is PostCommentFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<PostCommentListBloc>(context).add(
                          UpdatePostCommentList(value: state.value.copyWith(
                              documentID: state.value.documentID, 
                              postId: state.value.postId, 
                              memberId: state.value.memberId, 
                              timestamp: state.value.timestamp, 
                              appId: state.value.appId, 
                              comment: state.value.comment, 
                        )));
                      } else {
                        BlocProvider.of<PostCommentListBloc>(context).add(
                          AddPostCommentList(value: PostCommentModel(
                              documentID: state.value.documentID, 
                              postId: state.value.postId, 
                              memberId: state.value.memberId, 
                              timestamp: state.value.timestamp, 
                              appId: state.value.appId, 
                              comment: state.value.comment, 
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
    _myFormBloc.add(ChangedPostCommentDocumentID(value: _documentIDController.text));
  }


  void _onPostIdChanged() {
    _myFormBloc.add(ChangedPostCommentPostId(value: _postIdController.text));
  }


  void _onMemberIdChanged() {
    _myFormBloc.add(ChangedPostCommentMemberId(value: _memberIdController.text));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedPostCommentAppId(value: _appIdController.text));
  }


  void _onCommentChanged() {
    _myFormBloc.add(ChangedPostCommentComment(value: _commentController.text));
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _postIdController.dispose();
    _memberIdController.dispose();
    _appIdController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, PostCommentFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner());
  }
  

}



