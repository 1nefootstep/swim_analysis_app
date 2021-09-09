import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class VideoRecorderUtil {
  static final VideoRecorderUtil _instance = VideoRecorderUtil._internal();

  VideoRecorderUtil._internal();

  factory VideoRecorderUtil() {
    return _instance;
  }

  Future<CameraController> createCameraController({
    ResolutionPreset resolution = ResolutionPreset.veryHigh,
    CameraLensDirection lensDirection = CameraLensDirection.back,
    bool enableAudio = false,
  }) async {
    final cameras = await availableCameras();
    final camera =
        cameras.firstWhere((camera) => camera.lensDirection == lensDirection);
    return CameraController(camera, resolution, enableAudio: enableAudio)..unlockCaptureOrientation();
  }

  Future<String> getPath() async {
    return join(
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.mp4'
    );
  }
}
