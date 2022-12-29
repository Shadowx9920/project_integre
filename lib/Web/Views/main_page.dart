import 'package:flutter/material.dart';

import '../../Core/Shared/colors.dart';
import '../Widgets/header_title.dart';
import '../Widgets/profile_widget.dart';
import '../Widgets/settings_widget.dart';

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
