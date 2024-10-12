import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/text_styles.dart';
import 'package:track_my_weight/models/weight_model.dart';

class CalenderView extends StatefulWidget {
  final List<WeightModel> recordList;
  final Function(WeightModel? wieghtData) weightData;
  final DateTime firstDay;

  const CalenderView({
    super.key,
    required this.recordList,
    required this.weightData,
    required this.firstDay,
  });

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime firstDay = DateTime.utc(2024, 10, 1);
  List<WeightModel> recordList = [];

  @override
  Widget build(BuildContext context) {
    recordList = widget.recordList;
    firstDay = widget.firstDay;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: TableCalendar(
        firstDay: firstDay,
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
        weekNumbersVisible: false,
        headerStyle: const HeaderStyle(titleCentered: true, formatButtonVisible: false),
        selectedDayPredicate: (day) {
          return isSameDay(selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          widget.weightData(recordList
              .where(
                (element) => isSameDay(element.recordDate, selectedDay),
              )
              .firstOrNull);
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
          });
        },
        rangeStartDay: firstDay,
        rangeEndDay: DateTime.now(),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return Container(
              margin: EdgeInsets.all(4.r),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: textStyle14WithW500(ColorConstants.black000000),
                ),
              ),
            );
          },
          rangeHighlightBuilder: (context, day, focusedDay) {
            WeightModel? result = recordList
                .where(
                  (element) => isSameDay(element.recordDate, day),
                )
                .firstOrNull;
            return Container(
              margin: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: !focusedDay
                    ? Colors.transparent
                    : result?.weight == null
                        ? Colors.red
                        : ColorConstants.green00796B,
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: textStyle14WithW500(ColorConstants.whiteFFFFFF),
                ),
              ),
            );
          },
        ),
        calendarFormat: CalendarFormat.month,
        calendarStyle: CalendarStyle(
          rangeStartDecoration: const BoxDecoration(shape: BoxShape.circle),
          rangeEndDecoration: const BoxDecoration(shape: BoxShape.circle),
          withinRangeTextStyle: textStyle14WithW500(ColorConstants.whiteFFFFFF),
          defaultTextStyle: textStyle12WithW400(ColorConstants.black000000),
          weekendTextStyle: textStyle12WithW400(ColorConstants.black000000),
          todayTextStyle: textStyle14WithW500(ColorConstants.black000000),
          todayDecoration: const BoxDecoration(shape: BoxShape.circle),
          selectedDecoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
          outsideDaysVisible: false,
        ),
      ),
    );
  }
}
