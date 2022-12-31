import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../Models/Accounts/compte.dart';

class UsersController {
  static Future<bool> createAccount(Compte compte) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(compte.id)
          .set(compte.toJson());

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> deleteAccount(String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> updateAccount(Compte compte) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(compte.id)
          .update(compte.toJson());

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<Compte?> getAccount(String uid) async {
    DocumentSnapshot? documentSnapshot;
    try {
      documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
    } catch (e) {
      if (kDebugMode) {
        print(e);
        return null;
      }
    }
    if (documentSnapshot != null && documentSnapshot.exists) {
      return Compte.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  static Stream<List<Compte>> getAllAccounts() {
    try {
      return FirebaseFirestore.instance.collection('users').snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Compte.fromJson(doc.data())).toList());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return const Stream.empty();
  }

  static Future<bool> changeAccountType(String uid, int type) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'accType': type});

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }
}
