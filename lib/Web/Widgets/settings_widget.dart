import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../Core/Shared/rating_service.dart';
import '../../Core/Shared/theme_service.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDark = GetStorage().read('isDarkMode') ?? false;
    return SettingsList(
      platform: DevicePlatform.web,
      sections: [
        SettingsSection(
          title: const Text('Theme'),
          tiles: [
            SettingsTile.switchTile(
              activeSwitchColor: Theme.of(context).primaryColor,
              title: const Text('Dark Mode'),
              leading: const Icon(Icons.brightness_4),
              initialValue: isDark,
              onToggle: (bool value) {
                ThemeService().switchTheme();
                isDark = GetStorage().read('isDarkMode');
                setState(() {});
              },
            ),
            SettingsTile.navigation(
              title: const Text("Rate Us"),
              enabled: true,
              leading: const Icon(Icons.star),
              trailing: const Icon(Icons.arrow_forward_ios),
              onPressed: (context) {
                RatingService rate = RatingService();
                rate.showRatingDialog(context);
              },
            ),
            SettingsTile.navigation(
              title: const Text("Contact Us"),
              enabled: true,
              leading: const Icon(Icons.contact_mail),
              trailing: const Icon(Icons.arrow_forward_ios),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              title: const Text("About And Licenses"),
              enabled: true,
              leading: const Icon(Icons.star),
              trailing: const Icon(Icons.arrow_forward_ios),
              onPressed: (context) {
                showAboutDialog(context: context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
