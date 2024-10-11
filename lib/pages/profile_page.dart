import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/components/app_button.dart';
import 'package:track_my_weight/components/app_field_view.dart';
import 'package:track_my_weight/components/weight_unit_view.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/image_constants.dart';
import 'package:track_my_weight/core/constants/text_styles.dart';
import 'package:track_my_weight/core/persistence/preference_helper.dart';
import 'package:track_my_weight/core/utils/device_utils.dart';
import 'package:track_my_weight/models/enums.dart';
import 'package:track_my_weight/models/user_model.dart';

import '../application/bloc.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  final bool isFromSetting;

  const ProfilePage({super.key, this.isFromSetting = false});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController scheduleTimeController = TextEditingController();
  WeightUnit selectedUnit = WeightUnit.KG;
  DateTime currentDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isFromSetting = false;
  UserDataModel? userData;

  @override
  void initState() {
    isFromSetting = widget.isFromSetting;
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    userData = await PreferenceHelper.getUserData();
    if(userData != null) {
      firstNameController.text = userData?.firstName ?? "";
      lastNameController.text = userData?.firstName ?? "";
      scheduleTimeController.text = userData?.scheduleTime != null
          ? "${userData?.scheduleTime?.hourOfPeriod}:${userData?.scheduleTime?.minute
          .toString()
          .length == 1 ? "0${userData?.scheduleTime?.minute}" : userData?.scheduleTime
          ?.minute} ${userData?.scheduleTime?.period.name.toUpperCase()}"
          : '';
      selectedUnit = userData?.weightUnit ?? selectedUnit;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.whiteFFFFFF,
        body: Align(
          alignment: isFromSetting ? Alignment.topCenter : Alignment.center,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: DeviceUtil.topPadding(context),
                ),
                Row(
                  children: [
                    if (isFromSetting) ...[
                      InkWell(
                        onTap: () {
                          context.router.maybePop();
                        },
                        child: Image.asset(
                          ImageConstants.imageBackArrow,
                          width: 48.r,
                          height: 48.r,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                    ],
                    Text(
                      isFromSetting ? "Edit Profile" : "Let's Get Started!",
                      style: textStyle26WithW600(ColorConstants.black000000),
                    ),
                  ],
                ),
                if (!isFromSetting) ...[
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Please enter your name and choose when you'd like to be reminded to record your weight each day.",
                    style: textStyle12WithW400(ColorConstants.greyAAAAAA),
                  ),
                ],
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
                      selectedTime = result;
                      setState(() {});
                    }
                  },
                ),
                SizedBox(height: 20.h),

                /// Current weight
                RichText(
                  text: TextSpan(
                    text: "Unit",
                    style: textStyle16WithW500(ColorConstants.black000000),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: textStyle16WithW500(Colors.red), // Red asterisk
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                WeightUnitView(
                  unitInKg: selectedUnit == WeightUnit.KG,
                  selectedValue: (value) {
                    if (value == WeightUnit.LB && selectedUnit != WeightUnit.LB) {
                    } else if (value == WeightUnit.KG && selectedUnit != WeightUnit.KG) {}
                    selectedUnit = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: 60.h),

                /// Save button
                AppButton(
                  width: double.infinity,
                  text: isFromSetting ? "Save" : "Save & Continue",
                  opacity: isValidDetails() ? null : .2,
                  padding: EdgeInsets.symmetric(vertical: 16.r),
                  margin: EdgeInsets.symmetric(horizontal: 8.r),
                  textStyle: textStyle16WithW500(ColorConstants.whiteFFFFFF),
                  onTap: isValidDetails()
                      ? () {
                          context.read<AppBloc>().add(SaveUserData(
                              userData: UserDataModel(
                                  firstName: firstNameController.text.trim(),
                                  lastName: lastNameController.text.trim(),
                                  weightUnit: selectedUnit,
                                  scheduleTime: selectedTime)));
                        }
                      : null,
                ),
                SizedBox(
                  height: DeviceUtil.bottomPadding(context),
                )
              ],
            ),
          ),
        ));
  }

  bool isValidDetails() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        scheduleTimeController.text.isNotEmpty;
  }
}
