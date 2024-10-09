import 'dart:convert';
import 'package:track_my_weight/core/persistence/preferences.dart';

class PreferenceHelper {
  static const accessTokenKey = "access_token";

  static setAccessToken(String token) async {
    await Preferences.setString(accessTokenKey, json.encode(token));
  }

  static getAccessToken() async {
    String? data = await Preferences.getString(accessTokenKey, null);
    return data;
  }

  static Future<void> clearPreference() async {
    await Preferences.remove(accessTokenKey);
  }
}
