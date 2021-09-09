import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'homepage.dart';
import 'recorder/recorder.dart';
import 'annotator/annotator.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
  case Homepage.routeName:
    return CupertinoPageRoute(builder: (context) => Homepage());
  case Recorder.routeName:
    return CupertinoPageRoute(builder: (context) => Recorder());
  case Annotator.routeName:
    if (settings.arguments != null &&
        settings.arguments! is AnnotatorArgument) {
      AnnotatorArgument args = settings.arguments! as AnnotatorArgument;
      return CupertinoPageRoute(
          builder: (context) => Annotator(videoFile: args.videoFile));

    }
    throw Exception(
        "\{file: File\} should be passed as argument to Annotator.");
  default:
    throw Exception(
        "Switch case fallthrough: at router.generateRoute");
  }
}