import 'package:equatable/equatable.dart';

enum EVideoRecorderEvent {
  initialize,
  terminate,
  startRecording,
  stopRecording,
}

abstract class RecorderEvent extends Equatable{
  final EVideoRecorderEvent eventType;
  RecorderEvent(this.eventType);
  @override
  List<Object?> get props => [];
}

class RecorderInitializeEvent extends RecorderEvent{
  RecorderInitializeEvent() : super(EVideoRecorderEvent.initialize);
}

class RecorderTerminateEvent extends RecorderEvent{
  RecorderTerminateEvent() : super(EVideoRecorderEvent.terminate);
}

class StartRecordingEvent extends RecorderEvent{
  StartRecordingEvent() : super(EVideoRecorderEvent.startRecording);
}

class StopRecordingEvent extends RecorderEvent{
  StopRecordingEvent() : super(EVideoRecorderEvent.stopRecording);
}