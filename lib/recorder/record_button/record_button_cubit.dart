import 'package:flutter_bloc/flutter_bloc.dart';

import '../recorder_bloc.dart';
import '../recorder_events.dart';

class RecordButtonCubit extends Cubit<bool> {
  final RecorderBloc recorderBloc;
  RecordButtonCubit({required this.recorderBloc}) : super(false);

  void startRecording() {
    recorderBloc.add(StartRecordingEvent());
    emit(true);
  }
  void stopRecording() {
    recorderBloc.add(StopRecordingEvent());
    emit(false);
  }
}