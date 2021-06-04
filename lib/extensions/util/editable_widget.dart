import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';

import 'mediua_buttons.dart';

typedef EditFunction();

class EditableWidget1 extends StatelessWidget {
  final Widget child;
  final EditFunction? editFunction;

  const EditableWidget1(
      {Key? key, required this.child, this.editFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editFunction != null) {
      return Stack(
        children: [
          child,
          Align(
              alignment: Alignment.topRight,
              child:
                  EditableButton1(editFunction: editFunction!)),
        ],
      );
    } else {
      return child;
    }
  }
}

class EditableButton1 extends StatelessWidget {
  final EditFunction? editFunction;

  const EditableButton1({Key? key, required this.editFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 17,
        backgroundColor: Colors.black,
        child: IconButton(
                icon: Icon(Icons.edit, size: 14, color: Colors.white),
                onPressed: () => editFunction!(),
              ));
  }
}

class EditableWidget2 extends StatelessWidget {
  final Widget child;
  final Widget? button;

  const EditableWidget2(
      {Key? key, required this.child, this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (button != null) {
      return Stack(
        children: [
          child,
          Align(
              alignment: Alignment.topRight,
              child:
              EditableButton2(button: button!)),
        ],
      );
    } else {
      return child;
    }
  }
}

class EditableButton2 extends StatelessWidget {
  final Widget button;

  const EditableButton2({Key? key, required this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 17,
        backgroundColor: Colors.black,
        child: button);
  }
}
