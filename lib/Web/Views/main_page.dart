import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      height: size.height * 0.1,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          const FlutterLogo(
            size: 20,
          ),
          const Spacer(),
          HeaderButton(
            text: "Home",
            onPressed: () {
              setState(() {
                _currentPage = _pages[0];
              });
            },
          ),
          HeaderButton(
            text: "profile",
            onPressed: () {
              setState(() {
                _currentPage = _pages[1];
              });
            },
          ),
          HeaderButton(
            text: "Settings",
            onPressed: () {
              debugPrint("testtest");
              Navigator.pushNamed(context, "/Settings");
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
      height: size.height * 0.4,
      child: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contact Us",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.facebook)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.email)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.home)),
                    ],
                  ),
                ),
              )
            ],
          )),
          const Expanded(
              child: Center(
            child: FlutterLogo(
              size: 50,
            ),
          )),
          Expanded(
              child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      showAboutDialog(context: context);
                    },
                    child: const Text("About",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(size),
              SizedBox(
                height: size.height,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _currentPage,
                ),
              ),
              _buildFooter(size),
            ],
          ),
        ),
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                    Row(
                      children: [
                        const Text("Name: "),
                        Text(snapshot.data.displayName!),
                      ],
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Email: "),
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
