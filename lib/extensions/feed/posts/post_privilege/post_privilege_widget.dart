import 'dart:math';

import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/select_members.dart';
import 'package:eliud_pkg_feed/tools/etc/post_followers_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/post_privilege_event.dart';
import 'bloc/post_privilege_state.dart';

class PostPrivilegeWidget extends StatefulWidget {
  final String appId;
  final String feedId;
  final String memberId;
  final String? currentMemberId;
  final bool canEdit;

  PostPrivilegeWidget(this.appId, this.feedId, this.memberId, this.currentMemberId, this.canEdit);

  _PostPrivilegeWidgetState createState() => _PostPrivilegeWidgetState();
}

class _PostPrivilegeWidgetState extends State<PostPrivilegeWidget> {
  int? _postPrivilegeSelectedRadioTile;

  _PostPrivilegeWidgetState();

  @override
  void initState() {
    super.initState();
    _postPrivilegeSelectedRadioTile = 0;
  }

  RadioListTile _radioPrivilegeTile(
      String text, int value) {
    return /*Flexible(
      fit: FlexFit.loose,
      child: */
      RadioListTile(
          contentPadding: EdgeInsets.all(0),
          dense: true,
          value: value,
          groupValue: _postPrivilegeSelectedRadioTile,
          title: StyleRegistry.registry()
              .styleWithContext(context)
              .frontEndStyle()
              .textStyle()
              .text(context, text),
          onChanged: (dynamic value) {
            _setPostSelectedRadioTile(value);
          }) /*,
    )*/
    ;
  }

  Widget _getList(RadioListTile tile1, RadioListTile tile2, RadioListTile tile3,
      RadioListTile tile4) {
    return Flexible(
        fit: FlexFit.loose,
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) return tile1;
            if (index == 1) return tile2;
            if (index == 2) return tile3;
            if (index == 3) return tile4;
            return Text("not expected");
          },
          itemCount: 4,
          shrinkWrap: true,
          physics: ScrollPhysics(),
        ));
  }

  static final SPACE_INBETWEEN = 10.0;
  static double width(BuildContext context) => max(
      (MediaQuery.of(context).size.width * 0.9 - 2 * SPACE_INBETWEEN) / 2, 200);

  Widget _editableAudience(PostPrivilege postPrivilege) {
    var col1 =_getList(
        _radioPrivilegeTile('Public', 0),
        _radioPrivilegeTile('Followers', 1),
        _radioPrivilegeTile('Specific People', 2),
        _radioPrivilegeTile('Just Me', 3));

    // specific followers
    if (_postPrivilegeSelectedRadioTile == 2) {
      var col2 = Container(
          height: 200,
          width: 200,
          child: SingleChildScrollView(child:SelectMembersWidget.get(
            appId: widget.appId,
            feedId: widget.feedId,
            memberId: widget.currentMemberId!,
            selectedMembersCallback: _selectedMembersCallback,
            initialMembers:
            postPrivilege.specificFollowers,
          )));
      return Row(children: [
        spacer(),
        col1,
/*
        Spacer(),
*/
        col2,
        spacer()
      ]);
//      return Row(children: [col1, col2]);
    } else {
      return Row(children: [        spacer()
        ,col1]);
    }
  }

  Widget _displayAudience(PostPrivilege postPrivilege) {
    switch (postPrivilege.postPrivilegeType) {
      case PostPrivilegeType.Public:
        return Center(child: StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle()
            .text(context, 'Accessible by public'));
      case PostPrivilegeType.Followers:
        return Center(child: StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle()
            .text(context, 'Accessible by your followers',
            maxLines: 5));
      case PostPrivilegeType.SpecificPeople:
        return Center(child: StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle()
            .text(context, 'Accessible by '));
      case PostPrivilegeType.JustMe:
        return Center(child: StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle()
            .text(context, 'Accessible by you'));
    }
  }

  Widget spacer() {
    return Container(width: SPACE_INBETWEEN);
  }

  void _selectedMembersCallback(List<String> selectedMembers) {
    BlocProvider.of<PostPrivilegeBloc>(context).add(
        ChangedPostPrivilege(value: 2, specificFollowers: selectedMembers));
  }

  void _setPostSelectedRadioTile(int? val) {
    if (val != null) {
      setState(() {
        _postPrivilegeSelectedRadioTile = val;
      });
      BlocProvider.of<PostPrivilegeBloc>(context).add(
          ChangedPostPrivilege(value: val));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostPrivilegeBloc, PostPrivilegeState>(
        builder: (context, state) {
          if (state is PostPrivilegeInitialized) {
            if (widget.canEdit) {
              return _editableAudience(state.postPrivilege);
            } else {
              return _displayAudience(state.postPrivilege);
            }
          } else {
            return StyleRegistry.registry()
                .styleWithContext(context)
                .frontEndStyle()
                .progressIndicatorStyle()
                .progressIndicator(context);
          }
        });
  }
}
