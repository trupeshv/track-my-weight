import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/core/constants/color_constants.dart';
import 'package:track_my_weight/core/constants/image_constants.dart';
import 'package:track_my_weight/core/constants/text_styles.dart';
import 'package:track_my_weight/core/navigator/app_router.gr.dart';
import 'package:track_my_weight/core/utils/notification_utils.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _startAnimations();
    initNotification();
    super.initState();
  }

  Future<void> _startAnimations() async {
    controller.forward().whenComplete(
      () {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            context.router.push(ProfileRoute());
          }
        });
      },
    );
  }

  Future<void> initNotification() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation = NotificationUtils()
          .notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      await androidImplementation?.requestNotificationsPermission();
    }
    if (Platform.isIOS) {
      await NotificationUtils()
          .notificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
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
