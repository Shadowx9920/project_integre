import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

class AndroidSettingsPage extends StatelessWidget {
  const AndroidSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
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
      ),
    );
  }
}
