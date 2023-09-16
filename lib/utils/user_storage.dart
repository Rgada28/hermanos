import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceHelper {
// Storing a user token
  static Future<void> storeUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', token);
  }

// Retrieving a user token
  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }
}
