import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserImage {
  String? documentId;
  String? imageURL;
  Timestamp? createdAt;

  /// ローカル変数
  int? id;

  /// コンストラクタ
  UserImage({
    this.documentId,
    this.imageURL,
    this.createdAt,
    this.id,
  });

  /// インスタンスを生成
  factory UserImage.create() {
    return UserImage(
      id: Random().nextInt(99999),
    );
  }

  /// FireStoreからインスタンスを生成
  factory UserImage.fromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final String documentId = doc.id;
    final String imageURL = data['imageURL'];
    final Timestamp createdAt = data['createdAt'];
    return UserImage(
      documentId: documentId,
      imageURL: imageURL,
      createdAt: createdAt,
    );
  }
}
