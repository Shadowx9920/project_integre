import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Views/error_page.dart';
import '../Views/main_page.dart';
import 'authentification_page.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: FirebaseAuth.instance.currentUser,
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MainWebPage();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const ErrorPage();
        } else {
          return const AuthenticatePage();
        }
      },
    );
  }
}
