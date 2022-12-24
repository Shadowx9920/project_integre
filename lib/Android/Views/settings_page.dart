import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

class AndroidSettingsPage extends StatelessWidget {
  const AndroidSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        platform: DevicePlatform.android,
        sections: [
          SettingsSection(
            title: const Text('Section'),
            tiles: [
              SettingsTile.switchTile(
                title: const Text("Dark Mode"),
                leading: const Icon(Icons.dark_mode),
                initialValue: false,
                onToggle: (bool value) {
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
