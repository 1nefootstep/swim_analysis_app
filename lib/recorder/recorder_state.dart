import 'package:equatable/equatable.dart';
//https://github.com/laurentP22/my_photos/blob/master/lib/blocs/camera/camera_bloc.dart
abstract class RecorderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecorderInitState extends RecorderState {}

class RecorderReadyState extends RecorderState {}

class RecorderFailureState extends RecorderState {
  final String error;
  RecorderFailureState({this.error = "VideoRecorderFailure"});

  @override
  List<Object> get props => [error];
}

class RecordingInProgressState extends RecorderState{}
class RecordingSuccessState extends RecorderState{
  final String path;
  RecordingSuccessState({required this.path});
  @override
  List<Object> get props => [path];
}

class RecordingFailureState extends RecorderState{
  final String error;
  RecordingFailureState({this.error = "RecordingFailure"});
  @override
  List<Object> get props => [error];
}