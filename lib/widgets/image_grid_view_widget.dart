import 'dart:io';

import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<String> images;
  final ScrollController scrollController;

  const ImageGrid(
      {super.key, required this.images, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Image.file(
          File(images[index]),
          fit: BoxFit.cover,
        );
      },
    );
  }
}
