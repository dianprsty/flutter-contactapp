import 'dart:io';

import 'package:contactapp/add_image_screen.dart';
import 'package:contactapp/detail_image.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key, required this.photo}) : super(key: key);
  final List<Map<String, dynamic>> photo;

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<Map<String, dynamic>> photo = [
    {"image": "assets/images/gallery1.jpg", "title": "My Library"},
    {"image": "assets/images/gallery2.jpg", "title": "Spacious Room"},
    {
      "image": "assets/images/gallery3.jpg",
      "title": "Room with a Quote on the wall"
    },
    {"image": "assets/images/gallery4.jpg", "title": "A Nice sitting room"},
    {"image": "assets/images/gallery5.jpg", "title": "Our favorite spot"},
    {"image": "assets/images/gallery6.jpg", "title": "Living Room"},
  ];

  @override
  void initState() {
    if (widget.photo.isNotEmpty) {
      photo = widget.photo;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Gallery",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddImageScreen(
                    photo: photo,
                  ),
                ));
          },
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 16 / 12,
            ),
            itemCount: photo.length,
            itemBuilder: (context, index) {
              return Container(
                  padding: const EdgeInsets.all(1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailImage(
                                image: photo[index]["image"],
                                title: photo[index]["title"],
                                photo: photo,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 116,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: photo[index]["image"]! is String
                              ? Image.asset(
                                  photo[index]["image"]!,
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(photo[index]["image"].path),
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          photo[index]["title"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ));
            },
          ),
        ));
  }
}
