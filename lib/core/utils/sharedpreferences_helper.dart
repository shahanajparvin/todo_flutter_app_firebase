
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // String
  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  // Boolean
  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  // Integer
  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  // Double
  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  Future<bool> setDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  // Remove a preference by key
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  // Clear all preferences
  Future<bool> clear() {
    return _prefs.clear();
  }
}
