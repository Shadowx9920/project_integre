import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Views/error_page.dart';
import '../Views/main_android_page.dart';
import 'authentification_page.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const MainAndroidPage();
        } else if (snapshot.hasError) {
          return const ErrorPage(
            routeName: '',
          );
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
