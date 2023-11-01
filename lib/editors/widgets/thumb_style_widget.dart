import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_pkg_feed/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ThumbStyleCallback = Function(
    ThumbStyle thumbStyle);

class ThumbStyleWidget extends StatefulWidget {
  ThumbStyleCallback thumbStyleCallback;
  final ThumbStyle thumbStyle;
  final AppModel app;
  ThumbStyleWidget(
      {Key? key,
        required this.app,
        required this.thumbStyleCallback,
        required this.thumbStyle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ThumbStyleWidgetState();
  }
}

class _ThumbStyleWidgetState extends State<ThumbStyleWidget> {
  int? _heightTypeSelectedRadioTile;

  void initState() {
    super.initState();
    _heightTypeSelectedRadioTile = widget.thumbStyle.index;
  }

  String heighttTypeLandscapeStringValue(ThumbStyle? thumbStyle) {
    switch (thumbStyle) {
      case ThumbStyle.Thumbs:
        return 'Thumbs';
      case ThumbStyle.Banana:
        return 'Banana';
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
    var stringValue = heighttTypeLandscapeStringValue(thumbStyle);
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
      getPrivilegeOption(ThumbStyle.Thumbs),
      getPrivilegeOption(ThumbStyle.Banana)
    ], shrinkWrap: true, physics: ScrollPhysics());
  }
}
