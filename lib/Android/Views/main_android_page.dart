import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.blue[200],
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Lottie.asset("assets/animations/work.json"),
        ],
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
