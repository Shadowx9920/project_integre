import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/compte.dart';
import '../Widgets/custom_text_field.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late int accType;

  @override
  void initState() {
    accType = 3;
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.7,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    hintText: "Name",
                    labelText: "Name",
                    icon: Icons.person,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Email",
                    labelText: "Email",
                    icon: Icons.email,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Password",
                    labelText: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ChipsChoice<int>.single(
                    value: accType,
                    onChanged: (int val) => setState(() => accType = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: const ['Admin', 'Responsable', 'Prof', 'Student'],
                      value: (int index, String item) => index,
                      label: (int index, String item) => item,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Compte newCompte = Compte(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          accType: accType,
                          id: Random().nextInt(1000000).toString(),
                        );
                        UsersController.createAccount(newCompte);
                        Navigator.pop(context);
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
