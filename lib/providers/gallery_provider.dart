import 'package:flutter/material.dart';

class GalleryProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _photo = [
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

  List<Map<String, dynamic>> get photo => _photo;

  void addPhoto(Map<String, dynamic> image) {
    _photo.add(image);
    notifyListeners();
  }
}
