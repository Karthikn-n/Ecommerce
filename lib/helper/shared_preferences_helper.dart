import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late final SharedPreferences _sharedPreferences;

  static Future<void> initializeSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance => _sharedPreferences;
}