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

import 'package:eliud_pkg_feed/model/post_list_bloc.dart';
import 'package:eliud_pkg_feed/model/post_list_event.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/model/post_form_bloc.dart';
import 'package:eliud_pkg_feed/model/post_form_event.dart';
import 'package:eliud_pkg_feed/model/post_form_state.dart';


class PostForm extends StatelessWidget {
  FormAction formAction;
  PostModel? value;
  ActionModel? submitAction;

  PostForm({Key? key, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var app = AccessBloc.app(context);
    if (app == null) return Text("No app available");
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
        appBar: StyleRegistry.registry().styleWithContext(context).adminFormStyle().constructAppBar(context, formAction == FormAction.UpdateAction ? 'Update Post' : 'Add Post'),
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
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyPostForm({this.formAction, this.submitAction});

  _MyPostFormState createState() => _MyPostFormState(this.formAction);
}


class _MyPostFormState extends State<MyPostForm> {
  final FormAction? formAction;
  late PostFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  String? _author;
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _feedIdController = TextEditingController();
  final TextEditingController _postAppIdController = TextEditingController();
  final TextEditingController _postPageIdController = TextEditingController();
  final TextEditingController _htmlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _likesController = TextEditingController();
  final TextEditingController _dislikesController = TextEditingController();
  int? _archivedSelectedRadioTile;
  final TextEditingController _externalLinkController = TextEditingController();


  _MyPostFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<PostFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _appIdController.addListener(_onAppIdChanged);
    _feedIdController.addListener(_onFeedIdChanged);
    _postAppIdController.addListener(_onPostAppIdChanged);
    _postPageIdController.addListener(_onPostPageIdChanged);
    _htmlController.addListener(_onHtmlChanged);
    _descriptionController.addListener(_onDescriptionChanged);
    _likesController.addListener(_onLikesChanged);
    _dislikesController.addListener(_onDislikesChanged);
    _archivedSelectedRadioTile = 0;
    _externalLinkController.addListener(_onExternalLinkChanged);
  }

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.app(context);
    if (app == null) return Text('No app available');
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<PostFormBloc, PostFormState>(builder: (context, state) {
      if (state is PostFormUninitialized) return Center(
        child: DelayedCircularProgressIndicator(),
      );

      if (state is PostFormLoaded) {
        if (state.value!.documentID != null)
          _documentIDController.text = state.value!.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value!.author != null)
          _author= state.value!.author!.documentID;
        else
          _author= "";
        if (state.value!.appId != null)
          _appIdController.text = state.value!.appId.toString();
        else
          _appIdController.text = "";
        if (state.value!.feedId != null)
          _feedIdController.text = state.value!.feedId.toString();
        else
          _feedIdController.text = "";
        if (state.value!.postAppId != null)
          _postAppIdController.text = state.value!.postAppId.toString();
        else
          _postAppIdController.text = "";
        if (state.value!.postPageId != null)
          _postPageIdController.text = state.value!.postPageId.toString();
        else
          _postPageIdController.text = "";
        if (state.value!.html != null)
          _htmlController.text = state.value!.html.toString();
        else
          _htmlController.text = "";
        if (state.value!.description != null)
          _descriptionController.text = state.value!.description.toString();
        else
          _descriptionController.text = "";
        if (state.value!.likes != null)
          _likesController.text = state.value!.likes.toString();
        else
          _likesController.text = "";
        if (state.value!.dislikes != null)
          _dislikesController.text = state.value!.dislikes.toString();
        else
          _dislikesController.text = "";
        if (state.value!.archived != null)
          _archivedSelectedRadioTile = state.value!.archived!.index;
        else
          _archivedSelectedRadioTile = 0;
        if (state.value!.externalLink != null)
          _externalLinkController.text = state.value!.externalLink.toString();
        else
          _externalLinkController.text = "";
      }
      if (state is PostFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));


        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().radioListTile(context, 0, _archivedSelectedRadioTile, 'Active', 'Active', !accessState.memberIsOwner() ? null : (dynamic val) => setSelectionArchived(val))
          );
        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().radioListTile(context, 0, _archivedSelectedRadioTile, 'Archived', 'Archived', !accessState.memberIsOwner() ? null : (dynamic val) => setSelectionArchived(val))
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, 'Document ID', Icons.vpn_key, (formAction == FormAction.UpdateAction), _documentIDController, FieldType.String, validator: (_) => state is DocumentIDPostFormError ? state.message : null, hintText: 'null')
          );


        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, 'App Identifier', Icons.text_format, _readOnly(accessState, state), _appIdController, FieldType.String, validator: (_) => state is AppIdPostFormError ? state.message : null, hintText: 'This is the identifier of the app to which this feed belongs')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, 'Feed Identifier', Icons.text_format, _readOnly(accessState, state), _feedIdController, FieldType.String, validator: (_) => state is FeedIdPostFormError ? state.message : null, hintText: 'This is the identifier of the feed (optional as a post can also be used in an album)')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, 'Post App Identifier', Icons.text_format, _readOnly(accessState, state), _postAppIdController, FieldType.String, validator: (_) => state is PostAppIdPostFormError ? state.message : null, hintText: 'This is the identifier of the app to where this feed points to')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, 'Post Page Identifier', Icons.text_format, _readOnly(accessState, state), _postPageIdController, FieldType.String, validator: (_) => state is PostPageIdPostFormError ? state.message : null, hintText: 'This is the identifier of the page to where this feed points to')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, 'Rich Text', Icons.text_format, _readOnly(accessState, state), _htmlController, FieldType.String, validator: (_) => state is HtmlPostFormError ? state.message : null, hintText: 'null')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, 'Description', Icons.text_format, _readOnly(accessState, state), _descriptionController, FieldType.String, validator: (_) => state is DescriptionPostFormError ? state.message : null, hintText: 'null')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, 'Likes', Icons.text_format, _readOnly(accessState, state), _likesController, FieldType.Int, validator: (_) => state is LikesPostFormError ? state.message : null, hintText: 'null')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, 'Dislikes', Icons.text_format, _readOnly(accessState, state), _dislikesController, FieldType.Int, validator: (_) => state is DislikesPostFormError ? state.message : null, hintText: 'null')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, 'externalLink', Icons.text_format, _readOnly(accessState, state), _externalLinkController, FieldType.String, validator: (_) => state is ExternalLinkPostFormError ? state.message : null, hintText: 'null')
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'Member')
                ));

        children.add(

                DropdownButtonComponentFactory().createNew(id: "memberPublicInfos", value: _author, trigger: _onAuthorSelected, optional: false),
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'Media')
                ));

        children.add(

                new Container(
                    height: (fullScreenHeight(context) / 2.5), 
                    child: postMediumsList(context, state.value!.memberMedia, _onMemberMediaChanged)
                )
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().submitButton(context, 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is PostFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<PostListBloc>(context).add(
                          UpdatePostList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              author: state.value!.author, 
                              timestamp: state.value!.timestamp, 
                              appId: state.value!.appId, 
                              feedId: state.value!.feedId, 
                              postAppId: state.value!.postAppId, 
                              postPageId: state.value!.postPageId, 
                              pageParameters: state.value!.pageParameters, 
                              html: state.value!.html, 
                              description: state.value!.description, 
                              likes: state.value!.likes, 
                              dislikes: state.value!.dislikes, 
                              readAccess: state.value!.readAccess, 
                              archived: state.value!.archived, 
                              externalLink: state.value!.externalLink, 
                              memberMedia: state.value!.memberMedia, 
                        )));
                      } else {
                        BlocProvider.of<PostListBloc>(context).add(
                          AddPostList(value: PostModel(
                              documentID: state.value!.documentID, 
                              author: state.value!.author, 
                              timestamp: state.value!.timestamp, 
                              appId: state.value!.appId, 
                              feedId: state.value!.feedId, 
                              postAppId: state.value!.postAppId, 
                              postPageId: state.value!.postPageId, 
                              pageParameters: state.value!.pageParameters, 
                              html: state.value!.html, 
                              description: state.value!.description, 
                              likes: state.value!.likes, 
                              dislikes: state.value!.dislikes, 
                              readAccess: state.value!.readAccess, 
                              archived: state.value!.archived, 
                              externalLink: state.value!.externalLink, 
                              memberMedia: state.value!.memberMedia, 
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
        return DelayedCircularProgressIndicator();
      }
    });
  }

  void _onDocumentIDChanged() {
    _myFormBloc.add(ChangedPostDocumentID(value: _documentIDController.text));
  }


  void _onAuthorSelected(String? val) {
    setState(() {
      _author = val;
    });
    _myFormBloc.add(ChangedPostAuthor(value: val));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedPostAppId(value: _appIdController.text));
  }


  void _onFeedIdChanged() {
    _myFormBloc.add(ChangedPostFeedId(value: _feedIdController.text));
  }


  void _onPostAppIdChanged() {
    _myFormBloc.add(ChangedPostPostAppId(value: _postAppIdController.text));
  }


  void _onPostPageIdChanged() {
    _myFormBloc.add(ChangedPostPostPageId(value: _postPageIdController.text));
  }


  void _onHtmlChanged() {
    _myFormBloc.add(ChangedPostHtml(value: _htmlController.text));
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


  void setSelectionArchived(int? val) {
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
    _feedIdController.dispose();
    _postAppIdController.dispose();
    _postPageIdController.dispose();
    _htmlController.dispose();
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



