import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../../Core/Database/Functions/db_provider.dart';
import '../../Core/colors.dart';
import '../Widgets/header_title.dart';

class MainWebPage extends StatefulWidget {
  const MainWebPage({super.key});

  @override
  State<MainWebPage> createState() => _MainWebPageState();
}

class _MainWebPageState extends State<MainWebPage> {
  final List<Widget> _pages = const [
    Center(child: Text("home")),
    ProfileWidget(),
    SettingsWidget(),
  ];
  late Widget _currentPage;

  @override
  void initState() {
    _currentPage = _pages[0];
    super.initState();
  }

  Widget _buildHeader(Size size) {
    return Container(
      color: WebColors.mainColor,
      height: size.height * 0.07,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          const FlutterLogo(
            size: 20,
          ),
          const Spacer(),
          HeaderButton(
            text: "Home",
            icon: Icons.home,
            onPressed: () {
              setState(() {
                _currentPage = _pages[0];
              });
            },
          ),
          HeaderButton(
            text: "Profile",
            icon: Icons.person,
            onPressed: () {
              setState(() {
                _currentPage = _pages[1];
              });
            },
          ),
          HeaderButton(
            text: "Settings",
            icon: Icons.settings,
            onPressed: () {
              setState(() {
                _currentPage = _pages[2];
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(Size size) {
    return Container(
      color: WebColors.secondaryColor,
      width: double.infinity,
      height: size.height * 0.08,
      child: Row(
        children: [
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Text("Contact Us >"),
              ),
              GestureDetector(
                onTap: () {
                  showAboutDialog(context: context);
                },
                child: const Text("About >"),
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: _buildFooter(size),
      body: Column(
        children: [
          _buildHeader(size),
          SizedBox(
            height: size.height * 0.8,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _currentPage,
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
          return SingleChildScrollView(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.1,
                      right: size.width * 0.1,
                    ),
                    child: WidgetCircularAnimator(
                      innerColor: Colors.blue,
                      outerColor: Colors.blue[300] as Color,
                      size: size.height * 0.4,
                      child: CircularProfileAvatar(
                        "",
                        cacheImage: true,
                        radius: size.height * 0.35,
                        backgroundColor: Colors.transparent,
                        borderWidth: 0,
                        borderColor: Colors.transparent,
                        child: (snapshot.data.photoURL != null)
                            ? Image.network(snapshot.data.photoURL)
                            : Icon(
                                Icons.person,
                                size: size.height * 0.1,
                              ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 10,
                    color: Colors.blue,
                  ),
                  SizedBox(width: size.width * 0.1),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          const Text("Name: "),
                          const SizedBox(width: 10),
                          if (snapshot.data.displayName != null)
                            Text(snapshot.data.displayName!),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Email: "),
                          const SizedBox(width: 10),
                          Text(snapshot.data.email!),
                          const SizedBox(width: 10),
                          (snapshot.data.emailVerified)
                              ? const Icon(Icons.verified)
                              : Container(),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text("Edit Profile"),
                            onPressed: () {
                              _modifyDialogue(context);
                            },
                          ),
                          const SizedBox(width: 20),
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

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return SettingsList(
      platform: DevicePlatform.web,
      sections: [
        SettingsSection(
          title: const Text('Theme'),
          tiles: [
            SettingsTile.switchTile(
              title: const Text('Dark Mode'),
              leading: const Icon(Icons.brightness_4),
              initialValue: Get.isDarkMode,
              onToggle: (bool value) {
                setState(() {
                  Get.changeTheme(value ? ThemeData.dark() : ThemeData.light());
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
