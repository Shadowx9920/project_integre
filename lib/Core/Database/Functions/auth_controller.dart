import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:project_integre/Core/Database/Models/Accounts/compte.dart';

import 'users_controller.dart';

class AuthController {
  static Future<bool> signInUsingEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      CurrentFireStoreUser.setCurrentUser(
        FirebaseAuth.instance.currentUser!.uid,
      );

      bool userExist = await CurrentFireStoreUser.checkIfCurrentUserExists();

      debugPrint(
        " Current user exist: $userExist",
      );
      return true;
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

class CurrentFireStoreUser {
  static Compte? currentUser;

  static Future<bool> setCurrentUser(String uid) async {
    try {
      debugPrint("setting current user: $uid");
      Compte? compte = await UsersController.getAccount(uid);
      if (compte != null) {
        debugPrint("Done");
        debugPrint("Current user: " + compte.email);
        currentUser = compte;
      } else {
        debugPrint("Failed");
        currentUser = null;
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> checkIfCurrentUserExists() async {
    bool userExists = false;
    try {
      debugPrint("Current user: $currentUser");
      if (currentUser != null) {
        UsersController.getAllAccounts().listen((event) {
          for (Compte account in event) {
            debugPrint("Comparing with: $account.id");
            if (account.id == currentUser!.id) {
              userExists = true;
              break;
            }
          }
        });
      } else {
        userExists = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return userExists;
  }

  //TODO: fix this
  static Future<bool> checkIfUserExists(String email) async {
    bool userExists = false;
    try {
      UsersController.getAllAccounts().listen((event) {
        for (Compte account in event) {
          if (account.email == email) {
            userExists = true;
            break;
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return userExists;
  }

  static Future<Compte?> getCurrentUser() async {
    Compte? compte;
    try {
      compte = await UsersController.getAccount(
          FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return compte;
  }

  static bool checkIfUserIsAdmin(Compte compte) {
    if (compte.accType == 0) {
      return true;
    }
    return false;
  }

  static bool checkIfUserIsResponsable(Compte compte) {
    if (compte.accType == 1) {
      return true;
    }
    return false;
  }

  static bool checkIfUserIsProfesseur(Compte compte) {
    if (compte.accType == 2) {
      return true;
    }
    return false;
  }

  static bool checkIfUserIsEtudiant(Compte compte) {
    if (compte.accType == 3) {
      return true;
    }
    return false;
  }
}
