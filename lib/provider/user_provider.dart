import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final usersProvider =
    ChangeNotifierProvider<UserRepository>((ref) => UserRepository._());

class UserRepository extends ChangeNotifier {
  UserRepository._();
  static UserRepository instance = UserRepository._();

  final collectionName = 'users';

  Future<List<User>> fetch() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();

    final List<User> users = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String name = data['name'];
      final String? furigana = data['furigana'];
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
    await Future.delayed(Duration(seconds: 3));
    return users;
  }

  Future<void> add(UserDataTable userData) async {
    Map<String, dynamic> addData = {};
    userData.table1.forEach((key, value) => addData[key] = value.text);
    userData.table2.forEach((key, value) => addData[key] = value.text);
    userData.table3.forEach((key, value) => addData[key] = value.text);
    FirebaseFirestore.instance.collection(collectionName).add(addData);
  }

  void remove(User user) => print("remove");
}

      // 'name': controller.basicInformationController[]
      // 'furigana': furigana,
      // 'age': age,
      // 'annual_income': annual_income,
      // 'educational_background': educational_background,
      // 'hobby': hobby,
      // 'holiday': holiday,
      // 'image': image,
      // 'birthplace': birthplace,
      // 'occupation': occupation,
      // 'residence': residence,
      // 'birthday': birthday,