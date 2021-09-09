import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_analysis_app/annotator/video_player/video_bloc.dart';
import 'package:swim_analysis_app/annotator/video_player/video_states.dart';
import 'package:video_player/video_player.dart';

import '../video_events.dart';

class VideoProgressBar extends StatelessWidget {
  const VideoProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      buildWhen: (prevState, currState) {
        return (prevState is VideoInitState) && (currState is VideoReadyState);
      },
      builder: (context, state) {
        if (state is VideoInitState) {
          return Container();
        }
        final videoBloc = BlocProvider.of<VideoBloc>(context);
        return ValueListenableBuilder(
          valueListenable: videoBloc.controller!,
          builder: (context, VideoPlayerValue value, _) {
            final progress = value.position;
            final total = value.duration;
            return ProgressBar(
              progress: progress,
              total: total,
              onDragStart: (ThumbDragDetails details) {
                videoBloc
                    .add(VideoSeekEvent(seekToPosition: details.timeStamp));
              },
              onDragUpdate: (ThumbDragDetails details) {
                videoBloc
                    .add(VideoSeekEvent(seekToPosition: details.timeStamp));
              },
              onSeek: (duration) {
                videoBloc.add(VideoSeekEvent(seekToPosition: duration));
              },
              timeLabelLocation: TimeLabelLocation.sides,
              timeLabelTextStyle: TextStyle(color: Colors.white),
              barHeight: 3.0,
              thumbRadius: 5.0,
              thumbColor: Colors.white,
              progressBarColor: Colors.red,
              thumbCanPaintOutsideBar: true,
            );
          },
        );
      },
    );
  }
}

// builder: (context, state) {
//   return Container();


// },
