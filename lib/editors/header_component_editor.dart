import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:flutter/material.dart';

class HeaderComponentEditorConstructor extends ComponentEditorConstructor {
  @override
  void updateComponent(BuildContext context, model, EditorFeedback feedback) {
    openErrorDialog(context, title: 'Problem', errorMessage: 'No editor for this component available yet');
  }

  @override
  void createNewComponent(BuildContext context, EditorFeedback feedback) {
    openErrorDialog(context, title: 'Problem', errorMessage: 'No editor for this component available yet');
  }

  @override
  void updateComponentWithID(BuildContext context, String id, EditorFeedback feedback) {
    openErrorDialog(context, title: 'Problem', errorMessage: 'No editor for this component available yet');
  }
}
