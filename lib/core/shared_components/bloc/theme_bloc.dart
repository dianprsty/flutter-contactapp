import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeChangeEvent>((event, emit) async {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final bool isDark = pref.getBool("theme") ?? false;

      if (!isDark) {
        pref.setBool("theme", true);
        emit(ThemeDark());
      } else {
        pref.setBool("theme", false);
        emit(ThemeLight());
      }
    });

    on<ThemeSetEvent>(
      (event, emit) async {
        final SharedPreferences pref = await SharedPreferences.getInstance();

        final bool isDark = pref.getBool("theme") ?? false;

        if (!isDark) {
          emit(ThemeLight());
        } else {
          emit(ThemeDark());
        }
      },
    );
  }
}
