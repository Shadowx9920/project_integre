import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:settings_ui/settings_ui.dart';

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
    const SettingsWidget(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.blue[300],
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

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          tiles: [
            SettingsTile.switchTile(
              initialValue: true,
              leading: const Icon(Icons.format_paint),
              title: const Text('Dark Mode'),
              onToggle: (value) {
                Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          ],
        ),
      ],
    );
  }
}
