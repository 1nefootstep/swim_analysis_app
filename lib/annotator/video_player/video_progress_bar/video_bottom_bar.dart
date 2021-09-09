import 'package:flutter/material.dart';
import 'package:swim_analysis_app/annotator/video_player/video_progress_bar/PlayPauseButton.dart';
import 'video_progress_bar.dart';

class VideoBottomBar extends StatelessWidget {
  const VideoBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      // fine frame control will be placed directly under the progress bar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          PlayPauseButton(),
          Expanded(child: VideoProgressBar()),
        ],
      ),
    );
  }
}
