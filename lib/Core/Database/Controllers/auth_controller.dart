import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:project_integre/Core/Database/Models/compte.dart';
import 'users_controller.dart';

class AuthController {
  static Future<bool> signInUsingEmail(String email, String password) async {
    try {
      bool usersAlreadyCreated =
          await UsersController.checkIfUserExists(email, password);
      if (usersAlreadyCreated) {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        return true;
      } else {
        debugPrint('user not found');
        return false;
      }
      // await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> signUpUsingEmail(
      String name, String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(name);
      await UsersController.createAccount(
        Compte(
          id: credential.user!.uid,
          email: email,
          password: password,
          accType: 3,
          name: name,
        ),
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> signInUsingGoogle() async {
    try {
      await FirebaseAuth.instance
          .signInWithPopup(GoogleAuthProvider())
          .then((value) {
        if (kDebugMode) {
          print(value);
        }
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> signUpUsingGoogle() async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
      await UsersController.createAccount(
        Compte(
            email: credential.user!.email!,
            accType: 3,
            id: credential.user!.uid,
            name: credential.user!.displayName!,
            password: ''),
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

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

        // update user in firestore
        UsersController.updateAccount(
          Compte(
            id: user.uid,
            email: email,
            password: password,
            accType: 3,
            name: displayName,
          ),
        );
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

  static Future<bool> deleteCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        // delete user in firestore
        UsersController.deleteAccount(user.uid);
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
