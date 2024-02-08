import 'dart:io';
import 'package:contactapp/providers/gallery_provider.dart';
import 'package:contactapp/screens/add_image_screen.dart';
import 'package:contactapp/screens/detail_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
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
                  builder: (context) => const AddImageScreen(),
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
            itemCount: context.watch<GalleryProvider>().photo.length,
            itemBuilder: (context, index) {
              return Consumer<GalleryProvider>(
                builder: (context, provider, child) {
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
                                    image: provider.photo[index]["image"],
                                    title: provider.photo[index]["title"],
                                    photo: provider.photo,
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
                              child: provider.photo[index]["image"]! is String
                                  ? Image.asset(
                                      provider.photo[index]["image"]!,
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(provider.photo[index]["image"].path),
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              provider.photo[index]["title"]!,
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
              );
            },
          ),
        ));
  }
}
