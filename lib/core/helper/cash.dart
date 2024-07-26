import 'package:shared_preferences/shared_preferences.dart';

class Cash {
  late SharedPreferences prefs;

  static final Cash _instance = Cash._internal();
  Cash._internal();
  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void storeSelectedLanguage(String lang) async {
    await prefs.setString('language', lang);
  }

  void storeSelectedTheme(int theme) async {
    await prefs.setInt('theme', theme);
  }

  Future<String?> getSelectedLanguage() async {
    if (prefs.getString('language') == null) {
      await prefs.setString('language', 'en');
      return 'en';
    } else {
      return prefs.getString('language');
    }
  }

  Future<int?> getSelectedTheme() async {
    if (prefs.getInt('theme') == null) {
      await prefs.setInt('theme', 0);
      return 0;
    } else {
      return prefs.getInt('theme');
    }
  }
}
