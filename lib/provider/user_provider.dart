import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final usersProvider =
    ChangeNotifierProvider<UserRepository>((ref) => UserRepository._());

class UserRepository extends ChangeNotifier {
  UserRepository._();
  static UserRepository instance = UserRepository._();

  Future<List<User>> fetch() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();

    final List<User> users = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String name = data['name'];
      final String? furigana = data['furigana'];
      final int? age = data['age'];
      final int? annualIncome = data['annual_income'];
      final String? educationalBackground = data['educational_background'];
      final List<dynamic>? hobby = data['hobby'];
      final List<dynamic>? holiday = data['holiday'];
      final String? image = data['image'];
      final String? birthplace = data['birthplace'];
      final String? occupation = data['occupation'];
      final String? residence = data['residence'];
      final Timestamp? birthday = data['birthday'];
      return User(
        uid: id,
        name: name,
        furigana: furigana,
        age: age,
        annualIncome: annualIncome,
        educationalBackground: educationalBackground,
        hobby: hobby,
        holiday: holiday,
        image: image,
        occupation: occupation,
        residence: residence,
        birthday: birthday!.toDate(),
        birthplace: birthplace,
      );
    }).toList();
    return users;
  }

  Future<void> add(UserTextEditingController controller) async {}
  void remove(User user) => print("remove");
}
