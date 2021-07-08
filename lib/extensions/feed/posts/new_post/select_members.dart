import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

typedef SelectedMembersCallback(List<String> selectedMembers);

class SelectedMember extends Taggable {
  ///
  final String name;

  ///
  final int position;

  SelectedMember({
    required this.name,
    required this.position,
  });

  @override
  List<Object> get props => [name];

  /// Converts the class to json string.
  String toJson() => '''  {
    "name": $name,\n
    "position": $position\n
  }''';
}


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
        findSuggestions: MemberService.getMembers,
        additionCallback: (value) {
          return SelectedMember(
            name: value,
            position: 0,
          );
        },
        onAdded: (member) {

          return member;
        },
        configureSuggestion: (lang) {
          return SuggestionConfiguration(
            title: Text(lang.name),
            subtitle: Text(lang.position.toString()),
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
        onChanged: () {
        });
  }
}

/// MemberService
class MemberService {
  final String appId;
  final String feedId;
  final String memberId;

  MemberService(this.appId, this.feedId, this.memberId);

  Future<List<SelectedMember>> getFromIDs(List<String>? ids) {
    /*if (ids == null) */ return Future.value(<SelectedMember>[SelectedMember(name: 'Java Script', position: 1)]);

    // 1. map the ids to id+feed
    // 2. query where id in that list from 1.
    // 3. map to SelectedMember

//    return null;
  }

  static Future<List<SelectedMember>> getMembers(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <SelectedMember>[
      SelectedMember(name: 'Java Script', position: 1),
      SelectedMember(name: 'Python', position: 2),
      SelectedMember(name: 'Java', position: 3),
      SelectedMember(name: 'PHP', position: 4),
      SelectedMember(name: 'C#', position: 5),
      SelectedMember(name: 'C++', position: 6),
    ]
        .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

