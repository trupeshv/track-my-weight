import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceUtil {
  static double bottomPadding(BuildContext context) {
    return MediaQuery.of(context).viewPadding.bottom + 16.r;
  }

  static double topPadding(BuildContext context) {
    return MediaQuery.of(context).viewPadding.top + 16.r;
  }
}
