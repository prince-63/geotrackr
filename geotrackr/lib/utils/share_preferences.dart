import 'package:shared_preferences/shared_preferences.dart';

class SharePreferences {
  static void saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static void remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<bool> containsKey(String key) {
    final prefs = SharedPreferences.getInstance();
    return prefs.then((value) => value.containsKey(key));
  }
}
