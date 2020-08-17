import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static String userIdFiled = 'USER_ID';
  static String isPremiumField = 'IS_PREMIUM';
  SharedPrefs();

  static Future<void> setUserId(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(userIdFiled, id);
  }

  static Future<String> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userIdFiled);
  }

  static setIsPremium(bool isPremium) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(isPremiumField, isPremium);
  }

  static Future<bool> getIsPremium() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(isPremiumField);
  }
}
