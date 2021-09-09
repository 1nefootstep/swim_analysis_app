import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import 'video_bloc.dart';
// import 'video_events.dart';
import 'video_states.dart';

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  void initState() {
    // BlocProvider.of<VideoBloc>(context).add(VideoInitializeEvent(videoFile: F));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
      if (state is VideoInitState) {
        return Container(
          width: 1920.0,
          height: 1080.0,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.zero),
              shape: BoxShape.rectangle),
        );
      }
      final controller = BlocProvider.of<VideoBloc>(context).controller!;
      // consider displaying progress indicator when video is buffering
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    });
  }
}
