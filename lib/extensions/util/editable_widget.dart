import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';

typedef EditFunction();

class EditableWidget extends StatelessWidget {
  final Widget child;
  final EditFunction? editFunction;

  const EditableWidget({Key? key, required this.child, this.editFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editFunction != null) {
      return Stack(
        children: [
          child,
          Align(
            alignment: Alignment.topRight,
            child: EditableButton(editFunction: editFunction!,)
          ),
        ],
      );
    } else {
      return child;
    }
  }
}

class EditableButton extends StatelessWidget {
  final EditFunction editFunction;

  const EditableButton({Key? key, required this.editFunction})
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

