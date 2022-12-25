import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:project_integre/Core/Database/Functions/db_provider.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import 'settings_page.dart';

class MainAndroidPage extends StatefulWidget {
  const MainAndroidPage({super.key});

  @override
  State<MainAndroidPage> createState() => _MainAndroidPageState();
}

class _MainAndroidPageState extends State<MainAndroidPage> {
  final List<Widget> _pages = [
    //TODO: Add pages
    const HomeWidget(),
    const Center(child: Text("List")),
    const Center(child: Text("Compare")),
    const ProfileWidget(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _pages[_selectedIndex],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Get.to(() => const AndroidSettingsPage());
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.blue,
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.blue,
          items: const <Widget>[
            Icon(Icons.home),
            Icon(Icons.list),
            Icon(Icons.compare_arrows),
            Icon(Icons.person),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(size.height * 0.1),
            child: Lottie.asset(
              "assets/animations/work.json",
              frameRate: FrameRate(60),
              repeat: true,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

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
                        debugPrint(value);
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
                bool succes = await DBProvider.updateUser(
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
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WidgetCircularAnimator(
                    innerColor: Colors.blue,
                    outerColor: Colors.blue[300] as Color,
                    size: size.height * 0.2,
                    child: CircularProfileAvatar(
                      "",
                      cacheImage: true,
                      radius: size.height * 0.15,
                      backgroundColor: Colors.transparent,
                      borderWidth: 0,
                      borderColor: Colors.transparent,
                      // onTap: () {
                      //   final ImagePicker picker = ImagePicker();
                      //   picker.pickImage(source: ImageSource.gallery).then(
                      //     (value) {
                      //       if (value != null) {
                      //         DBProvider.updateAvatar(value.path);
                      //       }
                      //     },
                      //   );
                      // },
                      child: (snapshot.data.photoURL != null)
                          ? Image.network(snapshot.data.photoURL)
                          : Icon(
                              Icons.person,
                              size: size.height * 0.1,
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (snapshot.data.displayName != null)
                    Text(snapshot.data.displayName!),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data.email!),
                      const SizedBox(width: 10),
                      (snapshot.data.emailVerified)
                          ? const Icon(Icons.verified)
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text("Edit Profile"),
                        onPressed: () {
                          _modifyDialogue(context);
                        },
                      ),
                      SizedBox(width: size.width * 0.1),
                      ElevatedButton(
                        child: const Text("Sign Out"),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
