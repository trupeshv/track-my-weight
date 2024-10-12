import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/text_styles.dart';

class LegendView extends StatelessWidget {
  final Color color;
  final String text;

  const LegendView({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15.r,
          height: 15.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(
          width: 8.r,
        ),
        Text(
          text,
          style: textStyle12WithW400(ColorConstants.black000000),
        ),
      ],
    );
  }
}
