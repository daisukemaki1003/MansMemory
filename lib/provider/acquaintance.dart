import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mans_memory/constants/keys.dart';
import '../models/acquaintance.dart';

final changedAcquaintanceNameStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController(text: ''));
final changedAcquaintanceAgeStateProvider =
    StateProvider.autoDispose((ref) => 0);

// final age = StateProvider.autoDispose((ref) => 0);

final changedAcquaintanceBirthdayStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController(text: ''));
final changedAcquaintanceBirthplaceStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController(text: ''));
final changedAcquaintanceResidenceStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController(text: ''));
final changedAcquaintanceHobbyStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController(text: ''));
final changedAcquaintanceHolidayStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController(text: ''));
final changedAcquaintanceOccupationStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController(text: ''));
final changedAcquaintanceMemoStateProvider =
    StateProvider.autoDispose((ref) => TextEditingController(text: ''));

final acquaintanceStateProvider = ChangeNotifierProvider<acquaintanceNotifier>(
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
      holiday: data[HOLIDAY],
      occupation: data[OCCUPATION],
      residence: data[RESIDENCE],
      birthday: data[BIRTHDAY],
      birthplace: data[BIRTHPLACE],
      age: data[AGE],
      memo: data[MEMO],
      icon: data[ICON],
      createdAt: data["createdAt"],
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchStream(
      String currentUserId) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(currentUserId)
        .collection(docName)
        .snapshots();
  }

  Future<String> create(String currentUserId, String inputName) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(currentUserId)
        .collection(docName)
        .add(
          {
            'createdAt': Timestamp.now(),
            NAME: inputName,
            AGE: -1,
            BIRTHDAY: '',
            BIRTHPLACE: '',
            RESIDENCE: '',
            HOLIDAY: -1,
            OCCUPATION: '',
            MEMO: '',
            ICON: '',
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
      {required String userId, required AcquaintanceModel acquaintance}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(userId)
        .collection(docName)
        .doc(acquaintance.acquaintanceId)
        .update({
      NAME: acquaintance.name,
      'createdAt': acquaintance.createdAt,
      AGE: acquaintance.age,
      BIRTHDAY: acquaintance.birthday,
      BIRTHPLACE: acquaintance.birthplace,
      RESIDENCE: acquaintance.residence,
      HOLIDAY: acquaintance.holiday,
      OCCUPATION: acquaintance.occupation,
      MEMO: acquaintance.memo,
      ICON: acquaintance.icon
    }).catchError((e) => throw ('ユーザーの編集に失敗しました。'));
    notifyListeners();
  }

  Future<void> setImage(
      {required String userId, required String acquaintanceId}) async {
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
          .doc(userId)
          .collection(docName)
          .doc(acquaintanceId)
          .update({ICON: imgUrl}).catchError((e) => throw ('ユーザーの編集に失敗しました。'));
      notifyListeners();
    }
  }

  Future<void> delete(
      {required String userId, required String acquaintanceId}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(userId)
        .collection(docName)
        .doc(acquaintanceId)
        .delete()
        .catchError((e) => throw ('ユーザーの編集に失敗しました。'));
  }
}
