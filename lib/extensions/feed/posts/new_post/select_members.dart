import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

typedef SelectedMembersCallback(List<String> selectedMembers);

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
      required List<String>? initialMembers,
      required SelectedMembersCallback selectedMembersCallback}) {
    var memberService = MemberService(appId, feedId, memberId);
    var future = memberService.getFromIDs(initialMembers);
    return FutureBuilder<List<SelectedMember>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SelectMembersWidget._(
                appId: appId,
                feedId: feedId,
                memberId: memberId,
                initiallySelectedMembers: snapshot.data!,
                selectedMembersCallback: selectedMembersCallback,
                memberService: memberService);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class _SelectMembersWidgetState extends State<SelectMembersWidget> {
  @override
  Widget build(BuildContext context) {
    List<SelectedMember> _selectedMembers = widget.initiallySelectedMembers;

    return FlutterTagging<SelectedMember>(
        initialItems: _selectedMembers,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.green.withAlpha(30),
            hintText: 'Search Members',
            labelText: 'Select Members',
          ),
        ),
        findSuggestions: widget.memberService.getMembers,
        additionCallback: (value) {
          return SelectedMember(
            name: value,
            memberId: '0',
          );
        },
        onAdded: (member) {
          return member;
        },
        configureSuggestion: (lang) {
          return SuggestionConfiguration(
            title: Text(lang.name),
            subtitle: Text(lang.memberId),
            additionWidget: Chip(
              avatar: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
              label: Text('Add New Tag'),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
        configureChip: (lang) {
          return ChipConfiguration(
            label: Text(lang.name),
            backgroundColor: Colors.green,
            labelStyle: TextStyle(color: Colors.white),
            deleteIconColor: Colors.white,
          );
        },
        onChanged: () {});
  }
}

/// MemberService
class MemberService {
  final String appId;
  final String feedId;
  final String memberId;

  MemberService(this.appId, this.feedId, this.memberId);

  Future<List<SelectedMember>> getFromIDs(List<String>? ids) {
    /*if (ids == null) */ return Future.value(
        <SelectedMember>[SelectedMember(name: 'Java Script', memberId: '1')]);

    // 1. map the ids to id+feed
    // 2. query where id in that list from 1.
    // 3. map to SelectedMember

//    return null;
  }

  Future<List<SelectedMember>> getMembers(String query) async {
    var membersValues = await memberProfileRepository(appId: appId)!.valuesList(
          eliudQuery: EliudQuery()
              .withCondition(EliudQueryCondition('feedId', isEqualTo: feedId))
              .withCondition(EliudQueryCondition('readAccess',
              arrayContainsAny: [memberId, 'PUBLIC'])));

    var values2 = <SelectedMember>[];
    if (query.length > 0) {
      membersValues.forEach((value) {
        if (value!.nameOverride != null) {
          if (value!.nameOverride!.contains(query)) {
            var selectedMember = SelectedMember(
                memberId: value!.authorId != null
                    ? value!.authorId!
                    : 'no author id',
                name: value.nameOverride != null
                    ? value.nameOverride!
                    : 'no name');
            values2.add(selectedMember);
          }
        }
      });
    } else {
      membersValues.forEach((value) {
        var selectedMember = SelectedMember(
            memberId: value!.authorId != null
                ? value!.authorId!
                : 'no authord id',
            name: value.nameOverride != null ? value.nameOverride! : 'no name');
        values2.add(selectedMember);
      });
    }

    return values2;
  }
}

class SelectedMember extends Taggable {
  final String memberId;
  final String name;

  SelectedMember({
    required this.memberId,
    required this.name,
  });

  @override
  List<Object> get props => [memberId, name];
}
