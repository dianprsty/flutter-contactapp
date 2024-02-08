import 'dart:io';

import 'package:contactapp/screens/gallery_screen.dart';
import 'package:flutter/material.dart';

class DetailImage extends StatefulWidget {
  const DetailImage(
      {Key? key, required this.image, required this.title, required this.photo})
      : super(key: key);
  final dynamic image;
  final String title;
  final List<Map<String, dynamic>> photo;
  @override
  _DetailImageState createState() => _DetailImageState();
}

class _DetailImageState extends State<DetailImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const GalleryScreen(),
              ),
              (route) => route.isFirst,
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        heightFactor: 1.5,
        child: widget.image is String
            ? Image.asset(
                widget.image,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              )
            : Image.file(
                File(widget.image.path),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
