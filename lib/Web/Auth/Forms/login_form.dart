import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_integre/Core/Database/Controllers/auth_controller.dart';

import '../../../Core/Shared/google_logo.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.width,
    required this.height,
    required this.onClickSignUp,
  }) : super(key: key);
  final double width;
  final double height;
  final VoidCallback onClickSignUp;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Image(
              width: widget.height / 6,
              height: widget.height / 6,
              image: const AssetImage('assets/images/Logo-UIR.png'),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 80),
          SizedBox(
            width: widget.width / 3,
            child: TextFormField(
              cursorColor: Colors.blue,
              controller: _emailController,
              obscureText: false,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                focusColor: Colors.blue,
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.blue),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: widget.width / 3,
            child: TextFormField(
              cursorColor: Colors.blue,
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                focusColor: Colors.blue,
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.blue),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: widget.width / 3,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                widget.onClickSignUp();
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    AuthController.signInUsingGoogle();
                  },
                  child: const GoogleLogo(
                    size: 20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future signIn() async {
    await AuthController.signInUsingEmail(
        _emailController.text, _passwordController.text);
  }
}
