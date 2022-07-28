import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider<UserNotifier>(
  (ref) => UserNotifier._(),
);

class UserNotifier extends ChangeNotifier {
  UserNotifier._();
  static UserNotifier instance = UserNotifier._();
  final collectionName = 'users';

  Future<void> create() async {
    User? user = FirebaseAuth.instance.currentUser;
    print("作成");
    print(user!.uid);
    print(user.email);

    try {
      if (await checkExistence(user)) return;
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'userId': user.uid,
          'email': user.email,
          'createdAt': Timestamp.now(),
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkExistence(User? user) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    return doc.exists;
  }

  void update() {}
}
