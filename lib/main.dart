import 'package:flutter/material.dart';
import 'package:kutmb_assignment/screens/camera_screen.dart';
import 'package:kutmb_assignment/screens/gallery_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     home: const GalleryScreen(),
      routes: {
        '/camera': (context) => const CameraScreen(),
      },
    );
  }
}
