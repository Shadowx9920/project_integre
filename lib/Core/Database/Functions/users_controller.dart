class UsersController {
  // // Path: lib\Core\Database\Functions\users_controller.dart
  // static Future<void> addUser(User user) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user.uid)
  //       .set(user.toJson());
  // }

  // // Path: lib\Core\Database\Functions\users_controller.dart
  // static Future<void> updateUser(User user) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user.uid)
  //       .update(user.toJson());
  // }

  // // Path: lib\Core\Database\Functions\users_controller.dart
  // static Future<void> deleteUser(String uid) async {
  //   await FirebaseFirestore.instance.collection('users').doc(uid).delete();
  // }

  // // Path: lib\Core\Database\Functions\users_controller.dart
  // static Future<User> getUser(String uid) async {
  //   DocumentSnapshot documentSnapshot =
  //       await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //   return User.fromJson(documentSnapshot.data());
  // }

  // // Path: lib\Core\Database\Functions\users_controller.dart
  // static Stream<List<User>> getUsers() {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((doc) => User.fromJson(doc.data()))
  //           .toList());
  // }
}
