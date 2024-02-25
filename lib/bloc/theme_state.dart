part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  final ColorScheme _themeColor = const ColorScheme.light();
  final bool _isDark = false;

  ColorScheme get themeColor => _themeColor;
  bool get isDark => _isDark;

  @override
  List<Object> get props => [_themeColor, _isDark];
}

final class ThemeInitial extends ThemeState {}

final class ThemeLight extends ThemeState {
  @override
  final ColorScheme themeColor = const ColorScheme.light();
  @override
  final bool isDark = false;
}

final class ThemeDark extends ThemeState {
  @override
  final ColorScheme themeColor = const ColorScheme.dark();
  @override
  final bool isDark = true;
}
