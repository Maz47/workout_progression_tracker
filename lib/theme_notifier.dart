import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './constants/themes.dart';
import './models/custom_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  CustomTheme _currentTheme = kDefaultTheme;

  CustomTheme get currentTheme => _currentTheme;

  void changeTheme(CustomTheme theme) async {
    _currentTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("app_theme", _currentTheme.name);
    notifyListeners();
  }

  ThemeNotifier() {
    init();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    String themeName = prefs.getString("app_theme") ?? "default";
    kAvailabelThemes.forEach((element) {
      if (element.name == themeName) _currentTheme = element;
    });
    notifyListeners();
  }
}
