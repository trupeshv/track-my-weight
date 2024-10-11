import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CupertinoRoute(page: SplashRoute.page, initial: true),
        CupertinoRoute(page: ProfileRoute.page),
      ];
}
