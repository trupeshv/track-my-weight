
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/application/bloc.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/image_constants.dart';
import 'package:track_my_weight/core/constants/text_styles.dart';
import 'package:track_my_weight/core/navigator/app_router.gr.dart';
import 'package:track_my_weight/core/persistence/preference_helper.dart';
import 'package:track_my_weight/models/user_model.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  UserDataModel? userData;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _startAnimations();
    getUserData();
    context.read<AppBloc>().add(InitNotification());
    super.initState();
  }

  Future<void> getUserData() async {
    userData = await PreferenceHelper.getUserData();
  }

  Future<void> _startAnimations() async {
    controller.forward().whenComplete(
      () {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            if (userData != null) {
              context.router.replace(const HomeRoute());
            } else {
              context.router.replace(ProfileRoute());
            }
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.whiteFFFFFF,
        body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.scale(
              scale: controller.value,
              child: child,
            );
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    ImageConstants.imageLogo,
                    width: 203.w,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Track My Weight",
                  style: textStyle26WithW600(ColorConstants.green77D5BE),
                )
              ],
            ),
          ),
        ));
  }
}
