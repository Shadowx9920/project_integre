import 'package:cloud_firestore/cloud_firestore.dart';
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
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          var querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .where('password', isEqualTo: password)
              .get();

          Compte compte = Compte.fromJson(querySnapshot.docs.first.data());

          await UsersController.updateAccount(
            compte.email,
            compte.password,
            Compte(
              id: FirebaseAuth.instance.currentUser!.uid,
              email: email,
              password: password,
              accType: compte.accType,
              name: compte.name,
            ),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password);
          }
        }
        return true;
      } else {
        debugPrint('user not found');
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> signUpUsingEmail(String email, String password) async {
    try {
      //UserCredential credential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // await credential.user!.updateDisplayName(name);
      // await UsersController.createAccount(
      //   Compte(
      //     id: credential.user!.uid,
      //     email: email,
      //     password: password,
      //     accType: 3,
      //     name: name,
      //   ),
      // );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  // static Future<bool> signInUsingGoogle() async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithPopup(GoogleAuthProvider())
  //         .then((value) {
  //       if (kDebugMode) {
  //         print(value);
  //       }
  //     });
  //     return true;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  //   return false;
  // }

  // static Future<bool> signUpUsingGoogle() async {
  //   try {
  //     UserCredential credential =
  //         await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
  //     await UsersController.createAccount(
  //       Compte(
  //           email: credential.user!.email!,
  //           accType: 3,
  //           id: credential.user!.uid,
  //           name: credential.user!.displayName!,
  //           password: ''),
  //     );
  //     return true;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  //   return false;
  // }

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
          email,
          password,
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

  static Future<bool> deleteCurrentUser(String email, String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        // delete user in firestore
        UsersController.deleteAccount(email, password);
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
