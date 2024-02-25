import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeChangeEvent>((event, emit) {
      var isDark = state.isDark;
      isDark = !isDark;
      if (isDark) {
        emit(ThemeDark());
      } else {
        emit(ThemeLight());
      }
    });
  }
}
