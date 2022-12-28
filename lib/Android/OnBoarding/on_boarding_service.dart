import 'package:flutter/material.dart';
import 'package:prefs/prefs.dart';
import '../Auth/auth_check.dart';
import 'on_boarding_screen.dart';

class OnBoardingService extends StatefulWidget {
  const OnBoardingService({super.key});

  @override
  State<OnBoardingService> createState() => _OnBoardingServiceState();
}

class _OnBoardingServiceState extends State<OnBoardingService> {
  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> isFirstOpen = SharedPreferences.getInstance();
    return FutureBuilder(
      future: isFirstOpen,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.getBool('showHome') == true
              ? const AuthCheck()
              : const OnBoardingScreen();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
