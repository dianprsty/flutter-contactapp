part of 'gallery_bloc.dart';

sealed class GalleryState extends Equatable {
  GalleryState();

  final List<Map<String, dynamic>> _photos = [
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
  List<Object> get props => [_photos];

  List<Map<String, dynamic>> get photos => _photos;
}

final class GalleryInitial extends GalleryState {}

final class GalleryAddState extends GalleryState {
  @override
  final List<Map<String, dynamic>> photos;

  GalleryAddState(this.photos);
}
