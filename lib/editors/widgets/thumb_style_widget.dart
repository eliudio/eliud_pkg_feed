import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_list_tile.dart';
import 'package:eliud_pkg_feed_model/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ThumbStyleCallback = Function(ThumbStyle thumbStyle);

class ThumbStyleWidget extends StatefulWidget {
  final ThumbStyleCallback thumbStyleCallback;
  final ThumbStyle thumbStyle;
  final AppModel app;
  ThumbStyleWidget(
      {super.key,
      required this.app,
      required this.thumbStyleCallback,
      required this.thumbStyle});

  @override
  State<StatefulWidget> createState() {
    return _ThumbStyleWidgetState();
  }
}

class _ThumbStyleWidgetState extends State<ThumbStyleWidget> {
  int? _heightTypeSelectedRadioTile;

  @override
  void initState() {
    super.initState();
    _heightTypeSelectedRadioTile = widget.thumbStyle.index;
  }

  String heightTypeLandscapeStringValue(ThumbStyle? thumbStyle) {
    switch (thumbStyle) {
      case ThumbStyle.thumbs:
        return 'Thumbs';
      case ThumbStyle.banana:
        return 'Banana';
      case ThumbStyle.unknown:
        break;
      case null:
        break;
    }
    return '?';
  }

  void setSelection(int? val) {
    setState(() {
      _heightTypeSelectedRadioTile = val;
      widget.thumbStyleCallback(toThumbStyle(val));
    });
  }

  Widget getPrivilegeOption(ThumbStyle? thumbStyle) {
    if (thumbStyle == null) return Text("?");
    var stringValue = heightTypeLandscapeStringValue(thumbStyle);
    return Center(
        child: radioListTile(
            widget.app,
            context,
            thumbStyle.index,
            _heightTypeSelectedRadioTile,
            stringValue,
            null,
            (dynamic val) => setSelection(val)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      getPrivilegeOption(ThumbStyle.thumbs),
      getPrivilegeOption(ThumbStyle.banana)
    ], shrinkWrap: true, physics: ScrollPhysics());
  }
}
