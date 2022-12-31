import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../Models/reunion.dart';

class ReunionController {
  static Future<bool> createReunion(Reunion reunion) async {
    try {
      await FirebaseFirestore.instance
          .collection('reunion')
          .doc(reunion.uid)
          .set(reunion.toJson());

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> deleteReunion(String uid) async {
    try {
      await FirebaseFirestore.instance.collection('reunion').doc(uid).delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> updateReunion(Reunion reunion) async {
    try {
      await FirebaseFirestore.instance
          .collection('reunion')
          .doc(reunion.uid)
          .update(reunion.toJson());

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<Reunion?> getReunion(String uid) async {
    DocumentSnapshot? documentSnapshot;
    try {
      documentSnapshot =
          await FirebaseFirestore.instance.collection('reunion').doc(uid).get();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (documentSnapshot != null && documentSnapshot.exists) {
      return Reunion.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  static Stream<List<Reunion>> getReunions() {
    try {
      return FirebaseFirestore.instance.collection('reunion').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Reunion.fromJson(doc.data()))
              .toList());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return const Stream.empty();
  }
}
