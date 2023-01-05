import 'package:chips_choice/chips_choice.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/Accounts/compte.dart';
import '../Widgets/scrollable_widget.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UsersController.getAllAccountsStream(),
      builder: (BuildContext conntextn, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return UsersList(
            data: snapshot.data,
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
    );
  }
}

class UsersList extends StatefulWidget {
  const UsersList({super.key, required this.data});

  final List<Compte> data;

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  bool _passwordsVisible = false;
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
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: ScrollableWidget(
              child: Wrap(
                spacing: 10,
                children: [
                  for (Compte compte in widget.data)
                    ProfileCard(size: size, compte: compte),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: _buildButtons(),
            ),
          ),
        ],
      ),
    );
  }

  _buildButtons() {
    return [
      const Spacer(),
      ElevatedButton(
        onPressed: () {
          setState(() {
            _passwordsVisible = !_passwordsVisible;
          });
        },
        child:
            Icon(_passwordsVisible ? Icons.visibility : Icons.visibility_off),
      ),
      const SizedBox(width: 10),
      ElevatedButton(
        child: const Text("Add Account"),
        onPressed: () => _addAccount(),
      ),
      const SizedBox(width: 10),
      ElevatedButton(
        child: const Text("Delete Selected Accounts"),
        onPressed: () {},
      ),
    ];
  }

  _addAccount() {
    nameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    accType = 0;
    Get.defaultDialog(
      title: "Add Account",
      content: Column(
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
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
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
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
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
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
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
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            //TODO: add account function
            Get.back();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key, required this.size, required this.compte})
      : super(key: key);

  final Size size;
  final Compte compte;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
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
    return Card(
      surfaceTintColor: Theme.of(context).primaryColor,
      elevation: 8,
      child: SizedBox(
        width: widget.size.width * 0.4,
        height: widget.size.height * 0.3,
        child: Stack(
          children: [
            Row(
              children: [
                CircularProfileAvatar(
                  "",
                  cacheImage: true,
                  radius: widget.size.height * 0.1,
                  backgroundColor: Colors.transparent,
                  borderWidth: 0,
                  borderColor: Colors.transparent,
                  child: (FirebaseAuth.instance.currentUser!.photoURL != null)
                      ? Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL!)
                      : Icon(
                          Icons.person,
                          size: widget.size.height * 0.1,
                        ),
                ),
                VerticalDivider(
                  color: Theme.of(context).primaryColor,
                  thickness: 1,
                  width: 10,
                  indent: 15,
                  endIndent: 15,
                ),
                const Spacer(),
                SizedBox(
                  height: widget.size.height * 0.25,
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(widget.compte.email),
                      const Spacer(),
                      Text(widget.compte.password),
                      const Spacer(),
                      Text(
                        (widget.compte.accType == 0)
                            ? "Admin"
                            : (widget.compte.accType == 1)
                                ? "Responsable"
                                : (widget.compte.accType == 2)
                                    ? "Professeur"
                                    : "Etudiant",
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(children: [
                IconButton(
                  splashRadius: 10,
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editAccount(widget.compte),
                ),
                IconButton(
                  splashRadius: 10,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Delete Account",
                      content: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                            "Are you sure you want to delete this account?"),
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
                            UsersController.deleteAccount(widget.compte.id);
                            Get.back();
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  _editAccount(Compte compte) {
    nameController.text = compte.name;
    emailController.text = compte.email;
    passwordController.text = compte.password;
    accType = compte.accType;
    Get.defaultDialog(
      title: "Edit Account",
      content: Column(
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
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
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
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
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
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
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
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            UsersController.updateAccount(
              Compte(
                id: compte.id,
                name: nameController.text,
                email: emailController.text,
                password: passwordController.text,
                accType: accType,
              ),
            );
            Get.back();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
