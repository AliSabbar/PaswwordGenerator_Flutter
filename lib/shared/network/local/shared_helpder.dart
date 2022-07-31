import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> savePreferences({
    required bool value,
    required String key,
  }) async {
     return await sharedPreferences?.setBool(key, value);
  }

  static bool? getPreferences({
    required String key,
  })  {
    return sharedPreferences?.getBool(key);
  }
}
