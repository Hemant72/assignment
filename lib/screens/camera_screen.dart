import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  late List<CameraDescription> cameras;
  late CameraDescription firstCamera;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;

    controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    await controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!controller!.value.isInitialized) {
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = join(directory.path, '${DateTime.now()}.png');

    await controller!.takePicture().then((file) {
      file.saveTo(imagePath);
      Navigator.pop(context, imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: CameraPreview(controller!),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
