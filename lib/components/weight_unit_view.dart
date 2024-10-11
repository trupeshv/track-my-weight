import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/text_styles.dart';
import 'package:track_my_weight/models/enums.dart';

class WeightUnitView extends StatefulWidget {
  final Function(WeightUnit value) selectedValue;
  final bool? unitInKg;

  const WeightUnitView({super.key, required this.selectedValue, this.unitInKg});

  @override
  State<WeightUnitView> createState() => _WeightUnitViewState();
}

class _WeightUnitViewState extends State<WeightUnitView> with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    if (widget.unitInKg != null) {
      if (widget.unitInKg == true) {
        controller.animateTo(0, duration: const Duration(milliseconds: 400), curve: Curves.linear);
      } else {
        controller.animateTo(1, duration: const Duration(milliseconds: 400), curve: Curves.linear);
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: ColorConstants.whiteFFFFFF,
            border: Border.all(color: ColorConstants.greyAAAAAA)),
        child: TabBar(
          dividerColor: ColorConstants.transparent,
          controller: controller,
          padding: EdgeInsets.zero,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          indicatorSize: TabBarIndicatorSize.label,
          onTap: (index) {
            setState(() {
              controller.index = index;
              widget.selectedValue(controller.index == 0 ? WeightUnit.KG : WeightUnit.LB);
            });
          },
          isScrollable: false,
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            gradient: LinearGradient(
              colors: [
                ColorConstants.green009688.withOpacity(.5),
                ColorConstants.green00796B.withOpacity(.35),
              ],
            ),
          ),
          tabs: [
            _buildTab(label: WeightUnit.KG.name, isSelected: controller.index == 0),
            _buildTab(label: WeightUnit.LB.name, isSelected: controller.index == 1),
          ],
        ),
      ),
    );
  }

  Tab _buildTab({
    required String label,
    required bool isSelected,
  }) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          label,
          style: textStyle12WithW400(
              isSelected ? ColorConstants.black000000 : ColorConstants.grey828282),
        ),
      ),
    );
  }
}
