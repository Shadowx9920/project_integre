import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Core/Database/Controllers/users_controller.dart';
import '../Lists/etablissement_list.dart';
import '../Lists/reunion_list.dart';
import '../Lists/users_list.dart';
import '../Widgets/header_title.dart';
import '../Widgets/profile_widget.dart';
import '../Widgets/settings_widget.dart';
import 'error_page.dart';

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
    EtablissementListPage(),
    ReunionListPage(),
    ProfileWidget(),
    SettingsWidget(),
  ];
  late Widget _currentPage;

  @override
  void initState() {
    _currentPage = _pages[0];
    super.initState();
  }

  Widget _buildHeader(Size size, int accType) {
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
          ..._buildHeaderTabs(accType)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: UsersController.setCurrentAccount(
          FirebaseAuth.instance.currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    _buildHeader(size, UsersController.currentUser!.accType),
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
        } else if (snapshot.hasError) {
          return const ErrorPage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  _buildHeaderTabs(int accType) {
    switch (accType) {
      case 0:
        return [
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
            text: "Reunions",
            icon: Icons.calendar_today,
            onPressed: () {
              setState(() {
                _currentPage = _pages[3];
              });
            },
          ),
          HeaderButton(
            text: "Profile",
            icon: Icons.person,
            onPressed: () {
              setState(() {
                _currentPage = _pages[4];
              });
            },
          ),
          HeaderButton(
            text: "Settings",
            icon: Icons.settings,
            onPressed: () {
              setState(() {
                _currentPage = _pages[5];
              });
            },
          ),
        ];
      case 1:
        return [
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
            text: "Reunions",
            icon: Icons.calendar_today,
            onPressed: () {
              setState(() {
                _currentPage = _pages[3];
              });
            },
          ),
          HeaderButton(
            text: "Profile",
            icon: Icons.person,
            onPressed: () {
              setState(() {
                _currentPage = _pages[4];
              });
            },
          ),
          HeaderButton(
            text: "Settings",
            icon: Icons.settings,
            onPressed: () {
              setState(() {
                _currentPage = _pages[5];
              });
            },
          ),
        ];
      case 2:
        return [
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
            text: "Reunions",
            icon: Icons.calendar_today,
            onPressed: () {
              setState(() {
                _currentPage = _pages[3];
              });
            },
          ),
          HeaderButton(
            text: "Profile",
            icon: Icons.person,
            onPressed: () {
              setState(() {
                _currentPage = _pages[4];
              });
            },
          ),
          HeaderButton(
            text: "Settings",
            icon: Icons.settings,
            onPressed: () {
              setState(() {
                _currentPage = _pages[5];
              });
            },
          ),
        ];
      default:
        return [];
    }
  }
}
