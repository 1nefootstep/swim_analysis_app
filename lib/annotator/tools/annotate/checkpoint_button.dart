import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../video_player/video_bloc.dart';
import '../../video_player/video_event.dart';

class CheckpointButton extends StatelessWidget {
  const CheckpointButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoBloc = BlocProvider.of<VideoBloc>(context);
    return CupertinoButton(
      onPressed: () {
        videoBloc.add(VideoCheckpointEvent());
      },
      child: Icon(CupertinoIcons.flag),
    );
  }
}
