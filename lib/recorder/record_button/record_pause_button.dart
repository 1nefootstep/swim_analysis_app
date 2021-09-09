import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../recorder_bloc.dart';
import 'record_button_cubit.dart';
import 'record_button.dart';
import 'pause_button.dart';

class RecordPauseButton extends StatelessWidget {
  const RecordPauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecordButtonCubit(recorderBloc: BlocProvider.of<RecorderBloc>(context)),
      child: BlocBuilder<RecordButtonCubit, bool>(
        builder: (context, isRecording) {
          return isRecording ? PauseButton() : RecordButton();
        },
      ),
    );
  }
}
