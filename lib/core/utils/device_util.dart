import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceUtil {
  static double bottomPadding(BuildContext context) {
    return MediaQuery.of(context).viewPadding.bottom + 16.r;
  }
}
