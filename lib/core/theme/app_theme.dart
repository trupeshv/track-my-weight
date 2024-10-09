import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/constants.dart';

class AppTheme {
  static final theme = ThemeData(
    primaryColor: ColorConstants.green77D5BE,
    fontFamily: FONT_FAMILY_ROBOTO,
    brightness: Brightness.light,
    shadowColor: ColorConstants.whiteE6EBEE,
    cardColor: ColorConstants.whiteFFFFFF,
    indicatorColor: ColorConstants.black000000,
    dialogBackgroundColor: ColorConstants.whiteFFFFFF,
    dividerColor: ColorConstants.greyAAAAAA.withOpacity(.08),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorConstants.whiteFFFFFF,
      constraints: BoxConstraints(minWidth: double.infinity),
    ),
    splashColor: ColorConstants.transparent,
    highlightColor: ColorConstants.transparent,
    hoverColor: ColorConstants.transparent,
    focusColor: ColorConstants.transparent,
    scaffoldBackgroundColor: ColorConstants.whiteFFFFFF,
  );
}
