import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'Android/main_android_app.dart';
import 'Web/main_web_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      //running on android or ios device

      //Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(const MainAndroidApp());
    }
  } catch (e) {
    if (kIsWeb) {
      //running on web

      //Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(const MainWebApp());
    }
  }
}
