import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class WebSettingsPage extends StatelessWidget {
  const WebSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const SettingsList(
        platform: DevicePlatform.web,
        sections: [],
      ),
    );
  }
}
