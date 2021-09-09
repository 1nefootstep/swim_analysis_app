import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecorderFailureAlert extends StatelessWidget {
  final errorString;
  const RecorderFailureAlert({Key? key, required this.errorString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Recorder Failure"),
      content: Text(errorString),
      actions: [
        TextButton(child: Text("Ok"), onPressed: () {
          Navigator.of(context).pop();
        },),
      ],
    );
  }
}
