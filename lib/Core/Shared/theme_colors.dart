import 'package:flutter/material.dart';

class ThemeColors {
  static final dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: Colors.purple,
    primaryColorDark: Colors.purple[800],
    primaryColorLight: Colors.purple[200],
    colorScheme: const ColorScheme.dark(
        primary: Colors.purple, secondary: Colors.purple),
  );

  static final light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    primaryColorDark: Colors.blue[800],
    primaryColorLight: Colors.blue[200],
    colorScheme: const ColorScheme.light(primary: Colors.blue),
  );
}
