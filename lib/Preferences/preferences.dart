import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String SMS_PERMISSIONS = "SMS_PERMISSIONS";
  static const String SMS_ENTRY_MANDATORY = "SMS_ENTRY_MANDATORY";
  static const String SMS_UPDATE_MANDATORY = "SMS_UPDATE_MANDATORY";
  static const String CARD_PERMISSION = "CARD_PERMISSION";
  static const String CARD_ENTRY_MANDATORY = "CARD_ENTRY_MANDATORY";
  static const String CARD_UPDATE_MANDATORY = "CARD_UPDATE_MANDATORY";
  static const String EXIT_BY_PIN = "EXIT_BY_PIN";
  static const String EXIT_BY_HOOK = "EXIT_BY_HOOK";
  static const String ASSIGN_DRIVER = "ASSIGN_DRIVER";
  static const String IS_NOTIFICATION = "IS_NOTIFICATION";

  static setStringValue(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static Future<String?> getStringValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? null;
  }

  static setIntValue(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(key, value);
  }

  static Future<int> getIntValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? -1;
  }

  static Future<void> clearValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  static setBoolValue(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }

  static Future<bool> getBoolValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  static setListOfString(String key, List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList(key, value);
  }

  static Future<List<String>> getListOfString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key) ?? [];
  }
}
