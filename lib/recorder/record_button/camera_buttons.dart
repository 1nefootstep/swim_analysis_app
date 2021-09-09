import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'record_pause_button.dart';

class CameraButtons extends StatelessWidget {
  const CameraButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 80.0,
                color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    RecordPauseButton(),
                    Spacer(),
                  ],
                ),
              ),
          );
        } else {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 80.0,
              color: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Spacer(),
                  RecordPauseButton(),
                  Spacer(),
                ],
              ),
            ),
          );
        }
      }
    );

    // return Container(
    //   height: 100.0,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: <Widget>[
    //       Spacer(),
    //       RecordPauseButton(),
    //       Spacer(),
    //     ],
    //   ),
    // );
  }
}
