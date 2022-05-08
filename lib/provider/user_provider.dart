import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/constants/keys.dart';
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

    final List<User> users = snapshot.docs.map(
      (DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String id = document.id;
        final String name = data[NAME];
        final String? furigana = data[FURIGANA];
        final Timestamp? birthday = data[BIRTHDAY];

        final List<dynamic>? hobby = data[HOBBY];
        final List<dynamic>? holiday = data[HOLIDAY];
        final String? birthplace = data[BIRTHPLACE];
        final String? residence = data[RESIDENCE];

        final String? occupation = data[OCCUPATION];
        final String? educationalBackground = data[EDUCATIONAL_BACKGROUND];
        final int? annualIncome = data[ANNUAL_INCOME];
        final String? image = data[IMAGE];

        return User(
            uid: id,
            name: name,
            furigana: furigana,
            annualIncome: annualIncome,
            educationalBackground: educationalBackground,
            hobby: hobby,
            holiday: holiday,
            occupation: occupation,
            residence: residence,
            birthday: birthday!.toDate(),
            birthplace: birthplace,
            image: image);
      },
    ).toList();
    await Future.delayed(Duration(seconds: 3));
    return users;
  }

  Future<void> add({
    required String name,
    required String? furigana,
    required Timestamp? birthday,
    required List<String>? hobby,
    required List<bool>? holiday,
    required String? birthplace,
    required String? residence,
    required String? occupation,
    required String? educationalBackground,
    required int? annualIncome,
    required String? image,
  }) async {
    FirebaseFirestore.instance.collection(collectionName).add({
      NAME: name,
      FURIGANA: furigana,
      BIRTHDAY: birthday,
      HOBBY: hobby,
      HOLIDAY: holiday,
      BIRTHPLACE: birthplace,
      RESIDENCE: residence,
      EDUCATIONAL_BACKGROUND: occupation,
      OCCUPATION: educationalBackground,
      ANNUAL_INCOME: annualIncome,
      IMAGE: image,
    });
  }

  void remove(User user) => print("remove");
}

List<int> stringToList(String listAsString) {
  return listAsString
      .split(',')
      .map<int>((String item) => int.parse(item))
      .toList();
}
