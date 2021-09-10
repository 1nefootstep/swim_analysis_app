// import 'dart:async';

import 'package:flutter/cupertino.dart';
// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'router.dart' as router;
import 'annotator/annotator.dart';
import 'homepage.dart';
import 'recorder/recorder.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CupertinoApp(
    initialRoute: Homepage.routeName,
    theme: CupertinoThemeData(brightness: Brightness.light),
    onGenerateRoute: router.generateRoute,
  ));
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(CameraApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       title: 'Flutter Demo',
//       theme: CupertinoThemeData(
//         primaryColor: CupertinoColors.inactiveGray,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class CameraApp extends StatefulWidget {
//   @override
//   _CameraAppState createState() => _CameraAppState();
// }
//
// class _CameraAppState extends State<CameraApp> {
//   CameraController? controller;
//   late List<CameraDescription> cameras;
//
//   Future<void> initCamera() async {
//     cameras = await availableCameras();
//     controller = CameraController(cameras[0], ResolutionPreset.max);
//     controller!.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (controller == null || !controller!.value.isInitialized) {
//       return Container();
//     }
//     return CupertinoApp(
//       home: CameraPreview(controller!),
//     );
//   }
// }
