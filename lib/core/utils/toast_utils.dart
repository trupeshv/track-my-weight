import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ToastUtils {
  static void showToaster(String message, BuildContext context) {
    showToast(message,
        context: context,
        position: StyledToastPosition(align: Alignment.bottomCenter, offset: 60.r),
        animation: StyledToastAnimation.slideFromBottomFade,
        reverseAnimation: StyledToastAnimation.slideFromBottomFade,
        duration: const Duration(seconds: 3));
  }
}
