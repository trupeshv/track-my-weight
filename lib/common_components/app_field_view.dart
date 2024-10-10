import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/common_components/text_field_view.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/text_styles.dart';

class AppFieldView extends StatefulWidget {
  final bool isRequiredText;
  final String? text;
  final String? errorText;
  final TextStyle? textStyle;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String value)? onFieldSubmit;
  final Function(String value)? onChanged;
  final bool? readonly;
  final Widget? suffixIcon;
  final int? minLines;
  final TextEditingController? controller;
  final void Function()? onTap;

  const AppFieldView({
    super.key,
    this.text,
    this.textStyle,
    required this.isRequiredText,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmit,
    this.readonly,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.controller,
    this.minLines,
    this.errorText,
  });

  @override
  State<AppFieldView> createState() => _AppFieldViewState();
}

class _AppFieldViewState extends State<AppFieldView> {
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.text != null) ...[
              RichText(
                text: TextSpan(
                  text: widget.text!,
                  style: widget.textStyle ?? textStyle16WithW500(ColorConstants.black000000),
                  children: [
                    if (widget.isRequiredText)
                      TextSpan(
                        text: ' *',
                        style: textStyle16WithW500(Colors.red), // Red asterisk
                      ),
                  ],
                ),
              ),
              SizedBox(height: 6.h),
            ],
            Container(
              color: ColorConstants.whiteFFFFFF,
              child: TextFieldView(
                onTap: widget.onTap,
                controller: widget.controller ?? controller,
                hintText: widget.hintText,
                hintStyle: textStyle14WithW400(ColorConstants.greyAAAAAA),
                keyboardType: widget.keyboardType ?? TextInputType.text,
                suffixIcon: widget.suffixIcon,
                readonly: widget.readonly,
                textInputAction: widget.textInputAction ?? TextInputAction.next,
                onChanged: (newValue) {
                  int cursorPosition = controller.selection.baseOffset;
                  controller.text = newValue;
                  controller.selection = TextSelection.collapsed(offset: cursorPosition);
                  if (widget.onChanged != null) {
                    widget.onChanged!(newValue);
                  }
                  setState(() {});
                },
                errorText: widget.errorText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
