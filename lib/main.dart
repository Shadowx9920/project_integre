import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:prefs/prefs.dart';
import 'package:project_integre/Core/Database/Functions/etablissement_controller.dart';
import 'Core/Database/Models/etablissement.dart';
import 'firebase_options.dart';

import 'Android/main_android_app.dart';
import 'Web/main_web_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      // init prefs
      await Prefs.init();

      //Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      runApp(const MainAndroidApp());
    }
  } catch (e) {
    if (kIsWeb) {
      //Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      runApp(const MainWebApp());
    }
  }
}
