import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swim_analysis_app/annotator/video_player/video_events.dart';
import 'package:swim_analysis_app/annotator/video_player/video_progress_bar/video_progress_bar.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'annotator_bloc.dart';
import 'annotator_event.dart';
import 'annotator_state.dart';
import 'video_player/video_bloc.dart';
import 'video_player/video.dart';
import 'video_player/video_progress_bar/video_bottom_bar.dart';

class AnnotatorArgument {
  final File videoFile;
  AnnotatorArgument({required this.videoFile});
}

class Annotator extends StatelessWidget {
  static const routeName = '/annotator';
  final File videoFile;
  const Annotator({Key? key, required this.videoFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Colors.black,

        middle: Text('Annotator'),
      ),
      child: BlocProvider(
        create: (context) => VideoBloc()..add(VideoInitializeEvent(videoFile: videoFile)),
        child: Column(
        children: <Widget>[
          Expanded(child: Video()),
          VideoBottomBar(),
          // Container(height: 50.0, child: Row(children: [Container(color: Colors.white)],),),
        ],
      ),
      // backgroundColor: CupertinoColors.black,
    ),
    // return BlocProvider(
    //   create: (context) => RecorderBloc(),
    //   child: RecorderScreen(),
    );
  }
}

// class AnnotatorScreen extends StatefulWidget {
//   static const routeName = '/annotator';
//   final File file;
//   const AnnotatorScreen({Key? key, required this.file}) : super(key: key);
//
//   @override
//   _AnnotatorScreenState createState() => _AnnotatorScreenState();
// }
//
// class _AnnotatorScreenState extends State<AnnotatorScreen> {
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return VideoPlayer();
//   }
// }
