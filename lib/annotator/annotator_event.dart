import 'package:equatable/equatable.dart';

enum EAnnotatorEvent {
  // requestVideoPosition,
  checkpoint,
  save,
}

abstract class AnnotatorEvent extends Equatable {
  abstract final EAnnotatorEvent eventType;
  @override
  List<Object?> get props => [eventType];
}

// class RequestVideoPositionEvent extends AnnotatorEvent {
//   final EAnnotatorEvent eventType = EAnnotatorEvent.requestVideoPosition;
// }

class AnnotatorCheckpointEvent extends AnnotatorEvent {
  final EAnnotatorEvent eventType = EAnnotatorEvent.checkpoint;
  final Duration position;
  AnnotatorCheckpointEvent({required this.position});
  @override
  List<Object?> get props => [eventType, position];
}

class AnnotatorSaveEvent extends AnnotatorEvent {
  final EAnnotatorEvent eventType = EAnnotatorEvent.save;
}
