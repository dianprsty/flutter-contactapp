part of 'gallery_bloc.dart';

sealed class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object> get props => [];
}

final class GalleryInitial extends GalleryState {}
