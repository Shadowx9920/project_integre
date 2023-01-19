import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/compte.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late int accType;

  @override
  void initState() {
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
    return ElevatedButton(
      child: const Text("Add User"),
      onPressed: () {
        accType = 3;
        Get.defaultDialog(
          title: "Add User",
          content: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0),
                    ),
                    focusColor: Theme.of(context).primaryColor,
                    contentPadding: const EdgeInsets.all(15),
                    border: const OutlineInputBorder(),
                    labelText: 'Name',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0),
                    ),
                    focusColor: Theme.of(context).primaryColor,
                    contentPadding: const EdgeInsets.all(15),
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0),
                    ),
                    focusColor: Theme.of(context).primaryColor,
                    contentPadding: const EdgeInsets.all(15),
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
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
                Get.back();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

class AddUserFromFile extends StatefulWidget {
  const AddUserFromFile({super.key});

  @override
  State<AddUserFromFile> createState() => _AddUserFromFileState();
}

class _AddUserFromFileState extends State<AddUserFromFile> {
  late DropzoneViewController dropZoneController;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      child: const Text("Add User From File"),
      onPressed: () => Get.defaultDialog(
        title: "Add User From File",
        content: SizedBox(
          height: size.height * 0.5,
          width: size.width * 0.5,
          child: Column(
            children: [
              const Text("Select a file"),
              const Spacer(),
              SizedBox(
                height: size.height * 0.3,
                child: DropzoneView(
                  operation: DragOperation.copy,
                  cursor: CursorType.grab,
                  onCreated: (DropzoneViewController controller) {
                    dropZoneController = controller;
                  },
                  onDrop: (dynamic value) async {
                    String fileName =
                        await dropZoneController.getFilename(value);
                    if (fileName.endsWith(".xlsx")) {
                      List<int> bytes =
                          await dropZoneController.getFileStream(value).last;
                      Excel excel = Excel.decodeBytes(bytes);

                      for (var table in excel.tables.keys) {
                        for (var row in excel.tables[table]!.rows) {
                          String? email;
                          String? password;
                          for (var cell in row) {
                            if (cell != null) {
                              if (cell.value.toString().contains("@")) {
                                email = cell.value.toString();
                              } else {
                                password = cell.value.toString();
                              }
                            }
                          }
                          if (email == null || password == null) {
                            continue;
                          } else {
                            UsersController.createAccount(Compte(
                              id: Random().nextInt(1000000).toString(),
                              name: '',
                              email: email,
                              password: password,
                              accType: 3,
                            ));
                          }
                        }
                      }
                    } else {
                      Get.snackbar(
                        "Error",
                        "File must be an excel file",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Cancel"),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
