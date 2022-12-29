import 'package:flutter/material.dart';

import 'Forms/login_page.dart';
import 'Forms/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(
          onClickSignUp: toggle,
        )
      : SignUpPage(
          onClickSignUp: toggle,
        );

  void toggle() {
    setState(() => isLogin = !isLogin);
  }
}
