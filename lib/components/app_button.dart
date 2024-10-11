import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';

class AppButton extends StatelessWidget {
  final Color? fillColor;
  final Color? borderColor;
  final String text;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final TextStyle? textStyle;
  final double? width;
  final double? opacity;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;

  const AppButton({
    super.key,
    this.fillColor,
    this.borderColor,
    required this.text,
    this.onTap,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.width,
    this.margin,
    this.opacity,
    this.gradient,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        onTap: onTap,
        child: Container(
          width: width,
          padding: padding,
          decoration: BoxDecoration(
              color: fillColor ?? ColorConstants.green00796B,
              border: borderColor != null ? Border.all(color: borderColor!, width: 1.w) : null,
              boxShadow: boxShadow,
              gradient: gradient ??
                  (fillColor == null
                      ? LinearGradient(colors: [
                          ColorConstants.green009688.withOpacity(opacity ?? .5),
                          ColorConstants.green00796B.withOpacity(opacity ?? .35),
                        ])
                      : null),
              borderRadius: BorderRadius.circular(borderRadius ?? 10.r)),
          child: Center(
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
