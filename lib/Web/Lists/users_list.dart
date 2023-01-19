import 'package:chips_choice/chips_choice.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/compte.dart';
import '../ControlPopUps/users_pop_ups.dart';
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
  late TextEditingController searchController;
  late int dropdownValue;
  String searchQuery = "";

  @override
  void initState() {
    searchController = TextEditingController();
    dropdownValue = 4;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          _buildSearchBar(size),
          const SizedBox(height: 10),
          Expanded(
            child: ScrollableWidget(
              child: SizedBox(
                width: size.width,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children: _wrapHelper(widget.data, searchQuery, dropdownValue,
                      UsersController.currentUser!.accType, size),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: _buildButtons(size),
            ),
          ),
        ],
      ),
    );
  }

  _wrapHelper(List<Compte> data, String searchQuery, int selectedType,
      int accType, Size size) {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].name.toLowerCase().contains(searchQuery) ||
          data[i].email.toLowerCase().contains(searchQuery)) {
        if (selectedType == 4) {
          if (accType == 0) {
            list.add(ProfileCard(size: size, compte: data[i]));
          } else {
            if (data[i].accType != 0) {
              list.add(ProfileCard(size: size, compte: data[i]));
            }
          }
        } else if (data[i].accType == selectedType) {
          if (accType == 0) {
            list.add(ProfileCard(size: size, compte: data[i]));
          } else {
            if (data[i].accType != 0) {
              list.add(ProfileCard(size: size, compte: data[i]));
            }
          }
        }
      }
    }
    return list;
  }

  _buildSearchBar(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBarAnimation(
          textEditingController: searchController,
          isOriginalAnimation: false,
          buttonBorderColour: Colors.black45,
          buttonWidget: const Icon(Icons.search),
          secondaryButtonWidget: const Icon(Icons.close),
          trailingWidget: const Icon(Icons.search),
          onChanged: (String value) {
            setState(() {
              searchQuery = value;
            });
          },
          onEditingComplete: () {
            debugPrint('onEditingComplete');
          },
          onPressButton: (bool? value) {
            debugPrint('onPressButton');
          },
        ),
        SizedBox(
          width: size.width * 0.15,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 30,
            value: dropdownValue,
            items: [
              const DropdownMenuItem(
                value: 3,
                child: Text("Etudiant"),
              ),
              const DropdownMenuItem(
                value: 2,
                child: Text("Professeur"),
              ),
              const DropdownMenuItem(
                value: 1,
                child: Text("Responsable"),
              ),
              if (UsersController.currentUser!.accType == 0)
                const DropdownMenuItem(
                  value: 0,
                  child: Text("Admin"),
                ),
              const DropdownMenuItem(
                value: 4,
                child: Text("Everyone"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                dropdownValue = value as int;
              });
            },
          ),
        ),
      ],
    );
  }

  _buildButtons(Size size) {
    return [
      const Spacer(),
      const AddUserFromFile(),
      const SizedBox(width: 10),
      const AddUser(),
    ];
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
    return Card(
      surfaceTintColor: Theme.of(context).primaryColor,
      elevation: 8,
      child: SizedBox(
        width: widget.size.width * 0.3,
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
                      Row(
                        children: [
                          Text(_passwordsVisible
                              ? widget.compte.password
                              : "************"),
                          IconButton(
                            icon: Icon(
                              !_passwordsVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20,
                            ),
                            splashRadius: 10,
                            onPressed: () {
                              setState(() {
                                _passwordsVisible = !_passwordsVisible;
                              });
                            },
                          ),
                        ],
                      ),
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
                            UsersController.deleteAccount(
                                widget.compte.email, widget.compte.password);
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
                source: (UsersController.currentUser!.accType == 0)
                    ? const ['Admin', 'Responsable', 'Prof', 'Student']
                    : const ['Responsable', 'Prof', 'Student'],
                value: (int index, String item) =>
                    (UsersController.currentUser!.accType == 0)
                        ? index
                        : index + 1,
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
            UsersController.updateAccount(
              compte.email,
              compte.password,
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
