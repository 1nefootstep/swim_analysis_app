import 'package:equatable/equatable.dart';

abstract class AnnotatorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnnotatorInitialState extends AnnotatorState{}

class AnnotatorVideoPositionState extends AnnotatorState {
  final Duration? position;
  AnnotatorVideoPositionState({required this.position});
  bool get isSuccessful => position != null;
  @override
  List<Object?> get props => [position];
}

class AnnotatorPrintCheckpointsState extends AnnotatorState {
  final List<String> checkpoints;
  AnnotatorPrintCheckpointsState({required this.checkpoints});
  @override
  List<Object?> get props => [checkpoints];
}