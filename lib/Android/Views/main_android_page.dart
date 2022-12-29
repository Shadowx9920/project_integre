import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Web/Widgets/profile_widget.dart';
import '../Widgets/home_widget.dart';
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
