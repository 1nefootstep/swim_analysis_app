import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'record_button_cubit.dart';
import 'white_circle.dart';
import 'red_square.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          print('Pause button is pressed');
          BlocProvider.of<RecordButtonCubit>(context).stopRecording();
        },
        child: Icon(Icons.stop),
        backgroundColor: Colors.black,
        // child: Stack(
        //   children: <Widget>[
        //     const WhiteCircle(size: 60.0),
        //     Align(
        //       alignment: Alignment.center,
        //       child: const RedSquare(size: 25.0),
        //     ),
        //   ],
        // )
        // child: Container(
        //   width: 50.0,
        //   height: 50.0,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     shape: BoxShape.circle,
        //   ),
        //   child: Align(
        //     alignment: Alignment.center,
        //     child: RedSquare(size: 30.0),
        //   ),
        // ),
    );
  }
}
