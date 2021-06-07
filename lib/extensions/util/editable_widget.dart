import 'package:eliud_pkg_feed/extensions/util/post_helper.dart';
import 'package:flutter/material.dart';

typedef EditFunction();

// Puts an edit button top right on a widget
class EditableWidget extends StatelessWidget {
  final Widget child;
  final Widget button;

  const EditableWidget({Key? key, required this.child, required this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Align(
            alignment: Alignment.topRight,
            child: EditableButton(button: button)),
      ],
    );
  }
}

class EditableButton extends StatelessWidget {
  final Widget button;

  const EditableButton({Key? key, required this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 18, backgroundColor: Colors.black, child: button);
  }
}

Widget getEditIcon({EditAction? onPressed}) {
  var pen = Image.asset("assets/images/segoshvishna.fiverr.com/pen128.png",
      package: "eliud_pkg_feed");
  double size = 33;
  return GestureDetector(
      child: Container(
          height: size,
          width: size,
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: pen),
          ),
      onTap: onPressed);
}
