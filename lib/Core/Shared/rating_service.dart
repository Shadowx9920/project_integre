import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingService {
  double _rating = 0;
  double get rating => _rating;

  Future<bool> updateRatingInFirebase() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return false;
      }

      FirebaseFirestore.instance.collection('ratings').add(
        {
          'uid': user.uid,
          'rating': _rating,
          'timestamp': Timestamp.now(),
        },
      );

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  void showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rate this app'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          insetPadding: const EdgeInsets.all(10),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                const Text(
                    'If you enjoy using this app, would you mind taking a moment to rate it? It won’t take more than a minute. Thanks for your support!'),
                const SizedBox(height: 20),
                RatingBar.builder(
                  initialRating: 3.5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _rating = rating;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No thanks'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Rate it now'),
              onPressed: () {
                updateRatingInFirebase();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<Map<double, DateTime>> getRatingsFuture() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return {};
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('ratings')
              .where('uid', isEqualTo: user.uid)
              .get();

      Map<double, DateTime> ratings = {};

      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        ratings[document.data()['rating'] as double] =
            (document.data()['timestamp'] as Timestamp).toDate();
      }

      return ratings;
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }
}
