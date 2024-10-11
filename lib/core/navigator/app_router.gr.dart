// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:track_my_weight/pages/profile_page.dart' as _i1;
import 'package:track_my_weight/pages/splash_page.dart' as _i2;

/// generated route for
/// [_i1.ProfilePage]
class ProfileRoute extends _i3.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i4.Key? key,
    bool isFromSetting = false,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            isFromSetting: isFromSetting,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<ProfileRouteArgs>(orElse: () => const ProfileRouteArgs());
      return _i1.ProfilePage(
        key: args.key,
        isFromSetting: args.isFromSetting,
      );
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    this.isFromSetting = false,
  });

  final _i4.Key? key;

  final bool isFromSetting;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, isFromSetting: $isFromSetting}';
  }
}

/// generated route for
/// [_i2.SplashPage]
class SplashRoute extends _i3.PageRouteInfo<void> {
  const SplashRoute({List<_i3.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.SplashPage();
    },
  );
}
