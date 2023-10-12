

import 'package:flutter/material.dart';
import 'package:posterbox/auth/screens/splashpage.dart';
import 'package:posterbox/sendPackage/screens/sendPackagescreen2.dart';
import 'common/widgets/bottomBar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case splashpage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const splashpage(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}