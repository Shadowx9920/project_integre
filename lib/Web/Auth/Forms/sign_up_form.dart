import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_integre/Core/Database/Functions/auth_controller.dart';

import '../../../Core/Shared/google_logo.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(
      {Key? key,
      required this.width,
      required this.height,
      required this.onClickSignUp})
      : super(key: key);

  final double width;
  final double height;

  final VoidCallback onClickSignUp;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    _nameController = TextEditingController();
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
          const SizedBox(height: 60),
          SizedBox(
            width: widget.width / 3,
            child: TextFormField(
              cursorColor: Colors.blue,
              controller: _nameController,
              obscureText: false,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                focusColor: Colors.blue,
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(),
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.blue),
                prefixIcon: Icon(
                  Icons.person,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value != null && !EmailValidator.validate(value)) {
                  return 'Enter a valid email';
                }
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty && value.length < 6) {
                  return 'Please enter min. 6 characters';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: widget.width / 3,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'Already have an account?',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' Login',
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
                    AuthController.signUpUsingGoogle();
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

  Future signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      Get.snackbar('Error', 'Please enter valid data');
      return;
    }

    AuthController.signUpUsingEmail(_nameController.text.trim(),
        _emailController.text.trim(), _passwordController.text.trim());
  }
}
