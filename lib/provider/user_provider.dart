import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/constants/keys.dart';
import 'package:mans_memory/models/edit_user.dart';
import '../models/user.dart';

// final userNameProvider = StateProvider.autoDispose((ref) => TextEditingController());

final usersProvider =
    ChangeNotifierProvider<UserRepository>((ref) => UserRepository._());

class UserRepository extends ChangeNotifier {
  UserRepository._();
  static UserRepository instance = UserRepository._();

  final collectionName = 'users';

  User userCreate(DocumentSnapshot<Object?> document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return User(
        uid: document.id,
        name: data[NAME],
        furigana: data[FURIGANA],
        annualIncome: data[ANNUAL_INCOME],
        educationalBackground: data[EDUCATIONAL_BACKGROUND],
        // hobby: data[HOBBY],
        // holiday: data[HOLIDAY],
        occupation: data[OCCUPATION],
        residence: data[RESIDENCE],
        birthday: data[BIRTHDAY]?.toDate(),
        birthplace: data[BIRTHPLACE],
        image: data[IMAGE]);
  }

  Future<List<User>> fetch() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();

    final List<User> users = snapshot.docs
        .map((DocumentSnapshot document) => userCreate(document))
        .toList();
    return users;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchStream() {
    return FirebaseFirestore.instance.collection(collectionName).snapshots();
  }

  /// return user's UID
  Future<String> add(String inputName) async {
    if (inputName.isEmpty) throw ('名前を入力してください');

    return await FirebaseFirestore.instance
        .collection(collectionName)
        .add(
          {NAME: inputName},
        )
        .then((value) => value.id)
        .catchError((e) => throw ('ユーザーの登録に失敗しました。'));
  }

  Future<User> get(String uid) async {
    return userCreate(await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .get());
  }

  Future<void> set(String id, EditUser user) async {
    await FirebaseFirestore.instance.collection(collectionName).doc(id).set({
      NAME: user.name,
      FURIGANA: user.furigana,
      BIRTHDAY: user.birthday,
      HOBBY: user.birthplace,
      BIRTHPLACE: user.residence,
      EDUCATIONAL_BACKGROUND: user.educationalBackground,
      OCCUPATION: user.occupation,
      ANNUAL_INCOME: user.annualIncome,
      // HOLIDAY: hobby,
      // RESIDENCE: holiday,
      // IMAGE: image,
    }).catchError((e) => throw ('ユーザーの編集に失敗しました。'));
    notifyListeners();
  }

  void delete(String id) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .delete()
        .catchError((e) => throw ('ユーザーの編集に失敗しました。'));
  }
}
