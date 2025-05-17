import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static late SharedPreferences pref;

  static String tokenKey = "token";

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static cacheData(String key, dynamic value) async {
    if (value is String) {
      pref.setString(key, value);
    } else if (value is bool) {
      pref.setBool(key, value);
    } else if (value is int) {
      pref.setInt(key, value);
    } else if (value is double) {
      pref.setDouble(key, value);
    }
  }

  static getCachedData(String key) {
    return pref.get(key);
  }

  // For Logout
  static clearCashedData(String key) {
    return pref.remove(key);
  }
}
