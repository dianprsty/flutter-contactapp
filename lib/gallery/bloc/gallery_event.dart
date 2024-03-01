part of 'gallery_bloc.dart';

sealed class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object> get props => [];
}

final class GalleryAddEvent extends GalleryEvent {
  final Map<String, dynamic> photo;

  const GalleryAddEvent(this.photo);

  @override
  List<Object> get props => [photo];
}
