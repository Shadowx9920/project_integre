import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Core/Database/Controllers/auth_controller.dart';
import '../../Core/Database/Controllers/reunion_controller.dart';
import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/compte.dart';
import '../../Core/Database/Models/reunion.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool _passwordVisible = false;

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

  _modifyDialogue(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Modify Profile"),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter your name",
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
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
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty && value.length < 6) {
                        return 'Please enter min. 6 characters';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () async {
                final isValid = formKey.currentState!.validate();
                if (!isValid) return;
                bool succes = await AuthController.updateUser(
                  nameController.text,
                  emailController.text,
                  passwordController.text,
                );
                if (succes) {
                  Get.back();
                  Get.snackbar(
                    "Success",
                    "Profile updated",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } else {
                  Get.back();
                  Get.snackbar(
                    "Error",
                    "Profile not updated",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      surfaceTintColor: Theme.of(context).primaryColor,
                      elevation: 8,
                      child: SizedBox(
                        width: size.width * 0.8,
                        height: size.height * 0.5,
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Name:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        snapshot.data.displayName,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Email:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        snapshot.data.email,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      snapshot.data.emailVerified
                                          ? const Icon(
                                              Icons.verified,
                                              color: Colors.green,
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                  snapshot.data.emailVerified
                                      ? const SizedBox()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Verify your email",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                await snapshot.data
                                                    .sendEmailVerification();
                                                Get.snackbar(
                                                  "Success",
                                                  "Verification email sent",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.green,
                                                  colorText: Colors.white,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.send,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Password:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        _passwordVisible
                                            ? UsersController
                                                .currentUser!.password
                                            : "***************",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                          onPressed: () => setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              }),
                                          icon: Icon(!_passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off))
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            const Positioned(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Profile:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            )),
                            Positioned(
                              top: 50,
                              left: 50,
                              child: CircularProfileAvatar(
                                "",
                                borderWidth: 2,
                                borderColor: Colors.black,
                                child: Icon(
                                  Icons.person,
                                  size: size.height * 0.1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: size.height * 0.3,
                      child: UsersReunion(user: UsersController.currentUser!),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15)),
                        child: const Icon(Icons.edit),
                        onPressed: () {
                          _modifyDialogue(context);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15)),
                        child: const Icon(Icons.logout),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}

class UsersReunion extends StatefulWidget {
  const UsersReunion({Key? key, required this.user}) : super(key: key);

  final Compte user;

  @override
  State<UsersReunion> createState() => _UsersReunionState();
}

class _UsersReunionState extends State<UsersReunion> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ReunionController.getReunionFuture(),
      builder: (context, AsyncSnapshot<List<Reunion>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              if (widget.user.id == snapshot.data![index].profId ||
                  snapshot.data![index].participants.contains(widget.user.id)) {
                return ListTile(
                  title: Text(snapshot.data![index].subject),
                  subtitle: Text(snapshot.data![index].date.toString()),
                );
              } else {
                return Container();
              }
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}
