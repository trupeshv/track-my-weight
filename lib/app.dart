import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_my_weight/core/constants/constants.dart';
import 'package:track_my_weight/core/navigator/app_router.dart';
import 'package:track_my_weight/core/theme/app_theme.dart';

final _router = AppRouter();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();

  static AppState of(BuildContext context) => context.findRootAncestorStateOfType<AppState>()!;
}

class AppState extends State<App> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
    ));
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp.router(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              );
            },
            title: TRACK_MY_WEIGHT,
            debugShowCheckedModeBanner: false,
            backButtonDispatcher: RootBackButtonDispatcher(),
            routeInformationParser: _router.defaultRouteParser(),
            routerDelegate: _router.delegate(),
            theme: AppTheme.theme,
            locale: const Locale(LANG_ENGLISH),
          );
        });
  }
}
