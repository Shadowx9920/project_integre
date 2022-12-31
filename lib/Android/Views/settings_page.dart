import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../Core/Shared/theme_service.dart';

class AndroidSettingsPage extends StatefulWidget {
  const AndroidSettingsPage({Key? key}) : super(key: key);

  @override
  State<AndroidSettingsPage> createState() => _AndroidSettingsPageState();
}

class _AndroidSettingsPageState extends State<AndroidSettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool isDark = GetStorage().read('isDarkMode') ?? false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile.switchTile(
                initialValue: isDark,
                leading: const Icon(Icons.format_paint),
                title: const Text('Dark Mode'),
                onToggle: (value) {
                  ThemeService().switchTheme();
                  isDark = GetStorage().read('isDarkMode');
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
