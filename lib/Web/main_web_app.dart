import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Auth/auth_check.dart';
import 'Views/error_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MainWebApp extends StatefulWidget {
  const MainWebApp({super.key});

  @override
  State<MainWebApp> createState() => _MainWebAppState();
}

class _MainWebAppState extends State<MainWebApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Project Name",
      routes: {
        "/": (context) => const AuthCheck(),
        "/404": (context) => const ErrorPage(),
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
