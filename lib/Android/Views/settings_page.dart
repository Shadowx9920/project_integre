import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class AndroidSettingsPage extends StatelessWidget {
  const AndroidSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingsList(
        platform: DevicePlatform.android,
        sections: [],
      ),
    );
  }
}
