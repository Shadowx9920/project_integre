import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../Models/etablissement.dart';

class EtablissmentController {
  static Future<bool> createEtablissement(Etablissement etablissement) async {
    try {
      await FirebaseFirestore.instance
          .collection('etablissement')
          .doc(etablissement.uid)
          .set(etablissement.toJson());

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> deleteEtablissement(String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('etablissement')
          .doc(uid)
          .delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<bool> updateEtablissement(Etablissement etablissement) async {
    try {
      await FirebaseFirestore.instance
          .collection('etablissement')
          .doc(etablissement.uid)
          .update(etablissement.toJson());

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<Etablissement?> getEtablissement(String uid) async {
    DocumentSnapshot? documentSnapshot;
    try {
      documentSnapshot = await FirebaseFirestore.instance
          .collection('etablissement')
          .doc(uid)
          .get();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (documentSnapshot != null && documentSnapshot.exists) {
      return Etablissement.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  static Stream<List<Etablissement>> getAllEtablissements() {
    try {
      return FirebaseFirestore.instance
          .collection('etablissement')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Etablissement.fromJson(doc.data()))
              .toList());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return const Stream.empty();
  }
}
