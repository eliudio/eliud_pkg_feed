import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/decoration/decoration.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/app_policy_item_model.dart';
import 'package:eliud_core/model/platform_medium_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/component_id_field.dart';
import 'package:eliud_core/tools/extensiontype_formfield.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_core/tools/storage/public_medium_helper.dart';
import 'package:eliud_core/tools/widgets/editor/select_action_widget.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_core/tools/widgets/pos_size_widget.dart';
import 'package:eliud_pkg_etc/model/member_action_model.dart';
import 'package:eliud_pkg_feed/model/labelled_body_component_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

typedef void LabelledBodyComponentModelCallback(
    LabelledBodyComponentModel labelledBodyComponentModel);

class LabelledBodyComponentModelWidget extends StatefulWidget {
  final bool create;
  final double widgetWidth;
  final double widgetHeight;
  final AppModel app;
  final LabelledBodyComponentModel labelledBodyComponentModel;
  final LabelledBodyComponentModelCallback labelledBodyComponentModelCallback;
  final int containerPrivilege;

  LabelledBodyComponentModelWidget._({
    Key? key,
    required this.app,
    required this.create,
    required this.widgetWidth,
    required this.widgetHeight,
    required this.labelledBodyComponentModel,
    required this.labelledBodyComponentModelCallback,
    required this.containerPrivilege,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LabelledBodyComponentModelWidgetState();
  }

  static Widget getIt(
      BuildContext context,
      AppModel app,
      bool create,
      double widgetWidth,
      double widgetHeight,
      LabelledBodyComponentModel labelledBodyComponentModel,
      LabelledBodyComponentModelCallback labelledBodyComponentModelCallback,
      int containerPrivilege) {
    var copyOf = labelledBodyComponentModel.copyWith();
    return LabelledBodyComponentModelWidget._(
      app: app,
      create: create,
      widgetWidth: widgetWidth,
      widgetHeight: widgetHeight,
      labelledBodyComponentModel: copyOf,
      labelledBodyComponentModelCallback: labelledBodyComponentModelCallback,
      containerPrivilege: containerPrivilege,
    );
  }
}

class _LabelledBodyComponentModelWidgetState
    extends State<LabelledBodyComponentModelWidget> {
  int? currentPrivilegeLevel;

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
      HeaderWidget(
        app: widget.app,
        cancelAction: () async {
          return true;
        },
        okAction: () async {
          widget.labelledBodyComponentModelCallback(
              widget.labelledBodyComponentModel);
          return true;
        },
        title: 'Tabbed Contents',
      ),
      divider(widget.app, context),
      topicContainer(widget.app, context,
          title: 'General',
          collapsible: true,
          collapsed: true,
          children: [
            getListTile(context, widget.app,
                leading: Icon(Icons.vpn_key),
                title: text(widget.app, context,
                    widget.labelledBodyComponentModel.documentID)),
          ]),
      topicContainer(widget.app, context,
          title: 'Contents',
          collapsible: true,
          collapsed: true,
          children: [
            getListTile(context, widget.app,
                leading: Icon(Icons.description),
                title: dialogField(
                  widget.app,
                  context,
                  initialValue: widget.labelledBodyComponentModel.label,
                  valueChanged: (value) {
                    widget.labelledBodyComponentModel.label = value;
                  },
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'Label',
                    labelText: 'Label',
                  ),
                )),
            getListTile(context, widget.app,
                leading: Icon(Icons.description),
                title: ExtensionTypeField(
                    widget.app, widget.labelledBodyComponentModel.componentName,
                    (newValue) {
                  setState(() {
                    widget.labelledBodyComponentModel.componentName = newValue;
                  });
                })),
            getListTile(context, widget.app,
                leading: Icon(Icons.description),
                title: ComponentIdField(widget.app,
                    componentName:
                        widget.labelledBodyComponentModel.componentName,
                    value: widget.labelledBodyComponentModel.componentId,
                    currentPrivilegeLevel: currentPrivilegeLevel,
                    trigger: (value, privilegeLevel) {
                  setState(() {
                    if (value != null) {
                      widget.labelledBodyComponentModel.componentId = value;
                    }
                    if (privilegeLevel != null) {
                      currentPrivilegeLevel = privilegeLevel;
                      widget.labelledBodyComponentModel.componentId = null;
                    }
                  });
                })),
          ]),
    ]);
  }
}
