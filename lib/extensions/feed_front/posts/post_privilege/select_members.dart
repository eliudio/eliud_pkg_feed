import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core_helpers/etc/random.dart';
import 'package:flutter/material.dart';

import 'bloc/member_service.dart';

typedef SelectedMembersCallback = Function(List<String> selectedMembers);

// Perpahs we should only show followed members?
class SelectMembersWidget extends StatefulWidget {
  final AppModel app;
  final String feedId;
  final String memberId;
  final List<SelectedMember> initiallySelectedMembers;
  final SelectedMembersCallback selectedMembersCallback;
  final MemberService memberService;

  const SelectMembersWidget._(
      {required this.app,
      required this.feedId,
      required this.memberId,
      required this.initiallySelectedMembers,
      required this.selectedMembersCallback,
      required this.memberService});

  @override
  State<StatefulWidget> createState() {
    return _SelectMembersWidgetState();
  }

  static Widget get(
      {required AppModel app,
      required String feedId,
      required String memberId,
      required List<SelectedMember>? specificSelectedMembers,
      required SelectedMembersCallback selectedMembersCallback}) {
    var memberService = MemberService(app, feedId, memberId);
    specificSelectedMembers ??= <SelectedMember>[];

    return SelectMembersWidget._(
        app: app,
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
    return FutureBuilder<List<SelectedMember>>(
        future: widget.memberService.getMembers(null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TheRealSelectMembersWidget(
              initiallySelectedMembers: widget.initiallySelectedMembers,
              selectedMembersCallback: widget.selectedMembersCallback,
              allMembers: snapshot.data!,
            );
          } else {
            return progressIndicator(widget.app, context);
          }
        });
  }
}

class TheRealSelectMembersWidget extends StatefulWidget {
  final List<SelectedMember> initiallySelectedMembers;
  final SelectedMembersCallback selectedMembersCallback;
  final List<SelectedMember> allMembers;

  const TheRealSelectMembersWidget(
      {super.key,
      required this.initiallySelectedMembers,
      required this.selectedMembersCallback,
      required this.allMembers});

  @override
  State<StatefulWidget> createState() => _TheRealSelectMembersWidgetState();
}

class _TheRealSelectMembersWidgetState
    extends State<TheRealSelectMembersWidget> {
  @override
  Widget build(BuildContext context) {
    List<SelectedMember> selectedMembers = widget.initiallySelectedMembers;
    throw "Not available ChipsInput";
/*    return ChipsInput<SelectedMember>(
//    maxChips: 3, // remove, if you like infinity number of chips
      initialValue: selectedMembers,
      findSuggestions: (String query) {
        var selectedMembersS = selectedMembers.map((e) => e.memberId).toList();
        List<SelectedMember> remaining = [];
        for (var element in widget.allMembers) {
          if (!selectedMembersS.contains(element.memberId)) {
            if ((query.isEmpty) ||
                (element.name.toLowerCase().startsWith(query))) {
              remaining.add(element);
            }
          }
        }
        return remaining;
      },
      onChanged: (List<SelectedMember> data) {
        var distinct = data.toSet().toList();
        widget
            .selectedMembersCallback(distinct.map((e) => e.memberId).toList());
      },
      chipBuilder: (context, state, SelectedMember selectedMember) {
        return InputChip(
          key: ObjectKey("$selectedMember-${newRandomKey()}"),
          label: Text(selectedMember.name),
          avatar: selectedMember.imageURL == null
              ? null
              : CircleAvatar(
                  backgroundImage: NetworkImage(selectedMember.imageURL!),
                ),
          onDeleted: () => state.deleteChip(selectedMember),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      },
      suggestionBuilder: (context, SelectedMember selectedMember) {
        return ListTile(
          key: ObjectKey(selectedMember),
          leading: selectedMember.imageURL == null
              ? null
              : CircleAvatar(
                  backgroundImage: NetworkImage(selectedMember.imageURL!),
                ),
          title: Text(selectedMember.name),
          subtitle: Text(selectedMember.memberId),
        );
      },
    );*/
  }
}
