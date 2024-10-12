import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:track_my_weight/core/persistence/preferences.dart';
import 'package:track_my_weight/models/user_model.dart';
import 'package:track_my_weight/models/weight_model.dart';

class PreferenceHelper {
  static const userDataKey = "user_data_key";
  static const weightList = "weight_list";

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

  static setRecordList({required WeightModel weightData}) async {
    List<WeightModel> list = await getRecordList();
    if (list.where((element) => isSameDay(element.recordDate, weightData.recordDate)).isEmpty) {
      list.add(weightData);
    } else {
      int index =
          list.indexWhere((element) => isSameDay(element.recordDate, weightData.recordDate));
      list.replaceRange(index, index + 1, [weightData]);
    }
    await Preferences.setString(weightList, json.encode(list));
  }

  static Future<List<WeightModel>> getRecordList() async {
    List<WeightModel> recordList = [];
    String? data = await Preferences.getString(weightList, null);
    if (data != null && data.isNotEmpty) {
      var test = jsonDecode(data) as List<dynamic>;

      for (var v in test) {
        recordList.add(WeightModel.fromJson(v));
      }
    }
    return recordList;
  }

  static Future<void> clearPreference() async {
    await Preferences.remove(userDataKey);
  }
}
