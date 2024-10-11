import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/constants.dart';

class TextFieldView extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final TextStyle hintStyle;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final TextStyle? inputTextStyle;
  final void Function()? onTap;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final double? radius;
  final Color? focusBoarderColor;
  final Color? enableBorderColor;
  final Color? borderColor;
  final TextStyle? counterTextStyle;
  final TextAlign? textAlign;
  final bool? readonly;

  const TextFieldView({
    super.key,
    required this.hintText,
    this.focusedBorder,
    this.enabledBorder,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.inputTextStyle,
    this.onTap,
    this.textCapitalization,
    required this.hintStyle,
    this.keyboardType,
    this.radius,
    this.focusBoarderColor,
    this.enableBorderColor,
    this.counterTextStyle,
    this.borderColor,
    this.textAlign,
    this.errorText, this.readonly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        textAlign: textAlign ?? TextAlign.start,
        cursorColor: ColorConstants.black000000,
        readOnly: readonly ?? false,
        style: inputTextStyle ??
            TextStyle(
                fontFamily: FONT_FAMILY_ROBOTO,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: ColorConstants.black000000),
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        decoration: InputDecoration(
            isDense: true,
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 6.r),
                  borderSide: BorderSide(color: focusBoarderColor ?? ColorConstants.green77D5BE),
                ),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 6.r),
                  borderSide: BorderSide(color: enableBorderColor ?? ColorConstants.greyAAAAAA),
                ),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorConstants.redFF5252),
                borderRadius: BorderRadius.circular(radius ?? 6.r)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? ColorConstants.greyAAAAAA)),
            hintText: hintText,
            hintStyle: hintStyle,
            contentPadding: EdgeInsets.all(12.r),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            prefixIconConstraints: const BoxConstraints(),
            suffixIconConstraints: const BoxConstraints(),
            counterStyle: counterTextStyle,
            errorText: errorText),
        controller: controller,
        textInputAction: textInputAction,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        keyboardType: keyboardType);
  }
}
