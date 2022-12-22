import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Auth/auth_check.dart';
import 'Views/error_page.dart';
import 'Views/main_android_page.dart';
import 'Views/settings_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MainAndroidApp extends StatefulWidget {
  const MainAndroidApp({super.key});

  @override
  State<MainAndroidApp> createState() => _MainAndroidAppState();
}

class _MainAndroidAppState extends State<MainAndroidApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Project Name",
      navigatorKey: navigatorKey,
      routes: {
        "/": (context) => const AuthCheck(),
        "/Home": (context) => const MainAndroidPage(),
        "/404": (context) => const ErrorPage(
              routeName: '',
            ),
        "/Settings": (context) => const AndroidSettingsPage(),
      },
      initialRoute: "/",
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => ErrorPage(
            routeName: settings.name ?? "/Unknown",
          ),
        );
      },
    );
  }
}
