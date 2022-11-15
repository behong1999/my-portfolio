import 'package:flutter/material.dart';
import 'package:web_portfolio/theme/theme_preferences.dart';

class ThemeModel with ChangeNotifier {
  bool _isDark = false;
  ThemePreferences _preferences = ThemePreferences();

  ThemeModel() {
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
  }

  bool get isDark => _isDark;

  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  switchTheme() {
    _isDark = !_isDark;
    // log(_isDark.toString());
    _preferences.setTheme(_isDark);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}
