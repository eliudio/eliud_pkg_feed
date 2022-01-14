import 'dart:math';

import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart' as tx;
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/bloc/post_privilege_bloc.dart';
import 'package:eliud_pkg_feed/extensions/feed/posts/post_privilege/select_members.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/member_service.dart';
import 'bloc/post_privilege_event.dart';
import 'bloc/post_privilege_state.dart';

class PostPrivilegeWidget extends StatefulWidget {
  final AppModel app;
  final String feedId;
  final String memberId;
  final String? currentMemberId;
  final bool canEdit;

  PostPrivilegeWidget(this.app, this.feedId, this.memberId,
      this.currentMemberId, this.canEdit, );

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

  RadioListTile _radioPrivilegeTile(String text, int value, bool selected) {
    return /*Flexible(
      fit: FlexFit.loose,
      child: */
        RadioListTile(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            value: value,
            selected: selected,
            groupValue: _postPrivilegeSelectedRadioTile,
            title: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .frontEndStyle()
                .textStyle()
                .text(widget.app, context, text),
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

  Widget _editableAudience(PostAccessibleByGroup postAccessibleByGroup,
      List<SelectedMember>? specificSelectedMembers) {

    var col1 = _getList(
        _radioPrivilegeTile('Public', 0, PostAccessibleByGroup.Public.index == PostAccessibleByGroup.Public),
        _radioPrivilegeTile('Followers', 1, PostAccessibleByGroup.Followers.index == PostAccessibleByGroup.Followers),
        _radioPrivilegeTile('Just Me', 2, PostAccessibleByGroup.Me.index == PostAccessibleByGroup.Me),
      _radioPrivilegeTile('Specific People', PostAccessibleByGroup.SpecificMembers.index, postAccessibleByGroup == PostAccessibleByGroup.SpecificMembers),
    );

    // specific followers
    if (_postPrivilegeSelectedRadioTile == PostAccessibleByGroup.SpecificMembers.index) {
      var col2 = Container(
          height: 300,
          width: width(context),
          child: SingleChildScrollView(
              child: SelectMembersWidget.get(
            app: widget.app,
            feedId: widget.feedId,
            memberId: widget.currentMemberId!,
            selectedMembersCallback: _selectedMembersCallback,
            specificSelectedMembers: specificSelectedMembers,
          )));
      return Row(children: [spacer(), col1, spacer(), col2, spacer()]);
    } else {
      return Row(children: [spacer(), col1]);
    }
  }

  Widget _displayAudience(PostAccessibleByGroup postAccessibleByGroup,
      List<SelectedMember>? specificSelectedMembers) {
    switch (postAccessibleByGroup) {
      case PostAccessibleByGroup.Public:
        return Center(
            child: tx.text(widget.app, context, 'Accessible by public'));
      case PostAccessibleByGroup.Followers:
        return Center(
            child: tx.text(widget.app, context, 'Accessible by your followers', maxLines: 5));
      case PostAccessibleByGroup.SpecificMembers:
        var names;
        if (specificSelectedMembers != null) {
          names = specificSelectedMembers.map((e) => e.name).join(", ");
        }
        return Center(
            child: tx.text(widget.app, context, 'Accessible by ' + names));
      case PostAccessibleByGroup.Me:
        return Center(
            child: tx.text(widget.app, context, 'Accessible by you'));
    }
    return Center(
        child: tx.text(widget.app, context, 'Accessible not determined'));
  }

  Widget spacer() {
    return Container(width: SPACE_INBETWEEN);
  }

  void _selectedMembersCallback(List<String> selectedMembers) {
    BlocProvider.of<PostPrivilegeBloc>(context).add(
        ChangedPostPrivilege(postAccessibleByGroup: PostAccessibleByGroup.SpecificMembers, postAccessibleByMembers: selectedMembers));
  }

  void _setPostSelectedRadioTile(int? val) {
    BlocProvider.of<PostPrivilegeBloc>(context)
          .add(ChangedPostPrivilege.get(val));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostPrivilegeBloc, PostPrivilegeState>(
        builder: (context, state) {
      if (state is PostPrivilegeInitialized) {
        _postPrivilegeSelectedRadioTile = state.postAccessibleByGroup.index;
        if (widget.canEdit) {
          return _editableAudience(
              state.postAccessibleByGroup, state.specificSelectedMembers);
        } else {
          return _displayAudience(
              state.postAccessibleByGroup, state.specificSelectedMembers);
        }
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }
}
