import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ColorScheme _themeColor = const ColorScheme.light();
  bool _isDark = false;

  ColorScheme get themeColor => _themeColor;
  bool get isDark => _isDark;

  void changeTheme(bool isDark) {
    _isDark = isDark;
    _themeColor =
        _isDark ? const ColorScheme.dark() : const ColorScheme.light();
    notifyListeners();
  }
}
