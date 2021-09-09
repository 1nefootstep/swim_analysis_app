import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'record_button_cubit.dart';
import 'white_circle.dart';
import 'red_circle.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print('Record button is pressed');
        context.read<RecordButtonCubit>().startRecording();
      },
      // child: Icon(Icons.videocam),
      backgroundColor: Colors.red,
    );
    // return ElevatedButton(
    //     onPressed: () {
    //       print('Record button is pressed');
    //       context.read<RecordButtonCubit>().startRecording();
    //     },
    //     child: Container(
    //       width: 50.0,
    //       height: 50.0,
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         shape: BoxShape.circle,
    //       ),
    //       child: Align(
    //         alignment: Alignment.center,
    //         child: RedCircle(size: 40.0),
    //       ),
    //     ),
    // );
  }
}
