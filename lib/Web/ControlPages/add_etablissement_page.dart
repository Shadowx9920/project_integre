import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../Core/Database/Controllers/etablissement_controller.dart';
import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/compte.dart';
import '../../Core/Database/Models/etablissement.dart';
import '../Widgets/custom_text_field.dart';

class AddEtablissementPage extends StatefulWidget {
  const AddEtablissementPage({super.key});

  @override
  State<AddEtablissementPage> createState() => _AddEtablissementPageState();
}

class _AddEtablissementPageState extends State<AddEtablissementPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UsersController.getAllAccountsStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Layout(users: snapshot.data);
        } else if (snapshot.hasError) {
          return const Text("Error");
        } else {
          return const Text("Loading");
        }
      },
    );
  }
}

class Layout extends StatefulWidget {
  const Layout({Key? key, required this.users}) : super(key: key);
  final List<Compte> users;
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un établissement"),
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    icon: Icons.business,
                    labelText: "Name",
                    hintText: "Enter Name",
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: emailController,
                    icon: Icons.email,
                    obscureText: false,
                    hintText: 'Email',
                    labelText: 'Email',
                  ),
                  const SizedBox(height: 10),
                  DropdownButton2(
                    hint: const Text("Select User"),
                    value: selectedUser,
                    searchController: searchControllerForAdding,
                    items: [
                      for (Compte user in widget.users)
                        if (user.accType == 1)
                          DropdownMenuItem(
                            value: user,
                            child: Text(user.name),
                          )
                    ],
                    onChanged: (value) => setState(() {
                      selectedUser = value;
                    }),
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
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        EtablissementController.createEtablissement(
                          Etablissement(
                              name: nameController.text,
                              idResponsable: selectedUser!.id,
                              email: emailController.text),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Add"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
