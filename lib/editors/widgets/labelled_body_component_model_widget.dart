import 'package:eliud_core/core/widgets/formfields/extensiontype_formfield.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_container.dart';
import 'package:eliud_core_main/apis/style/frontend/has_dialog_field.dart';
import 'package:eliud_core_main/apis/style/frontend/has_divider.dart';
import 'package:eliud_core_main/apis/style/frontend/has_list_tile.dart';
import 'package:eliud_core_main/apis/style/frontend/has_text.dart';
import 'package:eliud_core/core/widgets/helper_widgets/header_widget.dart';
import 'package:eliud_core_main/widgets/formfields/component_id_field.dart';
import 'package:eliud_pkg_feed_model/model/labelled_body_component_model.dart';
import 'package:flutter/material.dart';

typedef LabelledBodyComponentModelCallback = void Function(
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
    required this.app,
    required this.create,
    required this.widgetWidth,
    required this.widgetHeight,
    required this.labelledBodyComponentModel,
    required this.labelledBodyComponentModelCallback,
    required this.containerPrivilege,
  });

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
                    originalValue:
                        widget.labelledBodyComponentModel.componentId,
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
