import 'package:flutter/material.dart';
import 'dart:io';
import 'package:kamera_filter/widget/filter_carousel.dart';

// A widget that displays the picture taken by the user with filter options.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool _showFilters = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display the Picture - 2341720135 Rakai Seto Sembodo'),
        actions: [
          IconButton(
            icon: Icon(_showFilters ? Icons.close : Icons.filter_list),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Display the captured image
          Center(child: Image.file(File(widget.imagePath))),
          // Show filter carousel when enabled
          if (_showFilters)
            Positioned.fill(child: FilterCarousel(imagePath: widget.imagePath)),
        ],
      ),
    );
  }
}
