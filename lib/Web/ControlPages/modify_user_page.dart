import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/compte.dart';
import '../Widgets/custom_text_field.dart';

class ModifyUserPage extends StatefulWidget {
  const ModifyUserPage({Key? key, required this.user}) : super(key: key);

  final Compte user;
  @override
  State<ModifyUserPage> createState() => _ModifyUserPageState();
}

class _ModifyUserPageState extends State<ModifyUserPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late int accType;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController.text = widget.user.name;
    emailController.text = widget.user.email;
    passwordController.text = widget.user.password;
    accType = widget.user.accType;
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
                        UsersController.updateAccount(
                          widget.user.email,
                          widget.user.password,
                          Compte(
                            id: widget.user.id,
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            accType: accType,
                          ),
                        );
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
