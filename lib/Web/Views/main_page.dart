import 'package:flutter/material.dart';

import '../Lists/users_list.dart';
import '../Tables/etablissment_table.dart';
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
    Center(
      child: Text("Home"),
    ),
    UsersListPage(),
    EtablissementsTable(),
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
      color: Theme.of(context).primaryColor,
      height: size.height * 0.07,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo-UIR.png',
            height: 50,
            width: 50,
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
            text: "Users",
            icon: Icons.people,
            onPressed: () {
              setState(() {
                _currentPage = _pages[1];
              });
            },
          ),
          HeaderButton(
              text: 'Etablissements',
              onPressed: () {
                setState(() {
                  _currentPage = _pages[2];
                });
              },
              icon: Icons.business),
          HeaderButton(
            text: "Profile",
            icon: Icons.person,
            onPressed: () {
              setState(() {
                _currentPage = _pages[3];
              });
            },
          ),
          HeaderButton(
            text: "Settings",
            icon: Icons.settings,
            onPressed: () {
              setState(() {
                _currentPage = _pages[4];
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(size),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _currentPage,
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Copyright \u00A9 Yorastd Company. All rights reserved.',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
