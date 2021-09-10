import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'annotate/checkpoint_button.dart';
import 'annotate/save_button.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CheckpointButton(),
          SaveButton(),
        ],
      )
    );
  }
}
