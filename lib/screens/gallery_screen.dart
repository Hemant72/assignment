import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kutmb_assignment/widgets/image_grid_view_widget.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String> images = [];
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadMoreImages();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addImage(String imagePath) {
    setState(() {
      images.add(imagePath);
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        images.add(image.path);
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isLoading) {
      _loadMoreImages();
    }
  }

  Future<void> _loadMoreImages() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      images.addAll(images);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: _pickImage,
          ),
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification &&
              _scrollController.position.pixels >=
                  _scrollController.position.maxScrollExtent - 200 &&
              !isLoading) {
            _loadMoreImages();
          }
          return false;
        },
        child: Column(
          children: [
            Expanded(
              child: ImageGrid(
                images: images,
                scrollController: _scrollController,
              ),
            ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
