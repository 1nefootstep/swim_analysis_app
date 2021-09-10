import 'dart:async';
import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../annotator_bloc.dart';
import '../annotator_event.dart';
import 'video_event.dart';
import 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState>{
  VideoPlayerController? _controller;
  VideoPlayerController? get controller => _controller;
  final AnnotatorBloc annotatorBloc;
  // late final StreamSubscription _annotatorBlocSubscription;
  // AnnotatorBloc(this.annotatorBloc) : super(VideoInitState()) {
  //   _annotatorBlocSubscription = annotatorBloc.stream.listen((VideoState state) {
  //
  //   });
  // }
  final Queue<Duration> seekDequeBuffer = Queue();

  bool isInitialized() => _controller?.value.isInitialized ?? false;

  VideoBloc({required this.annotatorBloc}) : super(VideoInitState());

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    switch (event.eventType) {
    case EVideoEvent.init:
      yield* _mapInitToState(event as VideoInitializeEvent);
      break;
    case EVideoEvent.play:
      yield* _mapPlayToState(event as VideoPlayEvent);
      break;
    case EVideoEvent.pause:
      yield* _mapPauseToState(event as VideoPauseEvent);
      break;
    case EVideoEvent.seek:
      yield* _mapSeekToState(event as VideoSeekEvent);
      break;
    case EVideoEvent.checkpoint:
      _handleCheckpointEvent(event as VideoCheckpointEvent);
      break;
    default:
      throw 'Switch fallthrough at VideoBloc.mapEventToState' + event.toString();
    }
  }

  Stream<VideoState> _mapInitToState(VideoInitializeEvent event) async* {
    try {
      _controller?.dispose();
      _controller = VideoPlayerController.file(event.videoFile);
      await _controller!.initialize();
      yield VideoReadyState();
    } catch (e) {
      _controller?.dispose();
      yield VideoFailureState(errorString: e.toString());
    }
  }

  Stream<VideoState> _mapPlayToState(VideoPlayEvent event) async* {
    await _controller!.play();
    yield VideoPlayingState();
  }

  Stream<VideoState> _mapPauseToState(VideoPauseEvent event) async* {
    await _controller!.pause();
    yield VideoPausedState();
  }

  Stream<VideoState> _mapSeekToState(VideoSeekEvent event) async* {
    // sto
    if (state is VideoBufferingState) {
      seekDequeBuffer.addLast(
          event.seekToPosition
          ?? ((await _controller!.position) ?? Duration.zero) + event.seekToDifference!
      );
      return;
    }
    yield VideoBufferingState();
    final Duration seekToPosition;
    if (event.seekToPosition == null) {
      seekToPosition = ((await _controller!.position) ?? Duration.zero) + event.seekToDifference!;
    } else {
      seekToPosition = event.seekToPosition!;
    }

    await _controller!.seekTo(seekToPosition);

    void afterBufferingCallback() {
      if (!_controller!.value.isBuffering) {
        if (event.playAfterSeek) {
          this.add(VideoPlayEvent());
        } else {
          this.add(VideoPauseEvent());
        }
        if (seekDequeBuffer.isNotEmpty) {
          final positionToSeek = seekDequeBuffer.last;
          seekDequeBuffer.clear();
          this.add(VideoSeekEvent(seekToPosition: positionToSeek));
        }
        _controller!.removeListener(afterBufferingCallback);
      }
    }
    _controller!.addListener(afterBufferingCallback);
  }

  void _handleCheckpointEvent(VideoCheckpointEvent event) async {
    if (_controller == null) {
      print('Skipping checkpoint event because controller is null');
      return;
    }
    Duration? position = await _controller!.position;
    if (position == null) {
      print('Skipping checkpoint event because position is null');
      return;
    }
    annotatorBloc.add(AnnotatorCheckpointEvent(position: position));
  }
}