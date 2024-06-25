import 'package:flutter/material.dart';
import 'package:kutmb_assignment/widgets/image_grid_view_widget.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String> images = [];
  int page = 0;

  void _addImage(String imagePath) {
    setState(() {
      images.add(imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/camera');
              if (result != null && result is String) {
                _addImage(result);
              }
            },
          )
        ],
      ),
      body: ImageGrid(images: images),
    );
  }
}
