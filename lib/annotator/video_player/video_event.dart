import 'dart:io';

import 'package:equatable/equatable.dart';

enum EVideoEvent{
  init,
  play,
  pause,
  seek,
  checkpoint,
}

abstract class VideoEvent extends Equatable{
  abstract final EVideoEvent eventType;
  @override
  List<Object?> get props => [eventType];
}

class VideoInitializeEvent extends VideoEvent {
  final EVideoEvent eventType = EVideoEvent.init;
  final File videoFile;
  VideoInitializeEvent({required this.videoFile});

  @override
  List<Object?> get props => [eventType, videoFile];
}

class VideoPlayEvent extends VideoEvent {
  final EVideoEvent eventType = EVideoEvent.play;
}
class VideoPauseEvent extends VideoEvent {
  final EVideoEvent eventType = EVideoEvent.pause;
}
class VideoSeekEvent extends VideoEvent {
  final Duration? seekToPosition;
  final Duration? seekToDifference;
  final EVideoEvent eventType = EVideoEvent.seek;
  final bool playAfterSeek;

  VideoSeekEvent({required this.seekToPosition, this.playAfterSeek = false}) : this.seekToDifference = null;
  VideoSeekEvent.withDifference(this.seekToDifference, {this.playAfterSeek = false}) : this.seekToPosition = null;
  List<Object?> get props => [eventType, seekToPosition, seekToDifference];
}
class VideoCheckpointEvent extends VideoEvent {
  final EVideoEvent eventType = EVideoEvent.checkpoint;
}
