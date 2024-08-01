import 'package:flutter/material.dart';
import 'package:todo/core/helper/cash.dart';

class SettingsProvider extends ChangeNotifier {
  String language = 'en';
  ThemeMode themeMode = ThemeMode.light;
  bool isDarkMode = false;
  bool isLightMode = true;

  void changeThemeMode(ThemeMode newThemeMode) {
    if (newThemeMode == ThemeMode.dark) {
      isDarkMode = true;
      isLightMode = false;
      Cash().storeSelectedTheme(1) ;
      
    } else if(newThemeMode == ThemeMode.light) {
      isDarkMode = false;
      isLightMode = true;
      Cash().storeSelectedTheme(0) ;

      
    }
    themeMode = newThemeMode;
    notifyListeners();
  }

  void changeLanguage(String newLanguage) {
    language = newLanguage;
    Cash().storeSelectedLanguage(newLanguage);
    notifyListeners();
  }

}