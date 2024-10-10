import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/common_components/app_button.dart';
import 'package:track_my_weight/common_components/app_field_view.dart';
import 'package:track_my_weight/common_components/weight_unit_view.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/text_styles.dart';
import 'package:track_my_weight/core/utils/app_utils.dart';
import 'package:track_my_weight/core/utils/device_utils.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController scheduleTimeController = TextEditingController();
  String selectedUnit = "KG";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.whiteFFFFFF,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: DeviceUtil.topPadding(context),
                ),
                Text(
                  "Let's Get Started!",
                  style: textStyle26WithW600(ColorConstants.black000000),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Please enter your name and choose when you'd like to be reminded to record your weight each day.",
                  style: textStyle12WithW400(ColorConstants.greyAAAAAA),
                ),
                SizedBox(
                  height: 60.h,
                ),

                /// Name of the user
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppFieldView(
                        text: "First Name",
                        controller: firstNameController,
                        isRequiredText: true,
                        onChanged: (value) {},
                        hintText: "John",
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: AppFieldView(
                        text: "Last Name",
                        controller: lastNameController,
                        isRequiredText: true,
                        onChanged: (value) {},
                        hintText: "Deo",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                /// Current weight
                AppFieldView(
                  text: "Weight",
                  controller: weightController,
                  isRequiredText: true,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  suffixIcon: WeightUnitView(
                    unitInKg: selectedUnit == "KG",
                    selectedValue: (value) {
                      if (value == "LB" && selectedUnit != "LB") {
                        weightController.text = AppUtils.kgToLb(weightController.text);
                      } else if (value == "KG" && selectedUnit != "KG") {
                        weightController.text = AppUtils.lbToKg(weightController.text);
                      }
                      selectedUnit = value;
                    },
                  ),
                  errorText: weightController.text.isEmpty
                      ? null
                      : AppUtils.isValidWeight(weightController.text)
                          ? null
                          : "Please enter valid value.",
                  onChanged: (value) {
                    setState(() {});
                  },
                  hintText: "60",
                ),
                SizedBox(height: 20.h),

                /// Notification schedule time
                AppFieldView(
                  text: "Notification Schedule Time",
                  isRequiredText: true,
                  onChanged: (value) {},
                  hintText: "00:00 AM",
                  readonly: true,
                  controller: scheduleTimeController,
                  textInputAction: TextInputAction.done,
                  onTap: () async {
                    TimeOfDay? result = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.dialOnly,
                      builder: (context, child) {
                        return Container(child: child);
                      },
                    );
                    if (result != null) {
                      scheduleTimeController.text =
                          "${result.hourOfPeriod}:${result.minute.toString().length == 1 ? "0${result.minute}" : result.minute} ${result.period.name.toUpperCase()}";
                    }
                  },
                ),
                SizedBox(height: 60.h),

                /// Save button
                AppButton(
                  width: double.infinity,
                  text: "Save & Continue",
                  opacity: isValidDetails() ? null : .2,
                  padding: EdgeInsets.symmetric(vertical: 16.r),
                  margin: EdgeInsets.symmetric(horizontal: 8.r),
                  textStyle: textStyle16WithW500(ColorConstants.whiteFFFFFF),
                  onTap: isValidDetails() ? () {} : null,
                ),
              ],
            ),
          ),
        ));
  }

  bool isValidDetails() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        AppUtils.isValidWeight(weightController.text) &&
        scheduleTimeController.text.isNotEmpty;
  }
}
