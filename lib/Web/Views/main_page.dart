import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Core/Database/Controllers/users_controller.dart';
import '../Lists/etablissement_list.dart';
import '../Lists/reunion_list.dart';
import '../Lists/users_list.dart';
import '../Pages/dashboard.dart';
import '../Pages/profile_widget.dart';
import '../Pages/settings_widget.dart';
import '../Pages/user_files.dart';
import '../Widgets/side_panel_web.dart';
import 'error_page.dart';

class MainWebPage extends StatefulWidget {
  const MainWebPage({Key? key}) : super(key: key);

  @override
  State<MainWebPage> createState() => _MainWebPageState();
}

class _MainWebPageState extends State<MainWebPage> {
  late List<bool> _isSelected;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UsersController.setCurrentAccount(
          FirebaseAuth.instance.currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _isSelected = List<bool>.filled(7, false);
          _isSelected[0] = true;
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isPortrait = constraints.maxWidth < constraints.maxHeight;
              double aspectRatio = isPortrait
                  ? constraints.maxWidth / constraints.maxHeight
                  : constraints.maxHeight / constraints.maxWidth;
              return Scaffold(
                body: WebSidePanel(
                  aspectRatio: aspectRatio,
                  isSelected: _isSelected,
                  tabData: _buildTabs(UsersController.currentUser!.accType),
                  tabs: _buildPages(UsersController.currentUser!.accType),
                ),
              );
            },
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

  List<List<Object>> _buildTabs(int accType) {
    switch (accType) {
      case 0:
        return const [
          [Icons.dashboard_rounded, "DashBoard"],
          [Icons.group, "Users"],
          [Icons.business, "Etablissements"],
          [Icons.calendar_month, "Reunions"],
          [Icons.folder, "Documents"],
          [Icons.person, "Profile"],
          [Icons.settings, "Settings"],
        ];
      case 1:
        return const [
          [Icons.group, "Users"],
          [Icons.business, "Etablissements"],
          [Icons.calendar_month, "Reunions"],
          [Icons.folder, "Documents"],
          [Icons.person, "Profile"],
          [Icons.settings, "Settings"],
        ];
      case 2:
        return const [
          [Icons.business, "Etablissements"],
          [Icons.calendar_month, "Reunions"],
          [Icons.folder, "Documents"],
          [Icons.person, "Profile"],
          [Icons.settings, "Settings"],
        ];
      case 3:
        return const [
          [Icons.calendar_month, "Reunions"],
          [Icons.folder, "Documents"],
          [Icons.person, "Profile"],
          [Icons.settings, "Settings"],
        ];
      default:
        return const [
          [Icons.settings, "Settings"],
        ];
    }
  }

  List<Widget> _buildPages(int accType) {
    switch (accType) {
      case 0:
        return const [
          DashBoard(),
          UsersListPage(),
          EtablissementListPage(),
          ReunionListPage(),
          UserFiles(),
          ProfileWidget(),
          SettingsWidget(),
        ];
      case 1:
        return const [
          UsersListPage(),
          EtablissementListPage(),
          ReunionListPage(),
          UserFiles(),
          ProfileWidget(),
          SettingsWidget(),
        ];
      case 2:
        return const [
          EtablissementListPage(),
          ReunionListPage(),
          UserFiles(),
          ProfileWidget(),
          SettingsWidget(),
        ];
      case 3:
        return const [
          ReunionListPage(),
          UserFiles(),
          ProfileWidget(),
          SettingsWidget(),
        ];
      default:
        return const [
          SettingsWidget(),
        ];
    }
  }
}
