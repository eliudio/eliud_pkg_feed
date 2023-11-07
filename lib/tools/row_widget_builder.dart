import 'package:flutter/cupertino.dart';

class RowWidgetBuilder {
  double rowHeight;
  double rowSpace;
  double widgetWidth;
  double widgetHeight;
  double minSpace;
  List<Widget> widgets = [];

  RowWidgetBuilder(
      {required this.rowHeight,
      required this.rowSpace,
      required this.widgetWidth,
      required this.widgetHeight,
      required this.minSpace});

  void add(Widget widget) {
    widgets.add(widget);
  }

  Widget constructWidgets(BuildContext context) {
    List<List<Widget>> rows = [];
    int row = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    int amountPerRow = (screenWidth / (widgetWidth + minSpace)).floor();
    int colCount = 1;
    int totalCount = 1;
    rows.add([]);
    for (var widget in widgets) {
      rows[row].add(Spacer());
      rows[row].add(
          Container(width: widgetWidth, height: widgetHeight, child: widget));
      if ((colCount == amountPerRow) && (totalCount != widgets.length)) {
        rows[row].add(Spacer());
        colCount = 1;
        row++;
        rows.add([]);
      } else {
        colCount++;
      }
      totalCount++;
    }
    rows[row].add(Spacer());

    List<Widget> mappedIntoRows = rows
        .map((v) => Container(
            height: rowHeight,
            child: Container(
                height: rowHeight + rowSpace, child: Row(children: v))))
        .toList();
    return Column(children: mappedIntoRows);
  }
}
