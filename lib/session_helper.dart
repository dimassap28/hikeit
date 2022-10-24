import 'package:shared_preferences/shared_preferences.dart';

class SessionHelper {
  static const login = "Login";
  static const userId = "userId";
  static const pendaki = 'pendaki';
  static const user = 'user';

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return;
  }

  // Cart Session
  static Future<void> saveLogin(String idUser, String role) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userId, idUser);
    prefs.setBool(pendaki, role == 'pendaki');
    prefs.setBool(login, true);
  }

  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userId) ?? '';
  }

  static Future<String> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(user) ?? '';
  }

  static Future<void> setUser(String userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(user, userData);
  }

  static Future<bool> isLoggin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(login) ?? false;
  }

  static Future<bool> isPendaki() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(pendaki) ?? false;
  }
}
