import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../annotator_bloc.dart';
import '../../annotator_event.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final annotatorBloc = BlocProvider.of<AnnotatorBloc>(context);
    return CupertinoButton(
      onPressed: () {
        annotatorBloc.add(AnnotatorSaveEvent());
      },
      child: Icon(Icons.save),
    );
  }
}
