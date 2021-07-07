import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

/// Language Class
class SelectedMember extends Taggable {
  ///
  final String name;

  /// Creates Language
  SelectedMember({
    required this.name,
  });

  @override
  List<Object> get props => [name];

  /// Converts the class to json string.
  String toJson() => '''  {
    "name": $name,\n
  }''';
}

class SelectMembersWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectMembersWidgetState();
  }
}

class _SelectMembersWidgetState extends State<SelectMembersWidget> {
  @override
  Widget build(BuildContext context) {
    List<SelectedMember> _selectedLanguages = [];

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlutterTagging<SelectedMember>(
              initialItems: _selectedLanguages,
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.green.withAlpha(30),
                  hintText: 'Search Members',
                  labelText: 'Select Members',
                ),
              ),
              findSuggestions: LanguageService.getLanguages,
              additionCallback: (value) {
                return SelectedMember(
                  name: value,
                );
              },
              configureSuggestion: (lang) {
                return SuggestionConfiguration(
                  title: Text(lang.name),
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
                print(_selectedLanguages);
              }),
        ),
      ],
    );
  }
}

/// LanguageService
class LanguageService {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<SelectedMember>> getLanguages(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <SelectedMember>[
      SelectedMember(name: 'JavaScript'),
      SelectedMember(name: 'Python'),
      SelectedMember(name: 'Java'),
      SelectedMember(name: 'PHP'),
      SelectedMember(name: 'C#'),
      SelectedMember(name: 'C++'),
    ]
        .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
