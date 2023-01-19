import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Core/Database/Controllers/etablissement_controller.dart';
import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/compte.dart';
import '../../Core/Database/Models/etablissement.dart';

class AddEtablissement extends StatefulWidget {
  const AddEtablissement({super.key});

  @override
  State<AddEtablissement> createState() => _AddEtablissementState();
}

class _AddEtablissementState extends State<AddEtablissement> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  late TextEditingController searchControllerForAdding;

  Compte? selectedUser;
  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    searchControllerForAdding = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    searchControllerForAdding.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Add Etablissement"),
      onPressed: () => Get.defaultDialog(
        title: "Add Etablissement",
        content: Padding(
          padding: const EdgeInsets.all(25.0),
          child: StreamBuilder(
            stream: UsersController.getAllAccountsStream(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    TextField(
                      controller: nameController,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0),
                        ),
                        focusColor: Theme.of(context).primaryColor,
                        contentPadding: const EdgeInsets.all(15),
                        border: const OutlineInputBorder(),
                        labelText: 'Name',
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        prefixIcon: Icon(
                          Icons.business,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0),
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
                    DropdownButton2(
                      hint: const Text("Select User"),
                      value: selectedUser,
                      searchController: searchControllerForAdding,
                      items: [
                        for (Compte user in snapshot.data)
                          if (user.accType == 1)
                            DropdownMenuItem(
                              value: user,
                              child: Text(user.name),
                            )
                      ],
                      onChanged: (value) => setState(() {
                        selectedUser = value;
                      }),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              EtablissementController.createEtablissement(
                Etablissement(
                    name: nameController.text,
                    idResponsable: selectedUser!.id,
                    email: emailController.text),
              );
              Get.back();
            },
            child: const Text("Add"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}

class ModifyEtablissement extends StatefulWidget {
  const ModifyEtablissement({super.key, required this.etablissement});
  final Etablissement etablissement;
  @override
  State<ModifyEtablissement> createState() => _ModifyEtablissementState();
}

class _ModifyEtablissementState extends State<ModifyEtablissement> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController searchControllerForModifying;
  late Compte? selectedUser;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.etablissement.name);
    emailController = TextEditingController(text: widget.etablissement.email);
    searchControllerForModifying = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    searchControllerForModifying.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 10,
      icon: const Icon(Icons.edit),
      onPressed: () => Get.defaultDialog(
        title: "Add Etablissement",
        content: Padding(
          padding: const EdgeInsets.all(25.0),
          child: StreamBuilder(
            stream: UsersController.getAllAccountsStream(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                selectedUser = null;
                return Column(
                  children: [
                    TextField(
                      controller: nameController,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0),
                        ),
                        focusColor: Theme.of(context).primaryColor,
                        contentPadding: const EdgeInsets.all(15),
                        border: const OutlineInputBorder(),
                        labelText: 'Name',
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        prefixIcon: Icon(
                          Icons.business,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0),
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
                    DropdownButton2(
                      hint: const Text("Select User"),
                      value: selectedUser,
                      searchController: searchControllerForModifying,
                      items: [
                        for (Compte user in snapshot.data)
                          if (user.accType == 1)
                            DropdownMenuItem(
                              value: user,
                              child: Text(user.name),
                            )
                      ],
                      onChanged: (value) => setState(() {
                        selectedUser = value;
                      }),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                selectedUser = null;
                return const Center(
                  child: Text("Error"),
                );
              } else {
                selectedUser = null;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              EtablissementController.updateEtablissement(Etablissement(
                name: nameController.text,
                idResponsable: selectedUser!.id,
                email: emailController.text,
              ));
              Get.back();
            },
            child: const Text("Modify"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
