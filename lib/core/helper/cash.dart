import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class Cash {
  SharedPreferences? prefs;

  static final Cash _instance = Cash._internal();

  factory Cash() => _instance;

  Cash._internal();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    debugPrint('SharedPreferences initialized');
  }

  Future<void> _ensurePrefsInitialized() async {
    if (prefs == null) {
      debugPrint('SharedPreferences not initialized, calling init');
      await init();
    }
  }

  Future<void> storeSelectedLanguage(String lang) async {
    await _ensurePrefsInitialized();
    debugPrint('Storing language: $lang');
    await prefs!.setString('language', lang);
  }

  Future<void> storeSelectedTheme(int theme) async {
    await _ensurePrefsInitialized();
    debugPrint('Storing theme: $theme');
    await prefs!.setInt('theme', theme);
  }

  Future<String?> getSelectedLanguage() async {
    await _ensurePrefsInitialized();
    String? lang = prefs!.getString('language') ?? 'en';
    debugPrint('Retrieved language: $lang');
    return lang;
  }

  Future<int?> getSelectedTheme() async {
    await _ensurePrefsInitialized();
    int? theme = prefs!.getInt('theme') ?? 0;
    debugPrint('Retrieved theme: $theme');
    return theme;
  }
}
