import 'dart:convert';
import 'package:track_my_weight/core/persistence/preferences.dart';
import 'package:track_my_weight/models/user_model.dart';

class PreferenceHelper {
  static const userDataKey = "user_data_key";

  static setUserData(UserDataModel user) async {
    await Preferences.setString(userDataKey, json.encode(user));
  }

  static Future<UserDataModel?> getUserData() async {
    String? data = await Preferences.getString(userDataKey, null);
    if (data != null && data.isNotEmpty) {
      return UserDataModel.fromJson(json.decode(data));
    } else {
      return null;
    }
  }

  static Future<void> clearPreference() async {
    await Preferences.remove(userDataKey);
  }
}
