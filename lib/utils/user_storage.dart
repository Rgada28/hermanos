import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceHelper {
// Storing a user token
  static Future<void> storeUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', token);
  }

  static Future<void> setuserLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', status);
  }

  static Future<bool> getuserLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }

// Retrieving a user token
  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }
}
