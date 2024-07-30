import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String language = 'en';
  ThemeMode themeMode = ThemeMode.light;
  bool isDarkMode = false;
  bool isLightMode = true;

  void changeThemeMode(ThemeMode newThemeMode) {
    if (newThemeMode == ThemeMode.dark) {
      isDarkMode = true;
      isLightMode = false;
      
    } else if(newThemeMode == ThemeMode.light) {
      isDarkMode = false;
      isLightMode = true;
      
    }
    themeMode = newThemeMode;
    notifyListeners();
  }

  void changeLanguage(String newLanguage) {
    language = newLanguage;
    notifyListeners();
  }

}