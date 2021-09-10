import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import 'general/recorder_failure_alert.dart';
import 'record_button/camera_buttons.dart';
import 'recorder_events.dart';
import 'recorder_state.dart';
import 'recorder_bloc.dart';

class Recorder extends StatelessWidget {
  static const routeName = '/recorder';

  const Recorder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Recorder'),
      ),
      child: BlocProvider(
        create: (context) => RecorderBloc(),
        child: RecorderScreen(),
      ),
      backgroundColor: CupertinoColors.black,
    );
    // return BlocProvider(
    //   create: (context) => RecorderBloc(),
    //   child: RecorderScreen(),
    // );
  }
}

class RecorderScreen extends StatefulWidget {
  const RecorderScreen({Key? key}) : super(key: key);

  @override
  _RecorderScreenState createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    BlocProvider.of<RecorderBloc>(context).add(RecorderInitializeEvent());
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<RecorderBloc>(context);

    // App state changed before we got the chance to initialize.
    if (!bloc.isInitialized()) return;

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      bloc.add(RecorderTerminateEvent());
    } else if (state == AppLifecycleState.resumed) {
      bloc.add(RecorderInitializeEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<RecorderBloc, RecorderState>(
        listener: (context, state) {
      if (state is RecorderFailureState) {
        //alert dialog
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (_) => RecorderFailureAlert(
              errorString: state.error,
            ),
          );
        });
      }
    }, builder: (context, state) {
      if (state is RecorderInitState) {
        return CupertinoPageScaffold(
            child: Center(child: CupertinoActivityIndicator()));
      }
      if (state is RecorderFailureState) {
        return CupertinoPageScaffold(
            child: Center(child: Text("Recorder failed.")));
      }
      return Stack(
        children: <Widget>[
          Container(
            // somehow need to deal with rotation...
            height: height,
            width: width,
            child: CameraPreview(BlocProvider.of<RecorderBloc>(context).controller!),
          ),
          // CameraPreview(_controller!),
          Align(
            alignment: Alignment.bottomCenter,
            child: CameraButtons(),
          ),
        ],
      );
    });
  }
}
