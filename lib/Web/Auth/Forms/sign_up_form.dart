import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../main_web_app.dart';

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
          Container(
            width: widget.width / 3,
            height: widget.height / 11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: TextFormField(
              controller: _emailController,
              obscureText: false,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(),
                labelText: 'Login',
                prefixIcon: Icon(
                  Icons.person,
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
          Container(
            width: widget.width / 3,
            height: widget.height / 11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(),
                labelText: 'Password',
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
                ElevatedButton(
                  onPressed: signUp,
                  child: const Text('Sign Up'),
                ),
                ElevatedButton(
                  onPressed: widget.onClickSignUp,
                  child: const Text('Login'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(child: CircularProgressIndicator()),
    // );
    // try {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: _emailController.text.trim(),
    //     password: _passwordController.text.trim(),
    //   );
    // } on FirebaseAuthException catch (e) {
    //   Navigator.of(context).pop();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(e.message!),
    //     ),
    //   );
    // }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
