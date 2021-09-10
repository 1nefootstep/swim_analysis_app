import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swim_analysis_app/annotator/video_player/video_event.dart';
import 'package:swim_analysis_app/annotator/video_player/video_progress_bar/video_progress_bar.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'annotator_bloc.dart';
import 'annotator_event.dart';
import 'annotator_state.dart';
import 'tools/toolbar.dart';
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
        middle: Text('Annotator'),
      ),
      child: MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<AnnotatorBloc>(
            create: (context) => AnnotatorBloc(),
          ),
          BlocProvider<VideoBloc>(
            create: (context) => VideoBloc(
                annotatorBloc: BlocProvider.of<AnnotatorBloc>(context))
              ..add(VideoInitializeEvent(videoFile: videoFile)),
          ),
        ],
        child: AnnotatorScreen(),
      ),
    );
  }
}

class AnnotatorScreen extends StatelessWidget {
  const AnnotatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnotatorBloc, AnnotatorState>(
        buildWhen: (prevState, currState) {
      return currState is AnnotatorPrintCheckpointsState;
    }, builder: (context, state) {
      if (state is AnnotatorPrintCheckpointsState) {
        //alert dialog
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: Text("Checkpoints"),
              content: Text(state.checkpoints.toString()),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
      }
      return Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(child: Video()),
              VideoBottomBar(),
            ],
          ),
          Positioned.fill(
            child: Align(alignment: Alignment.topRight, child: Toolbar()),
          )
        ],
      );
    });
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
