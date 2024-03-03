import 'dart:io';
import 'package:contactapp/gallery/bloc/gallery_bloc.dart';
import 'package:contactapp/gallery/widget/add_image_screen.dart';
import 'package:contactapp/gallery/widget/detail_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            padding: const EdgeInsets.only(bottom: 60),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 16 / 12,
            ),
            itemCount:
                BlocProvider.of<GalleryBloc>(context).state.photos.length,
            itemBuilder: (context, index) {
              return BlocBuilder<GalleryBloc, GalleryState>(
                builder: (context, state) {
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
                                    image: state.photos[index]["image"],
                                    title: state.photos[index]["title"],
                                    photo: state.photos,
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
                              child: state.photos[index]["image"]! is String
                                  ? Image.asset(
                                      state.photos[index]["image"]!,
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(state.photos[index]["image"].path),
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              state.photos[index]["title"]!,
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
