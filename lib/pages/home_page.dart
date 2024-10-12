import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:track_my_weight/application/bloc.dart';
import 'package:track_my_weight/components/app_button.dart';
import 'package:track_my_weight/components/app_field_view.dart';
import 'package:track_my_weight/components/calender_view.dart';
import 'package:track_my_weight/components/legend_view.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/image_constants.dart';
import 'package:track_my_weight/core/constants/text_styles.dart';
import 'package:track_my_weight/core/navigator/app_router.gr.dart';
import 'package:track_my_weight/core/persistence/preference_helper.dart';
import 'package:track_my_weight/core/utils/app_utils.dart';
import 'package:track_my_weight/core/utils/device_utils.dart';
import 'package:track_my_weight/models/user_model.dart';
import 'package:track_my_weight/models/weight_model.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserDataModel? userData;
  TextEditingController weightController = TextEditingController();
  WeightModel? selectedRecord;
  WeightModel? todayRecord;
  DateTime firstRecordDate = DateTime.utc(2024, 10, 1);
  DateTime lastRecordDate = DateTime.now();
  List<WeightModel> recordList = [];

  @override
  void initState() {
    getUserData();
    setRecord();
    super.initState();
  }

  Future<void> getUserData() async {
    userData = await PreferenceHelper.getUserData();
    setState(() {});
  }

  void setRecord() async {
    recordList = await PreferenceHelper.getRecordList();
    recordList.sort((a, b) => a.recordDate!.compareTo(b.recordDate!));
    if (recordList.isNotEmpty) {
      firstRecordDate = recordList.first.recordDate ?? firstRecordDate;
      lastRecordDate =
          recordList.last.recordDate ?? lastRecordDate.subtract(const Duration(days: 1));
      todayRecord = recordList.last;
    } else {
      firstRecordDate = DateTime.now();
      lastRecordDate = DateTime.now();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteFFFFFF,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: DeviceUtil.topPadding(context), left: 16.r, right: 16.r, bottom: 16.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorConstants.green009688.withOpacity(.5),
                  ColorConstants.green00796B.withOpacity(.35),
                ],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "Welcome,",
                      style: textStyle16WithW400(ColorConstants.black000000),
                      children: [
                        TextSpan(
                          text: "\n${userData?.firstName} ${userData?.lastName}",
                          style: textStyle22WithW600(ColorConstants.black000000), // Red asterisk
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.router.push(ProfileRoute(isForUpdate: true));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Image.asset(
                      ImageConstants.imageSetting,
                      width: 40.r,
                      height: 40.r,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BlocConsumer<AppBloc, AppState>(listener: (context, state) {
                if (state is SavedWeight) {
                  todayRecord = state.saveWeight;
                  selectedRecord = todayRecord;
                  recordList.add(state.saveWeight);
                  setRecord();
                }

                if (state is SavedUserData) {
                  getUserData();
                  setRecord();
                }
              }, builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Today's Date
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      child: RichText(
                        text: TextSpan(
                          text: "Today's Date:",
                          style: textStyle14WithW400(ColorConstants.black000000),
                          children: [
                            TextSpan(
                              text: " ${AppUtils.getTimeInString(DateTime.now())}",
                              style:
                                  textStyle14WithW500(ColorConstants.black000000), // Red asterisk
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    /// Weight input section
                    if (recordList.isEmpty || !isSameDay(DateTime.now(), lastRecordDate))
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: AppFieldView(
                                text: "Record Today’s Weight (${userData?.weightUnit?.name})",
                                controller: weightController,
                                isRequiredText: true,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                onChanged: (value) {
                                  setState(() {});
                                },
                                hintText: "Enter today’s weight",
                                textStyle: textStyle14WithW500(ColorConstants.black000000),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            if (state is WeightLoading)
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.r),
                                  padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 16.r),
                                  child: const CircularProgressIndicator())
                            else
                              AppButton(
                                text: "Save",
                                opacity: isValidDetails() ? null : .2,
                                padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 16.r),
                                margin: EdgeInsets.symmetric(horizontal: 8.r),
                                textStyle: textStyle16WithW500(ColorConstants.whiteFFFFFF),
                                onTap: () {
                                  if (isValidDetails()) {
                                    context.read<AppBloc>().add(SaveRecord(
                                        weightData: WeightModel(
                                            weight: weightController.text,
                                            recordDate: DateTime.now(),
                                            unit: userData?.weightUnit)));
                                    weightController.clear();
                                    setState(() {});
                                  }
                                },
                              )
                          ],
                        ),
                      )
                    else
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                        child: RichText(
                          text: TextSpan(
                            text: "Your weight for today is ",
                            style: textStyle14WithW400(ColorConstants.black000000),
                            children: [
                              TextSpan(
                                text: todayRecord == null
                                    ? ""
                                    : "${AppUtils.showWeight(todayRecord!.weight!, todayRecord!.unit!, userData!.weightUnit!)} ${userData?.weightUnit?.name}.",
                                style:
                                    textStyle14WithW600(ColorConstants.black000000), // Red asterisk
                              ),
                              TextSpan(
                                text: " Keep up the consistency!",
                                style:
                                    textStyle14WithW400(ColorConstants.black000000), // Red asterisk
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const Divider(
                      height: 0,
                      color: ColorConstants.greyAAAAAA,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    ///Show recorded entry
                    if (selectedRecord != null && selectedRecord!.weight != null)
                      Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * .3),
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r), bottomLeft: Radius.circular(12.r)),
                          gradient: LinearGradient(
                            colors: [
                              ColorConstants.green009688.withOpacity(.5),
                              ColorConstants.green00796B.withOpacity(.35),
                            ],
                          ),
                        ),
                        child: Text(
                          "You recorded ${AppUtils.showWeight(selectedRecord!.weight!, selectedRecord!.unit!, userData!.weightUnit!)} ${userData?.weightUnit?.name}. 🎯",
                          style: textStyle14WithW500(ColorConstants.black000000),
                        ),
                      ),

                    ///Calender view
                    CalenderView(
                      recordList: recordList,
                      firstDay: firstRecordDate,
                      weightData: (weightData) {
                        setState(() {
                          selectedRecord = weightData;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    ///Legend view
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      child: const Wrap(
                        children: [
                          LegendView(color: Colors.blueAccent, text: "Selected Date"),
                          LegendView(
                              color: ColorConstants.green00796B,
                              text: "Weight logged successfully"),
                          LegendView(color: Colors.red, text: "Missed day (No weight recorded)"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  bool isValidDetails() {
    return weightController.text.isNotEmpty && AppUtils.isValidWeight(weightController.text);
  }
}
