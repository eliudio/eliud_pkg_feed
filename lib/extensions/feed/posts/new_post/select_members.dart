import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

typedef SelectedMembersCallback(List<String> selectedMembers);

/// Language Class
class SelectedMember extends Taggable {
  ///
  final String name;

  ///
  final int position;

  /// Creates Language
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
  @override
  State<StatefulWidget> createState() {
    return _SelectMembersWidgetState();
  }

  static Widget get() {
    return SelectMembersWidget();
  }
}

class _SelectMembersWidgetState extends State<SelectMembersWidget> {
  @override
  Widget build(BuildContext context) {
    List<SelectedMember> _selectedLanguages = [];

    return FlutterTagging<SelectedMember>(
        initialItems: _selectedLanguages,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.green.withAlpha(30),
            hintText: 'Search Tags',
            labelText: 'Select Tags',
          ),
        ),
        findSuggestions: LanguageService.getLanguages,
        additionCallback: (value) {
          return SelectedMember(
            name: value,
            position: 0,
          );
        },
        onAdded: (language) {

          // api calls here, triggered when add to tag button is pressed
          return language;
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

/// LanguageService
class LanguageService {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<SelectedMember>> getLanguages(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <SelectedMember>[
      SelectedMember(name: 'JavaScript', position: 1),
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

