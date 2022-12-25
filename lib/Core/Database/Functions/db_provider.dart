import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DBProvider {
  static Future<bool> updateUser(
      String displayName, String email, String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (displayName != user.displayName) {
          await user.updateDisplayName(displayName);
        }
        if (email != user.email) {
          await user.updateEmail(email);
        }
        if (password.isNotEmpty) {
          await user.updatePassword(password);
        }
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> updateAvatar(String path) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (path.isNotEmpty) {
          await user.updatePhotoURL(path);
        }
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }
}
