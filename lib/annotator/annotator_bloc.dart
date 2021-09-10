import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'annotator_event.dart';
import 'annotator_state.dart';
import 'video_player/video_bloc.dart';
import 'video_player/video_state.dart';

class AnnotatorBloc extends Bloc<AnnotatorEvent, AnnotatorState> {
  AnnotatorBloc() : super(AnnotatorInitialState());
  int _checkpointCounter = 1;
  final List<String> _checkpoints = [];

  @override
  Stream<AnnotatorState> mapEventToState(AnnotatorEvent event) async* {
    switch (event.eventType) {
    case EAnnotatorEvent.checkpoint:
      yield* _mapCheckpointToState(event as AnnotatorCheckpointEvent);
      break;
    case EAnnotatorEvent.save:
      yield* _mapSaveEventToState(event as AnnotatorSaveEvent);
      break;
    default:
      throw 'Switch fallthrough at AnnotatorBloc.mapEventToState' + event.toString();
    }
  }

  Stream<AnnotatorState> _mapCheckpointToState(AnnotatorCheckpointEvent event) async* {
    // write information somewhere...
    Duration position = event.position;
    _checkpoints.add('checkpoint $_checkpointCounter: ${position.toString()}');
    _checkpointCounter += 1;
    print('Checkpoint event captured! ${position.toString()}' );
  }

  Stream<AnnotatorState> _mapSaveEventToState(AnnotatorSaveEvent event) async* {
    print(_checkpoints);
    yield AnnotatorPrintCheckpointsState(checkpoints: _checkpoints);
  }
}
