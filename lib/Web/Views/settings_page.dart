import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:settings_ui/settings_ui.dart';

class WebSettingsPage extends StatefulWidget {
  const WebSettingsPage({Key? key}) : super(key: key);

  @override
  State<WebSettingsPage> createState() => _WebSettingsPageState();
}

class _WebSettingsPageState extends State<WebSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        platform: DevicePlatform.web,
        sections: [
          SettingsSection(
            title: const Text('Theme'),
            tiles: [
              SettingsTile.switchTile(
                title: const Text('Dark Mode'),
                leading: const Icon(Icons.brightness_4),
                initialValue: Get.isDarkMode,
                onToggle: (bool value) {
                  setState(() {
                    Get.changeTheme(
                        value ? ThemeData.dark() : ThemeData.light());
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
