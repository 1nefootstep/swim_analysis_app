import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:swim_analysis_app/annotator/annotator.dart';

import 'recorder/recorder.dart';

class Homepage extends StatelessWidget {
  static const routeName = '/';
  const Homepage({Key? key}) : super(key: key);

  Future<File?> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) return null;

    return File(result.files.single.path);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Homepage'),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Recorder.routeName);
              },
              child: Text('Recorder'),
          ),
          ElevatedButton(
            onPressed: () async {
              final File? file = await pickVideoFile();
              if (file == null) {
                final alertDialog = CupertinoAlertDialog(
                  title: Text("Failed to pick video file"),
                  content: Text('Wasn\' able to load the video file'),
                  actions: [
                    TextButton(child: Text("Ok"), onPressed: () {
                      Navigator.of(context).pop();
                    },),
                  ],
                );
                showDialog(context: context, builder: (_) => alertDialog);
                return;
              }
              Navigator.pushNamed(context, Annotator.routeName, arguments: AnnotatorArgument(videoFile: file));
            },
            child: Text('Annotator'),
          ),
        ],
      ),
    );
  }
}
