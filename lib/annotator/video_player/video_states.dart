import 'package:equatable/equatable.dart';

abstract class VideoState extends Equatable{
  @override
  List<Object?> get props => [];
}

class VideoInitState extends VideoState {}
class VideoReadyState extends VideoState {}
class VideoPlayingState extends VideoState {}
class VideoPausedState extends VideoState {}
class VideoBufferingState extends VideoState {}
class VideoFailureState extends VideoState {
  final String errorString;
  VideoFailureState({required this.errorString});
  @override
  List<Object?> get props => [errorString];
}