import 'package:intl/intl.dart';
import 'package:track_my_weight/core/constants/constants.dart';
import 'package:track_my_weight/models/enums.dart';

class AppUtils {
  static String kgToLb(String kg) {
    double lbValue = double.parse(kg) * 2.20462;
    return lbValue.toStringAsFixed(2);
  }

  static String lbToKg(String lb) {
    double kgValue = double.parse(lb) / 2.20462;
    return kgValue.toStringAsFixed(2);
  }

  static String showWeight(String weight, WeightUnit unit, WeightUnit selectedUnit) {
    return unit == selectedUnit
        ? weight
        : selectedUnit == WeightUnit.LB
            ? kgToLb(weight)
            : lbToKg(weight);
  }

  static bool isValidWeight(String input) {
    final RegExp weightRegExp = RegExp(r'^(?!0(\.0{1,})?$)\d{1,3}(\.\d{1,2})?\s?(kg|lb)?$');
    return weightRegExp.hasMatch(input);
  }

  static String getTimeInString(DateTime dateTime) {
    String format = DateFormat(TIMESTAMP_FORMAT_DD_MM_YYYY).format(dateTime);
    return format;
  }
}

extension DayOfYear on DateTime {
  int get dayOfYear {
    int dayCount = 0;
    for (int month = 1; month < this.month; month++) {
      dayCount += DateTime(year, month + 1, 0).day;
    }
    dayCount += day;
    return dayCount;
  }
}
