import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

import 'bloc/member_service.dart';

typedef SelectedMembersCallback(List<String> selectedMembers);

// Perpahs we should only show followed members?
class SelectMembersWidget extends StatefulWidget {
  final String appId;
  final String feedId;
  final String memberId;
  final List<SelectedMember> initiallySelectedMembers;
  final SelectedMembersCallback selectedMembersCallback;
  final MemberService memberService;

  const SelectMembersWidget._(
      {Key? key,
      required this.appId,
      required this.feedId,
      required this.memberId,
      required this.initiallySelectedMembers,
      required this.selectedMembersCallback,
      required this.memberService})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectMembersWidgetState();
  }

  static Widget get(
      {required String appId,
      required String feedId,
      required String memberId,
      required List<SelectedMember>? specificSelectedMembers,
      required SelectedMembersCallback selectedMembersCallback}) {
    var memberService = MemberService(appId, feedId, memberId);
    if (specificSelectedMembers == null)
      specificSelectedMembers = <SelectedMember>[];
    return SelectMembersWidget._(
        appId: appId,
        feedId: feedId,
        memberId: memberId,
        initiallySelectedMembers: specificSelectedMembers,
        selectedMembersCallback: selectedMembersCallback,
        memberService: memberService);
  }
}

class _SelectMembersWidgetState extends State<SelectMembersWidget> {
  @override
  Widget build(BuildContext context) {
    List<SelectedMember> _selectedMembers = widget.initiallySelectedMembers;

    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.all(0.0),
          child: FlutterTagging<SelectedMember>(
              initialItems: _selectedMembers,
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey.withAlpha(30),
                  hintText: 'Search Members',
                  labelText: 'Select Members',
                ),
              ),
              findSuggestions: widget.memberService.getMembers,
              onAdded: (member) {
                return member;
              },
              configureSuggestion: (lang) {
                return SuggestionConfiguration(
                  title: text(context, lang.name),
                  subtitle: text(context, lang.memberId),
                );
              },
              configureChip: (lang) {
                return ChipConfiguration(
                  label: Text(lang.name),
                  backgroundColor: Colors.grey,
                  labelStyle: TextStyle(color: Colors.white),
                  deleteIconColor: Colors.white,
                );
              },
              onChanged: () {
                var iDs = _selectedMembers
                    .map((selectedMember) => selectedMember.memberId)
                    .toList();
                widget.selectedMembersCallback(iDs);
              })),
/*
      SizedBox(
        height: 20.0,
      ),
*/
    ]);
  }
}
