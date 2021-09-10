import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'recorder_state.dart';
import 'recorder_events.dart';
import 'recorder_util.dart';


class RecorderBloc extends Bloc<RecorderEvent, RecorderState> {
  final VideoRecorderUtil utils = VideoRecorderUtil();
  CameraController? _controller;

  RecorderBloc() : super(RecorderInitState());

  CameraController? get controller => _controller;

  bool isInitialized() => _controller?.value.isInitialized ?? false;



  @override
  Stream<RecorderState> mapEventToState(RecorderEvent event) async* {
    switch(event.eventType){
    case EVideoRecorderEvent.initialize:
      yield* _mapInitToState(event as RecorderInitializeEvent);
      break;
    case EVideoRecorderEvent.startRecording:
      yield* _mapStartRecordingToState(event as StartRecordingEvent);
      break;
    case EVideoRecorderEvent.stopRecording:
      yield* _mapStopRecordingToState(event as StopRecordingEvent);
      break;
    case EVideoRecorderEvent.terminate:
      yield* _mapTerminateToState(event as RecorderTerminateEvent);
      break;
    default:
      throw 'Switch fallthrough at VideoRecorderBloc.mapEventToState' + event.toString();
    }
  }

  Stream<RecorderState> _mapInitToState(RecorderInitializeEvent event) async* {
    try {
      _controller?.dispose();
      _controller = await utils.createCameraController();
      await _controller!.initialize();
      _controller!.prepareForVideoRecording();
      yield RecorderReadyState();
    } on CameraException catch (e) {
      _controller?.dispose();
      yield RecorderFailureState(error: e.description ?? "CameraException");
    } catch (e) {
      yield RecorderFailureState(error: e.toString());
    }
  }

  Stream<RecorderState> _mapStartRecordingToState(StartRecordingEvent event) async* {
    if (state is RecorderReadyState) {
      yield RecordingInProgressState();
      try {
        await _controller!.lockCaptureOrientation();
        await _controller!.startVideoRecording();
      } on CameraException catch (e) {
        yield RecorderFailureState(error: e.description ?? "CameraException");
      } catch (e) {
        yield RecorderFailureState(error: e.toString());
      }
    }
  }

  Stream<RecorderState> _mapStopRecordingToState(StopRecordingEvent event) async* {
    if (state is RecordingInProgressState) {
      try {
        final path = await utils.getPath();
        XFile videoFile = await _controller!.stopVideoRecording();
        await _controller!.unlockCaptureOrientation();
        videoFile.saveTo(path);
        await GallerySaver.saveVideo(videoFile.path);
        File(videoFile.path).deleteSync();
      } on CameraException catch (e) {
        yield RecorderFailureState(error: e.description ?? "CameraException");
      } catch (e) {
        // need to handle low storage exception probably
        yield RecorderFailureState(error: e.toString());
      }
    }
  }

  Stream<RecorderState> _mapTerminateToState(RecorderTerminateEvent event) async* {
    _controller?.dispose();
    yield RecorderInitState();
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}