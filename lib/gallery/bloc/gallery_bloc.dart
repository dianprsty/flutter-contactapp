import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryInitial()) {
    on<GalleryAddEvent>((event, emit) {
      var photos = state.photos;

      photos.add(event.photo);

      emit(GalleryAddState(photos));
    });
  }
}
