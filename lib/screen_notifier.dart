import 'package:flutter/material.dart';

import './screens/exercises_screen.dart';
import './screens/home_screen.dart';
import './screens/profile_screen.dart';
import './screens/settings_screen.dart';

class ScreenNotifier extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  Widget get currentScreen {
    switch (_currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return ExercisesScreen();
      case 2:
        return ProfileScreen();
      case 3:
        return SettingsScreen();
      default:
        return HomeScreen();
    }
  }

  void changeScreen(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
