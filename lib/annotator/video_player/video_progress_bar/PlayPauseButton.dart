import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:swim_analysis_app/annotator/video_player/video_state.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../video_bloc.dart';
import '../video_event.dart';

class PlayPauseButton extends StatelessWidget {
  PlayPauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VideoBloc videoBloc = BlocProvider.of<VideoBloc>(context);

    final playButton = CupertinoButton(child: const Icon(Icons.play_arrow), onPressed: ()=>videoBloc.add(VideoPlayEvent()),);
    final stopButton = CupertinoButton(child: const Icon(Icons.stop), onPressed: () =>videoBloc.add(VideoPauseEvent()),);
    return BlocBuilder<VideoBloc, VideoState>(
      buildWhen: (_, currState) {
        return currState is VideoPlayingState || currState is VideoPausedState;
      },
      builder: (context, VideoState state) {
        if (state is VideoPlayingState) {
          return stopButton;
        } else {
          return playButton;
        }
      },
    );
    return ValueListenableBuilder(
      valueListenable: videoBloc.controller!,
      builder: (context, VideoPlayerValue value, child) => value.isPlaying ? stopButton : playButton,
    );
  }
}