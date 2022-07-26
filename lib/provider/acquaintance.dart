import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mans_memory/constants/keys.dart';
import 'package:mans_memory/models/edit_acquaintance.dart';
import '../models/acquaintance.dart';

final acquaintanceProvider = ChangeNotifierProvider<acquaintanceNotifier>(
    (ref) => acquaintanceNotifier._());

class acquaintanceNotifier extends ChangeNotifier {
  acquaintanceNotifier._();
  static acquaintanceNotifier instance = acquaintanceNotifier._();
  final collectionName = 'users';
  final docName = 'acquaintance';

  AcquaintanceModel acquaintanceCreate(DocumentSnapshot<Object?> document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    print(data[NAME]);
    print(data["createdAt"]);
    return AcquaintanceModel(
      acquaintanceId: document.id,
      name: data[NAME],
      hobby: data[HOBBY],
      holiday: data[HOLIDAY],
      occupation: data[OCCUPATION],
      residence: data[RESIDENCE],
      birthday: data[BIRTHDAY]?.toDate(),
      birthplace: data[BIRTHPLACE],
      age: data[AGE],
      memo: data[MEMO],
      icon: data[ICON],
      createdAt: data["createdAt"],
    );
  }

  // Future<List<User>> fetch() async {
  //   final QuerySnapshot snapshot =
  //       await FirebaseFirestore.instance.collection(collectionName).doc().collection(docName).get();

  //   final List<User> acquaintance = snapshot.docs
  //       .map((DocumentSnapshot document) => userCreate(document))
  //       .toList();
  //   return acquaintance;
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchStream(
      String currentUserId) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(currentUserId)
        .collection(docName)
        .snapshots();
  }

  // Future<String> create(String currentUserId, String inputName) async {}

  // /// return user's UID
  // Future<String> add(String currentUserId, String inputName) async {
  //   if (inputName.isEmpty) throw ('名前を入力してください');

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection(collectionName)
  //         .doc(currentUserId)
  //         .collection(docName)
  //         .add(
  //       {
  //         NAME: inputName,
  //         'createdAt': FieldValue.serverTimestamp(),
  //         'age': null,
  //         'birthday': null,
  //         'birthplace': null,
  //         'residence': null,
  //         'hobby': null,
  //         'holiday': null,
  //         'occupation': null,
  //         'memo': null,
  //         'icon': null,
  //       },
  //     );
  //     throw ('ユーザーの登録');
  //   } catch (e) {
  //     print(e);
  //     throw ('ユーザーの登録に失敗しました。');
  //   }

  Future<String> add(String currentUserId, String inputName) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(currentUserId)
        .collection(docName)
        .add(
          {
            'createdAt': Timestamp.now(),
            NAME: inputName,
            'age': null,
            'birthday': null,
            'birthplace': null,
            'residence': null,
            'hobby': null,
            'holiday': null,
            'occupation': null,
            'memo': null,
            'icon': null,
          },
        )
        .then((value) => value.id)
        .catchError((e) {
          print(e);
          throw ('ユーザーの登録に失敗しました。');
        });
  }

  Future<AcquaintanceModel> get(String currentUserId, String uid) async {
    return acquaintanceCreate(await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(currentUserId)
        .collection(docName)
        .doc(uid)
        .get());
  }

  Future<void> set(
      String currentUserId, String uuid, EditAcquaintance user) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(currentUserId)
        .collection(docName)
        .doc(uuid)
        .update({
      NAME: user.name,
      FURIGANA: user.furigana,
      BIRTHDAY: user.birthday,
      HOBBY: user.birthplace,
      BIRTHPLACE: user.residence,
      OCCUPATION: user.occupation,
      // HOLIDAY: hobby,
      // RESIDENCE: holiday,
      // IMAGE: image,
    }).catchError((e) => throw ('ユーザーの編集に失敗しました。'));
    notifyListeners();
  }

  Future<void> setImage(String currentUserId, String uuid) async {
    // ストレージに保存
    final ImagePicker _picker = ImagePicker();
    final imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      final doc = FirebaseFirestore.instance.collection('icons').doc();
      final task = await FirebaseStorage.instance
          .ref('icons/${doc.id}')
          .putFile(File(imageFile.path));

      // firestoreに画像パスを保存
      final imgUrl = await task.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(currentUserId)
          .collection(docName)
          .doc(uuid)
          .update({ICON: imgUrl}).catchError((e) => throw ('ユーザーの編集に失敗しました。'));
      notifyListeners();
    }
  }

  void delete(String userId, String id) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(userId)
        .collection(docName)
        .doc(id)
        .delete()
        .catchError((e) => throw ('ユーザーの編集に失敗しました。'));
  }
}
